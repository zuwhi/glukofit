import 'package:camera/camera.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:get/get.dart';
import 'package:glukofit/constants/app_routes.dart';
import 'package:glukofit/models/scan_model.dart';

import 'package:permission_handler/permission_handler.dart';

class ScanController extends GetxController {
  // final listProduk = Rx<List<ProdukModel>>([]);
  final fileImage = Rx<XFile?>(null);
  RxBool isLoading = false.obs;
  @override
  void dispose() {
    super.dispose();
    cameraController.dispose();
  }

  final resultScan =
      Rx<ScanModel>(ScanModel(confidence: 0, index: 0, label: ""));
  late CameraController cameraController;
  late List<CameraDescription> cameras;

  late CameraImage cameraImage;

  var isCamerainitialized = false.obs;
  var cameraCount = 0;

  var x, y, w, h = 0.0;

  double? presentage;

  initAll() async {
    await initCamera();
    initTFlite();
  }

  initCamera() async {
    if (await Permission.camera.request().isGranted) {
      cameras = await availableCameras();
      cameraController = CameraController(cameras[0], ResolutionPreset.max,
          imageFormatGroup: ImageFormatGroup.yuv420);

      await cameraController.initialize().then((value) {
        cameraController.startImageStream((image) {
          cameraCount++;
          if (cameraCount % 10 == 0) {
            cameraCount = 0;
            objectDetector(image);
          }
          update();
        });
      });
      isCamerainitialized(true);
      update();
    } else {
      print("permission denied");
    }
  }

  initTFlite() async {
    try {
      await Tflite.loadModel(
        model: "assets/tensorflow/model.tflite",
        labels: "assets/tensorflow/labels.txt",
        isAsset: true,
        numThreads: 1,
        useGpuDelegate: false,
      );
    } catch (e) {
      print('cek error $e');
    }
  }

  stopCamera() async {
    if (cameraController.value.isInitialized) {
      await cameraController.pausePreview();
      await cameraController.dispose();
      isCamerainitialized(false); // Update the state
      update();
    }
    await Tflite.close();
  }

  final RxBool isSnackbarShown = false.obs;
  objectDetector(CameraImage image) async {
    try {
      print('cek 3');
      var bytesList = image.planes.map((e) => e.bytes).toList();

      var detector = await Tflite.runModelOnFrame(
        bytesList: bytesList,
        asynch: true,
        imageHeight: image.height,
        imageWidth: image.width,
        imageMean:
            127.5, // Normalisasi sesuai dengan yang digunakan saat pelatihan
        imageStd:
            127.5, // Normalisasi sesuai dengan yang digunakan saat pelatihan
        numResults: 1,
        rotation: 90, // Pastikan ini sesuai dengan orientasi gambar
        threshold: 0.4,
      );

      // Cek hasil deteksi
      if (detector != null && detector.isNotEmpty) {
        var detectedObject = detector.first;
        ScanModel scanModel = ScanModel(
          confidence: detectedObject['confidence'],
          index: detectedObject['index'],
          label: detectedObject['label'],
        );
        resultScan(scanModel);

        presentage = detectedObject['confidence'];
 
        update();
      } else {
        print('No objects detected or detector result is null.');
      }
    } catch (e) {
      if (!isSnackbarShown.value) {
        Get.snackbar(
          "Terjadi Kesalahan",
          "Terdapat error saat meload data",
        );
        isSnackbarShown.value = true;
      }
      print('Error running object detection: $e');
    }
  }

  // Fungsi untuk mengambil gambar dengan kamera
  Future<void> captureImage() async {
    try {


      fileImage.value = await cameraController.takePicture();

      Get.toNamed(AppRoutes.produkFromImage,
          arguments: {'image': fileImage.value});
      isLoading.value = true;
      stopCamera();
      loadModelFromPath(fileImage.value!.path);
    } catch (e) {

      if (!isSnackbarShown.value) {
        Get.snackbar(
          "Terjadi Kesalahan",
          "Gagal mengambil gambar",
        );
        isSnackbarShown.value = true;
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadModelFromPath(String imagePath) async {
    try {
      var detector = await Tflite.runModelOnImage(
        path: imagePath,
        imageMean: 127.5,
        imageStd: 127.5,
        numResults: 1,
        threshold: 0.4,
      );

      if (detector != null && detector.isNotEmpty) {
        var detectedObject = detector.first;
        ScanModel scanModel = ScanModel(
          confidence: detectedObject['confidence'],
          index: detectedObject['index'],
          label: detectedObject['label'],
        );

        resultScan(scanModel);

        update();
      } else {
      
      }
    } catch (e) {
      if (!isSnackbarShown.value) {
        Get.snackbar(
          "Terjadi Kesalahan",
          "Gagal meload model",
        );
        isSnackbarShown.value = true;
      }
    }
  }
}
