import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class PickFile extends StatefulWidget {
  @override
  _PickFileState createState() => _PickFileState();
}

class _PickFileState extends State<PickFile> {
  File pickedImage;
  bool isImageLoaded = false;
  List result;
  String confidence;
  String name;

  getImageFromGallery() async {
    var tempStore = await ImagePicker().getImage(source: ImageSource.gallery);

    if(mounted) {
      setState(() {
        pickedImage = File(tempStore.path);
        isImageLoaded = true;
        applyModelOnImage(File(tempStore.path));
      });
    }
  }

  applyModelOnImage(File file) async {
    var res = await Tflite.runModelOnImage(
      path: file.path,
      numResults: 2,
      threshold: 0.4,
      imageMean: 127.5,
      imageStd: 127.5, 
    );

    if(mounted) {  
      setState(() {
        result = res;

        name = result[0]["label"];
        confidence = result != null 
          ? (result[0]['confidence']*100.0).toString().substring(0, 2) + "%"
          : "";
      });
    }
  }

  loadMyModel() async {
    var resultant = await Tflite.loadModel(
      model: "assets/model_unquant_v2.tflite",
      labels:  "assets/labels.txt"
    );

    print('status load model: $resultant');
  }

  @override
  void initState() {
    super.initState();
    loadMyModel();
  }
  
  @override
  void dispose() {
    super.dispose();
    loadMyModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            isImageLoaded
                ? Center(
                    child: Container(
                      height: 350,
                      width: 350,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: FileImage(File(pickedImage.path)),
                              fit: BoxFit.contain)),
                    ),
                  )
                : Container(),
            Text("Name : $name \n Confidence : $confidence")
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getImageFromGallery();
        },
        child: Icon(Icons.photo_library_outlined)
      ),
    );
  }
}