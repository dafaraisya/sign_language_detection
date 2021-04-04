import 'package:flutter/material.dart';
import 'package:sign_language_detection/pages/camera_screen.dart';
import 'package:sign_language_detection/pages/info.dart';
import 'package:sign_language_detection/pages/pick_file.dart';
import 'package:sign_language_detection/screensize_config.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sign Language Detection',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Color(0xff3A0CA3),
      appBar: AppBar(
        backgroundColor: Color(0xff3A0CA3),
        title: Text(widget.title),
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.info),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return Info();
            }));
          },
          color: Colors.pink,
          iconSize: 35.0,
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.only(top: 50.0)),
            Text(
              'Sign Language Cam',
              style: TextStyle(fontSize: 30.0, color: Colors.white),
            ),
            Padding(padding: EdgeInsets.only(top: 40.0)),
            IconButton(
              icon: Image.asset('assets/images/camera_icon.png'),
              iconSize: 150.0,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CameraScreen();
                }));
              },
            ),
            Text('Use Camera Device', style: TextStyle(color: Colors.white, fontSize: 15.0),),
            Padding(padding: EdgeInsets.only(bottom: 20.0)),
            MaterialButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return PickFile();
                }));
              },
              color: Color(0xff677FF1),
              textColor: Colors.white,
              child: Icon(
                Icons.photo_outlined,
                size: 90,
              ),
              padding: EdgeInsets.all(16),
              shape: CircleBorder(),
            ),
            Padding(padding: EdgeInsets.only(top: 15.0)),
            Text('Use Image File', style: TextStyle(color: Colors.white, fontSize: 15.0),),
          ],
        ),
      ),
    );
  }
}
