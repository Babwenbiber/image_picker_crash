import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'custom_image_picker.dart';

class MainPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => MainState();
}

class MainState extends State<MainPage> implements ImageUploadInterface {
  Image selectedImg;
  CustomImagePicker imagePicker;
  String imgName;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    imagePicker = CustomImagePicker(this);
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.black,
      body: getBody(),
    );
    // This trailing comma makes auto-formatting nicer for build methods.
  }

  getBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(height: 300, child: imagePicker),
        getPickImageButton(),
        getRefreshButton(),
      ],
    );
  }

  Widget getUploadedMsg() {
    if (imgName == null) {
      return Container();
    } else {
      return Text("uploaded img $imgName");
    }
  }

  Widget getRefreshButton() {
    return RaisedButton(
      child: Text("refresh"),
      onPressed: () => Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => new MainPage()),
          (route) => false),
    );
  }

  Widget getPickImageButton() {
    return RaisedButton(
      child: Text("choose image"),
      onPressed: () => imagePicker.getImage(),
    );
  }

  @override
  void handleImageCallback(File img) {
    // TODO: implement handleImageCallback
  }
}
