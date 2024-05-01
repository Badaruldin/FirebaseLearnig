import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_learing/firestore_db/firestore_add_post.dart';
import 'package:firebase_learing/login/login.dart';
import 'package:firebase_learing/upload_images/upload_image.dart';
import 'package:firebase_learing/upload_images/upload_image_medium.dart';
import 'package:firebase_learing/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FirestoreHomeScreen extends StatefulWidget {
  const FirestoreHomeScreen({Key? key}) : super(key: key);

  @override
  State<FirestoreHomeScreen> createState() => _FirestoreHomeScreenState();
}

class _FirestoreHomeScreenState extends State<FirestoreHomeScreen> {
  final auth = FirebaseAuth.instance;

  final _fsRef = FirebaseFirestore.instance
      .collection('Employee')
      .snapshots(includeMetadataChanges: false);
  final _fsRef2 = FirebaseFirestore.instance.collection('Employee');
  final searchController = TextEditingController();
  final updateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink.shade700,
          leading: const Icon(Icons.home_outlined),
          title: const Text("Fire HomeScreen"),
          centerTitle: true,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  auth
                      .signOut()
                      .then((value) => () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Login()));
                          })
                      .onError((error, stackTrace) => () {
                            Utils().ToastMassege(error.toString());
                          });
                },
                icon: const Icon(Icons.logout_outlined))
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 36.0),
              const Text("Welcome to\nFirestore\nHome screen",
                  style: TextStyle(color: Colors.pink, fontSize: 30.0)),
              const SizedBox(height: 32.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Search"),
                  controller: searchController,
                  cursorColor: Colors.purple,
                  onChanged: (string) {
                    setState(() {});
                  },
                ),
              ),
              const SizedBox(height: 18.0),
              InkWell(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Icon(Icons.image_outlined),
                    Text("Upload Image",style: TextStyle(color: Colors.brown,fontSize: 20.0),),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => const UploadImage(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 18.0),
              InkWell(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    Icon(Icons.image_outlined),
                    Text("M Upload Image",style: TextStyle(color: Colors.brown,fontSize: 20.0),),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => const UploadImageMedium(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 18.0),
              const Text("Your posts on Firestore",
                  style: TextStyle(
                    color: Colors.pinkAccent,
                    fontSize: 22.0,
                  ),
                  textAlign: TextAlign.center),
              const SizedBox(height: 20.0),
              StreamBuilder<QuerySnapshot>(
                  stream: _fsRef,
                  builder: (context, snapshot) {
                    return Expanded(
                      child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator(
                                  color: Colors.black45);
                            }
                            if (snapshot.hasError) {
                              return const Text("Error Occur");
                            }
                            String titleData =
                                snapshot.data!.docs[index]['title'].toString();
                            String idData =
                                snapshot.data!.docs[index]['id'].toString();
                            return ListTile(
                              title: Text(snapshot.data!.docs[index]['title']),
                              subtitle: Text(
                                  snapshot.data!.docs[index]['id'].toString()),
                              trailing: PopupMenuButton(
                                icon: const Icon(Icons.more_vert_outlined),
                                itemBuilder: (BuildContext context) => [
                                  PopupMenuItem(
                                    value: 1,
                                    child: ListTile(
                                      leading: const Icon(Icons.edit),
                                      trailing: const Text("Edit"),
                                      onTap: () {
                                        Navigator.pop(context);
                                        showMyDialog(titleData, idData);
                                      },
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: 1,
                                    child: ListTile(
                                      leading: const Icon(Icons.delete_outline),
                                      trailing: const Text("Delete"),
                                      onTap: () {
                                        Navigator.pop(context);
                                        _fsRef2
                                            .doc(snapshot.data!.docs[index]
                                                ['id'])
                                            .delete()
                                            .then((value) {
                                          Utils().ToastMassege("Deleted");
                                        }).onError((error, stackTrace) {
                                          Utils()
                                              .ToastMassege(error.toString());
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }),
                    );
                  })
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: Colors.pink,
          onPressed: () {},
          child: IconButton(
              onPressed: () {
                Utils().ToastMassege("Let's move to\nPost your thoughts");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        const FirestorePostOnFirebase(),
                  ),
                );
              },
              icon: const Icon(
                Icons.queue_play_next,
                size: 35.0,
                color: Colors.white,
              )),
        ),
      ),
    );
  }

  Future<void> showMyDialog(String defaultText, String id) async {
    updateController.text = defaultText;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Let's Update"),
            backgroundColor: Colors.black45,
            titleTextStyle: const TextStyle(color: Colors.white70),
            shape: const RoundedRectangleBorder(),
            content: TextFormField(
              controller: updateController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "Cancel",
                  textAlign: TextAlign.center,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _fsRef2
                      .doc(id)
                      .update(({
                        'title': updateController.text.toString(),
                      }))
                      .then((value) {
                    Utils().ToastMassege("Updated...!");
                  }).onError((error, stackTrace) {
                    Utils().ToastMassege(error.toString());
                  });
                },
                child: const Text("Update", textAlign: TextAlign.center),
              )
            ],
          );
        });
  }
}

//StreamBuilder usage to fetch data from Firebase
//              Expanded(
//                   child: StreamBuilder(
//                 stream: _fDBRef.onValue,
//                 builder: (context, snapShot) {
//                   if(!snapShot.hasData){
//                     return Text("Empty Database");
//                   }
//                   else{
//                     Map<dynamic,dynamic>map=snapShot.data!.snapshot.value as dynamic;
//                     List<dynamic> list=[];
//                     list.clear();
//                     list=map.values.toList();
//                     return ListView.builder(
//                       itemCount: snapShot.data!.snapshot.children.length,
//                       itemBuilder: (context, index) {
//                         return ListTile(
//                           leading: Text(list[index]['title']),
//                           subtitle: Text(list[index]['id']),
//                         );
//                       },
//                     );
//
//                   }
//                 },
//               )),
