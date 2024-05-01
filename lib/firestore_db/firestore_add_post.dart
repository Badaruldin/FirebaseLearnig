import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_learing/utils/utils.dart';
import 'package:flutter/material.dart';

class FirestorePostOnFirebase extends StatefulWidget {
  const FirestorePostOnFirebase({Key? key}) : super(key: key);

  @override
  State<FirestorePostOnFirebase> createState() => _FirestorePostOnFirebaseState();
}


class _FirestorePostOnFirebaseState extends State<FirestorePostOnFirebase> {
  final auth = FirebaseAuth.instance;
  final postTextController = TextEditingController();
  final _fsRef=FirebaseFirestore.instance.collection('Employee');


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.post_add_outlined),
        title: const Text("Send your Data"),
        backgroundColor: Colors.pink,
        automaticallyImplyLeading: true,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Let's Create your Post",
                style: TextStyle(color: Colors.pink, fontSize: 25.0)),
            const SizedBox(height: 30.0),
            TextFormField(
                controller: postTextController,
                decoration: const InputDecoration(
                    labelText: "Let's Share your thoughts to FireB",
                    border: OutlineInputBorder()),
                maxLines: 3,
                textAlign: TextAlign.left,
                keyboardType: TextInputType.name),
            const SizedBox(
              height: 20.0,
            ),
            IconButton(
                onPressed: () {
                  Utils().ToastMassege("Button Clicked");
                  final id=DateTime.now().millisecondsSinceEpoch.toString();
                  _fsRef.doc(id).set({
                    'id': id,
                    'title': postTextController.text.toString(),
                  }).then((value){
                    Utils().ToastMassege("Post Added");
                  }).onError((error, stackTrace) {
                    Utils().ToastMassege(error.toString());
                  });
                },
                icon: const Icon(
                  Icons.send_outlined,
                  size: 60.0,
                  color: Colors.pink,
                )),
            const SizedBox(height: 35.0),
          ],
        ),
      ),
    );
  }
}
