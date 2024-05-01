import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class ImageCompreserClass extends StatefulWidget {
  ImageCompreserClass({Key? key}) : super(key: key);

  @override
  State<ImageCompreserClass> createState() => _ImageCompreserClassState();
}

class _ImageCompreserClassState extends State<ImageCompreserClass> {
  File? compImgFile; //it stores compressed image
  XFile? origImgFile; //it stores orignal image as non_compressed img

  final picker = ImagePicker();

  Future imagePickerGalleryFun() async {
    origImgFile = (await picker.pickImage(source: ImageSource.gallery));

    var bytes = await origImgFile!.readAsBytes();
    var mb =
        (bytes.length / 1024) / 1024; //converting bytes to kbz then kbz to mbz

    if (kDebugMode) {
      print('Size of Original Image: $mb');
    }

    final dir = await path_provider.getTemporaryDirectory();
    final targetPath = '${dir.absolute.path}/temp.jpg';

    final resultImg = await FlutterImageCompress.compressAndGetFile(
        origImgFile!.path, targetPath,
        minHeight: 800, minWidth: 850, quality: 70);

    final compBytes = await resultImg!.readAsBytes();
    var compKb = compBytes.length / 1024;
    var compMb = compKb / 1024;

    if (kDebugMode) {
      print('Size of Comp Image:$compMb');
    }


    compImgFile = File(resultImg.path);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (origImgFile != null)
            InteractiveViewer(child: Image.file(File(compImgFile!.path))),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          imagePickerGalleryFun();
        },
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
