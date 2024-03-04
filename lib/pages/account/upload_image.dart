import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../../utils/globals.dart';

class UploadImage extends StatefulWidget {
  const UploadImage({
    Key? key,
  }) : super(key: key);

  @override
  _UploadImageState createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  XFile? _pickedFile;
  CroppedFile? _croppedFile;

  bool uploading = false;
  updateProfile() async {
    setState(() {
      nowUploading = true;
    });

    setState(() {
      uploading = true;
    });
    String imageUrl = _croppedFile != null
        ? await Globals.uploadPhoto(File(_croppedFile!.path))
        : _pickedFile != null
            ? await Globals.uploadPhoto(File(_pickedFile!.path))
            : '';

    setState(() {
      uploading = false;
    });
    Globals.toast("Done uploading photo");
    firestore
        .collection("users")
        .doc(auth.currentUser!.uid)
        .update({"image": imageUrl}).then(
      (value) {
        Future.delayed(Duration(milliseconds: 1500), () {
          Navigator.pop(context);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = getSize(context);

    return Scaffold(
      backgroundColor: Globals.backgroundColor,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 700),
        switchInCurve: Curves.fastLinearToSlowEaseIn,
        child: nowUploading
            ? Center(
                child: mainLoader,
              )
            : Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (kIsWeb)
                    Padding(
                      padding: const EdgeInsets.all(kIsWeb ? 24.0 : 16.0),
                      child: Text(
                        "Upload new profile Photo",
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(color: Theme.of(context).highlightColor),
                      ),
                    ),
                  Expanded(child: _body()),
                ],
              ),
      ),
    );
  }

  Widget _body() {
    if (_croppedFile != null || _pickedFile != null) {
      return _imageCard();
    } else {
      return _uploaderCard();
    }
  }

  Widget _imageCard() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: kIsWeb ? 24.0 : 16.0),
            child: Card(
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(kIsWeb ? 24.0 : 16.0),
                child: _image(),
              ),
            ),
          ),
          const SizedBox(height: 24.0),
          _menu(),
        ],
      ),
    );
  }

  Widget _image() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    if (_croppedFile != null) {
      final path = _croppedFile!.path;
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 0.8 * screenWidth,
          maxHeight: 0.7 * screenHeight,
        ),
        child: kIsWeb ? Image.network(path) : Image.file(File(path)),
      );
    } else if (_pickedFile != null) {
      final path = _pickedFile!.path;
      return ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: 0.8 * screenWidth,
          maxHeight: 0.7 * screenHeight,
        ),
        child: kIsWeb ? Image.network(path) : Image.file(File(path)),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _menu() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        InkWell(
          onTap: updateProfile,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Transform.rotate(
                angle: 3.2,
                filterQuality: FilterQuality.high,
                alignment: Alignment.center,
                child: Lottie.asset(
                  "assets/lottie/download1.json",
                  fit: BoxFit.contain,
                  filterQuality: FilterQuality.high,
                  reverse: true,
                  alignment: Alignment.center,
                  width: 80,
                  height: 80,
                ),
              ),
              if (_croppedFile != null)
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Upload profile photo"),
                )
            ],
          ),
        ),
        if (_croppedFile == null)
          Padding(
            padding: const EdgeInsets.only(left: 32.0),
            child: FloatingActionButton(
              onPressed: () {
                _cropImage();
              },
              backgroundColor: Globals.primaryColor,
              tooltip: 'Crop',
              child: const Icon(Icons.crop),
            ),
          ),
        FloatingActionButton(
          onPressed: () {
            _clear();
          },
          backgroundColor: Colors.white,
          tooltip: 'Delete',
          child: Icon(Icons.delete, color: Globals.primaryBackground),
        ),
      ],
    );
  }

  Widget _uploaderCard() {
    return Center(
      child: Card(
        elevation: 14.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: SizedBox(
          width: kIsWeb ? 380.0 : 320.0,
          height: 300.0,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: DottedBorder(
                    radius: const Radius.circular(12.0),
                    borderType: BorderType.RRect,
                    dashPattern: const [8, 4],
                    color: Theme.of(context).highlightColor.withOpacity(0.4),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.image,
                            color: Theme.of(context).highlightColor,
                            size: 80.0,
                          ),
                          const SizedBox(height: 24.0),
                          Text(
                            'Choose new photo',
                            style: kIsWeb
                                ? Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(
                                        color: Theme.of(context).highlightColor)
                                : Theme.of(context)
                                    .textTheme
                                    .bodyText2!
                                    .copyWith(
                                        color:
                                            Theme.of(context).highlightColor),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24.0),
                child: FloatingActionButton.extended(
                  backgroundColor: Globals.primaryBackground,
                  foregroundColor: Globals.white,
                  onPressed: () {
                    _uploadImage();
                  },
                  label: const Text('Pick from gallery'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _cropImage() async {
    if (_pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: _pickedFile!.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        maxHeight: 300,
        maxWidth: 300,
        cropStyle: CropStyle.rectangle,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Crop Photo',
              toolbarColor: Globals.primaryBackground,
              toolbarWidgetColor: Colors.white,
              statusBarColor: Globals.primaryBackground,
              backgroundColor: Globals.primaryBackground,
              initAspectRatio: CropAspectRatioPreset.original,
              activeControlsWidgetColor: Globals.primaryColor,
              lockAspectRatio: false),
          IOSUiSettings(
            aspectRatioLockEnabled: true,
            hidesNavigationBar: true,
            title: 'Crop Photo',
          ),
          WebUiSettings(
            context: context,
            barrierColor: Globals.primaryColor,
            presentStyle: CropperPresentStyle.page,
            boundary: const CroppieBoundary(
              width: 520,
              height: 520,
            ),
            viewPort: CroppieViewPort(width: 480, height: 480, type: 'circle'),
            enableExif: true,
            enableZoom: true,
            showZoomer: true,
          ),
        ],
      );
      if (croppedFile != null) {
        setState(() {
          _croppedFile = croppedFile;
        });
      }
    }
  }

  bool nowUploading = false;
  Future<void> _uploadImage() async {
    Globals.toast("Now uploading image");
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _pickedFile = pickedFile;
      });
    }
  }

  void _clear() {
    setState(() {
      _pickedFile = null;
      _croppedFile = null;
    });
  }
}
