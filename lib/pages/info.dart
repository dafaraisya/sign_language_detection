import 'package:flutter/material.dart';

class Info extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff677FF1),
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.info),
            iconSize: 35.0,
            color: Color(0xff3A0CA3),
            onPressed: () {
              Navigator.pop(context);
            }),
        backgroundColor: Color(0xff677FF1),
        elevation: 0.0,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.only(top: 120.0)),
            Text(
              'Aplikasi Apa Ini ?',
              style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            Container(
              padding: EdgeInsets.only(left: 35.0, right: 35.0, top: 20.0),
              child: Text(
                'Bahasa Isyarat Cam adalah aplikasi berbasis android dan OpenCV untu mendeteksi bahasa isyarat yang ditangkap oleh kamera. Aplikasi ini akan mendeteksi huruf alfabet sesuai gerakan tangan yang tertangkap. Aplikasi ini adalah besutan Dimas Nazli dan Dafa Raisya, salah kedua calon asisten Lab B201 Telematic Teknik Komputer ITS.',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w300),
                textAlign: TextAlign.justify,
              ),
            )
          ],
        ),
      ),
    );
  }
}
