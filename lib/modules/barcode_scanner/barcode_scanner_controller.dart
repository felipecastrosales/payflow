import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:camera/camera.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';

import 'package:payflow/shared/themes/app_images.dart';

import 'package:payflow/modules/barcode_scanner/barcode_scanner_status.dart';

class BarcodeScannerController extends ChangeNotifier {
  final barcodeScanner = GoogleMlKit.vision.barcodeScanner();

  final statusNotifier = ValueNotifier<BarcodeScannerStatus>(
    BarcodeScannerStatus(),
  );

  InputImage? imagePicker;
  CameraController? cameraController;
  bool _disposed = false;

  BarcodeScannerStatus get status => statusNotifier.value;
  set barCodeStatus(BarcodeScannerStatus status) =>
      statusNotifier.value = status;

  void getAvailableCameras() async {
    try {
      final response = await availableCameras();
      final camera = response.firstWhere(
        (element) => element.lensDirection == CameraLensDirection.back,
      );
      cameraController = CameraController(
        camera,
        ResolutionPreset.max,
        enableAudio: false,
      );
      await cameraController?.initialize();
      scanWithCamera();
      listenCamera();
    } catch (e, s) {
      barCodeStatus = BarcodeScannerStatus.error(e.toString());
      debugPrint('Error when getting camera ${e.toString()}');
      debugPrint('Stack when getting camera ${s.toString()}');
    }
  }

  Future<void> scannerBarCode(InputImage inputImage) async {
    try {
      final barcodes = await barcodeScanner.processImage(inputImage);
      String? barcode;
      for (Barcode item in barcodes) {
        barcode = item.displayValue;
      }

      if (barcode != null && status.barcode.isEmpty) {
        barCodeStatus = BarcodeScannerStatus.barcode(barcode);
        cameraController?.dispose();
        await barcodeScanner.close();
      }

      return;
    } catch (e) {
      debugPrint('Error when scanning barcode ${e.toString()}');
      debugPrint('Stack when scanning barcode ${e.toString()}');
    }
  }

  void scanWithImagePicker() async {
    final response = await ImagePicker().pickImage(source: ImageSource.gallery);
    final inputImage = InputImage.fromFilePath(
      response?.path ?? AppImages.logomini,
    );

    scannerBarCode(inputImage);
  }

  void scanWithCamera() {
    barCodeStatus = BarcodeScannerStatus.available();
    Future.delayed(
      const Duration(seconds: 10),
      () {
        barCodeStatus = BarcodeScannerStatus.available();
        if (status.hasBarcode == false) {
          barCodeStatus =
              BarcodeScannerStatus.error('Timeout de leitura de boleto');
        }
      },
    );
  }

  void listenCamera() {
    if (cameraController?.value.isStreamingImages == false) {
      cameraController?.startImageStream((cameraImage) async {
        if (status.stopScanner == false) {
          try {
            final allBytes = WriteBuffer();
            for (Plane plane in cameraImage.planes) {
              allBytes.putUint8List(plane.bytes);
            }
            final bytes = allBytes.done().buffer.asUint8List();
            final imageSize = Size(
              cameraImage.width.toDouble(),
              cameraImage.height.toDouble(),
            );
            const imageRotation = InputImageRotation.rotation0deg;
            final inputImageFormat =
                InputImageFormatValue.fromRawValue(cameraImage.format.raw) ??
                    InputImageFormat.nv21;
            final planeData = cameraImage.planes.map(
              (plane) {
                return InputImagePlaneMetadata(
                  bytesPerRow: plane.bytesPerRow,
                  height: plane.height,
                  width: plane.width,
                );
              },
            ).toList();

            final inputImageData = InputImageData(
              size: imageSize,
              imageRotation: imageRotation,
              inputImageFormat: inputImageFormat,
              planeData: planeData,
            );

            final inputImageCamera = InputImage.fromBytes(
              bytes: bytes,
              inputImageData: inputImageData,
            );

            scannerBarCode(inputImageCamera);
          } catch (e, s) {
            debugPrint('Error when reading camera ${e.toString()}');
            debugPrint('Stack when reading camera ${s.toString()}');
          }
        }
      });
    }
  }

  @override
  void dispose() {
    _disposed = true;
    cameraController?.dispose();
    if (status.showCamera) {
      cameraController?.dispose();
    }
    if (status.hasBarcode) {
      barcodeScanner.close();
    }
    super.dispose();
  }

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }
}
