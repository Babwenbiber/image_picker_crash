import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:image_picker/image_picker.dart';

class CustomImagePicker extends StatefulWidget {
  CustomImagePicker(this.callback, {Key key}) : super(key: key);

  final ImageUploadInterface callback;
  _CustomImagePickerState state;

  getImage() {
    state.getImage();
  }

  @override
  _CustomImagePickerState createState() {
    state = _CustomImagePickerState(callback);
    return state;
  }
}

class _CustomImagePickerState extends State<CustomImagePicker> {
  PickedFile _imageFile;
  dynamic _pickImageError;
  bool isVideo = false;
  String _retrieveDataError;
  ImageUploadInterface callback;

  _CustomImagePickerState(this.callback);

  final ImagePicker _picker = ImagePicker();

  Future getImage() async {
    try {
      final pickedFile =
          await _picker.getImage(source: ImageSource.gallery, imageQuality: 50);
      setState(() {
        _imageFile = pickedFile;
      });
    } catch (e) {
      print("caught $e");
      setState(() {
        _pickImageError = e;
      });
    }
    callback.handleImageCallback(File(_imageFile.path));
  }

  Widget _previewImage() {
    final Text retrieveError = _getRetrieveErrorWidget();
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFile != null) {
      if (kIsWeb) {
        // Why network?
        // See https://pub.dev/packages/image_picker#getting-ready-for-the-web-platform
        return Image.network(_imageFile.path);
      } else {
        return Image.file(File(_imageFile.path));
      }
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        '',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return _previewImage();
  }

  Text _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }
}

abstract class ImageUploadInterface {
  void handleImageCallback(File img);
}
