import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  bool isWorking = false;
  CameraController controller;
  List<CameraDescription> cameras;
  CameraImage imgCamera;
  String result = '';

  loadModel() async {
    await Tflite.loadModel(
        model: "assets/model_unquant_v2.tflite", 
        labels: "assets/labels.txt");
  }

  @override
  void initState() {
    loadModel();
    super.initState();
    availableCameras().then((value) {
      cameras = value;
      if (cameras.length > 0) {
        controller = CameraController(cameras[1], ResolutionPreset.high);
        controller.initialize().then((_) {
          if (!mounted) {
            return;
          }
          setState(() {
            controller.startImageStream((imageFromStream) {
              if (!isWorking) {
                isWorking = true;
                imgCamera = imageFromStream;
                runModelOnStreamFrames();
              }
            });
          });
        });
      } else {
        print('camera error');
      }
    }).catchError((e) {
      print(e.code);
    });
  }

  runModelOnStreamFrames() async {
    if (imgCamera != null) {
      var recognitions = await Tflite.runModelOnFrame(
          bytesList: imgCamera.planes.map((plane) {
            return plane.bytes;
          }).toList(),
          imageHeight: imgCamera.height,
          imageWidth: imgCamera.width,
          imageMean: 127.5,
          imageStd: 127.5,
          numResults: 1,
          threshold: 0.6,
          asynch: true);

      result = " ";

      recognitions.forEach((response) {
        result += response["label"] +
            " " +
            ((response["confidence"] as double) * 100).toStringAsFixed(1) +
            " % \n\n";
      });

      if (mounted) {
        setState(() {
          return result;
        });
      }

      isWorking = false;
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xff3A0CA3),
        appBar: AppBar(
          backgroundColor: Color(0xff3A0CA3),
          elevation: 0.0,
        ),
        body: cameraPreview());
  }

  Widget cameraPreview() {
    if (controller == null || !controller.value.isInitialized) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'loading',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
                fontWeight: FontWeight.w500),
            )
          ],
        ),
      );
    }
    return Stack(
      children: [
        CameraPreview(controller),
        Center(
          child: Text(
            "Huruf yang terdeteksi adalah" + result,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.black),
          ),
        ),
      ],
    );
  }
}
