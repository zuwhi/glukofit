import 'package:camera/camera.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';


class ScanController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // initCamera();
    // initTFlite();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cameraController.dispose();
  }


  RxString label = "".obs;
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
    await cameraController.pausePreview();
    await cameraController.dispose();

    await Tflite.close();
    update();
  }

  objectDetector(CameraImage image) async {
    try {
      print('cek 3');

      // Pastikan bytesList diubah menjadi format yang benar
      var bytesList = image.planes.map((e) => e.bytes).toList();

      // Menjalankan model pada frame
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
        print('Detected Object: $detectedObject');

        label.value = detectedObject['label'];

        presentage = detectedObject['confidence'];
        Logger().d(presentage);
        update();
      } else {
        print('No objects detected or detector result is null.');
      }
    } catch (e) {
      print('Error running object detection: $e');
    }
  }
}
