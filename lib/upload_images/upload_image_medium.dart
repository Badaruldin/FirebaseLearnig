import 'dart:io';
import 'package:firebase_learing/signup/ButtonCustomWidget.dart';
import 'package:firebase_learing/utils/utils.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_database/firebase_database.dart' as firebase_storage;

class UploadImageMedium extends StatefulWidget {
  const UploadImageMedium({Key? key}) : super(key: key);

  @override
  State<UploadImageMedium> createState() => _UploadImageMediumState();
}

class _UploadImageMediumState extends State<UploadImageMedium> {

  final firebase_storage.FirebaseDatabase storage = firebase_storage
      .FirebaseDatabase.instance;


  // File? imageFile; //remember to import .io dependency
  // final ImagePicker picker = ImagePicker();

  Future<XFile?> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile? pickedImageLocal = await _picker.pickImage(source: ImageSource.gallery);
    return pickedImageLocal;
  }
  XFile? pickedImage;
  Future<void> uploadImageToFirestore() async {
    pickedImage= await pickImage();
    if (pickedImage != null) {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference storageReference = FirebaseStorage.instance.ref().child('images/$fileName');

      UploadTask uploadTask = storageReference.putFile(File(pickedImage!.path));
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
      String imageUrl = await taskSnapshot.ref.getDownloadURL();

      await FirebaseFirestore.instance.collection('images').add({'url': imageUrl});

      Utils().ToastMassege('Image uploaded successfully!');
    } else {
      Utils().ToastMassege('No image picked!');
    }
  }


  // Future getGalleryImage() async {
  //   final pickedFile = await picker.pickImage(
  //       source: ImageSource.gallery, imageQuality: 75);
  //   if (pickedFile != null) {
  //     imageFile = File(pickedFile.path);
  //   }
  //   if (pickedFile == null) {
  //     Utils().ToastMassege("No Image Selected");
  //   }
  // }


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
                setState(() {});
              },
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black45, width: 3.0)),
                width: 200,
                height: 250,
                child: pickImage() != null ? Image.file(pickedImage!.path as File)
                    : Icon(
                  Icons.photo,
                  size: 50.0,
                ),
              )),
          ButtonCustomWidget(onPressed: () {
            uploadImageToFirestore();

            // final ref = firebase_storage.FirebaseDatabase.instance.ref("/images/" + "/file001");
            //firebase_storage.Reference ref= firebase_storage.FirebaseStorage.instance.ref("/folder"+"imgname");
            //firebase_storage.UploadTask uploadTask=ref.putFile(imageFile.absolute);

          }, widget: const Text("Upload"))
        ],
      ),
    );
  }
}
