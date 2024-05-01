import 'dart:async';
import 'dart:io';
import 'package:firebase_learing/signup/ButtonCustomWidget.dart';
import 'package:firebase_learing/utils/utils.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_database/firebase_database.dart' as firebase_storage;

class UploadImage extends StatefulWidget {
  const UploadImage({Key? key}) : super(key: key);

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {

  final firebase_storage.FirebaseDatabase storage = firebase_storage
      .FirebaseDatabase.instance;


  File? imageFile; //remember to import .io dependency
  final ImagePicker picker = ImagePicker();

  Future getGalleryImage() async {
    final pickedFile = await picker.pickImage(
        source: ImageSource.gallery, imageQuality: 75);
    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    }
    if (pickedFile == null) {
      Utils().ToastMassege("No Image Selected");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload your Images"),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
              onTap: () {
                getGalleryImage();
                setState(() {});
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black45, width: 3.0)),
                width: 200,
                height: 250,
                child: imageFile != null
                    ? Image.file(imageFile!.absolute)
                    : Icon(
                  Icons.photo,
                  size: 50.0,
                ),
              )),
          ButtonCustomWidget(onPressed: () {
            // final ref = firebase_storage.FirebaseDatabase.instance.ref("/images/" + "/file001");
            Reference storage=FirebaseStorage.instance.ref("/images/" + "/file001");
            UploadTask uploadTask=storage.putFile(File(imageFile!.path));
            //firebase_storage.Reference ref= firebase_storage.FirebaseStorage.instance.ref("/folder"+"imgname");
            //firebase_storage.UploadTask uploadTask=ref.putFile(imageFile.absolute);

          }, widget: const Text("Upload"))
        ],
      ),
    );
  }
}
