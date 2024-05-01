import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_learing/utils/utils.dart';
import 'package:flutter/material.dart';

class PostOnFirebase extends StatefulWidget {
  const PostOnFirebase({Key? key}) : super(key: key);

  @override
  State<PostOnFirebase> createState() => _PostOnFirebaseState();
}
final _fRef = FirebaseDatabase.instance.ref('User');

class _PostOnFirebaseState extends State<PostOnFirebase> {
  final auth = FirebaseAuth.instance;
  final postTextController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.post_add_outlined),
        title: const Text("Send your Data"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Let's Create your Post",
                style: TextStyle(color: Colors.green, fontSize: 25.0)),
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
                  _fRef.child(id).set({
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
                  color: Colors.green,
                )),
            const SizedBox(height: 35.0),
            // const Text("Want to Update Content"),
            // IconButton(
            //     onPressed: () {
            //       fRef.child("A").set(
            //             ({
            //               'id': 1,
            //               'title': postTextController.text,
            //             }),
            //           );
            //     },
            //     icon: const Icon(
            //       Icons.recycling_outlined,
            //       size: 60.0,
            //       color: Colors.green,
            //     ))
          ],
        ),
      ),
    );
  }
}
