import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  CameraController controller;
  List<CameraDescription> cameras;

  @override
  void initState() {
    super.initState();
    availableCameras().then((value) {
      cameras = value;
      if (cameras.length > 0) {
        controller = CameraController(cameras[0], ResolutionPreset.high);
        controller.initialize().then((_) {
          if (!mounted) {
            return;
          }
          setState(() {});
        });
      } else {
        print('camera error');
      }
    }).catchError((e) {
      print(e.code);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff3A0CA3),
      appBar: AppBar(
        backgroundColor: Color(0xff3A0CA3),
        elevation: 0.0,
      ),
      body: cameraPreview() 
    );
  }

  Widget cameraPreview() {
    if (controller == null || !controller.value.isInitialized) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'loading',
              style: TextStyle(color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.w500),
            )
          ],
        ),
      );
    }
    return RotationTransition(
      turns: AlwaysStoppedAnimation(90 / 360),
      child: CameraPreview(controller),
    );
  }
}

// class CameraScreen extends StatefulWidget {
//   @override
//   _CameraScreenState createState() => _CameraScreenState();
// }

// class _CameraScreenState extends State<CameraScreen> {
//   CameraController cameraController;
//   List cameras;

//   @override
//   void initState() {
//     super.initState();
//     availableCameras().then((value) {
//       cameras = value;
//       if (cameras.length > 0) {
//         initCamera(cameras[0]).then((_) {});
//       } else {
//         print('camera not found');
//       }
//     }).catchError((e) {
//       print(e.code);
//     });
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   Future initCamera(CameraDescription cameraDescription) async {
//     if (cameraController != null) {
//       await cameraController.dispose();
//     }
//     cameraController =
//         CameraController(cameraDescription, ResolutionPreset.high);

//     cameraController.addListener(() {
//       if (mounted) {
//         setState(() {});
//       }
//     });

//     if (cameraController.value.hasError) {
//       print('camera error');
//     }

//     try {
//       await cameraController.initialize();
//     } catch (e) {
//       print('Camera error $e');
//     }

//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Container(
//         child: cameraPreview(),
//       )
//     );
//   }

//   Widget cameraPreview() {
//     if (cameraController == null || !cameraController.value.isInitialized) {
//       return Text('loading', style: TextStyle(color: Colors.black),);
//     }
//     return RotationTransition(
//       turns: AlwaysStoppedAnimation(90 / 360),
//       child: CameraPreview(cameraController),
//     );
//   }
// }
