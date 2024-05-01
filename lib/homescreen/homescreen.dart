import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_learing/homescreen/postOnFirebase.dart';
import 'package:firebase_learing/login/login.dart';
import 'package:firebase_learing/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final auth = FirebaseAuth.instance;

  final _fDBRef = FirebaseDatabase.instance.ref('User');

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
          backgroundColor: Colors.green.shade700,
          leading: const Icon(Icons.home_outlined),
          title: const Text("Home-Screen"),
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
              const SizedBox(height: 40.0),
              const Text("Welcome to \n Home screen",
                  style: TextStyle(color: Colors.green, fontSize: 32.0)),
              const SizedBox(height: 35.0),
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
              const SizedBox(height: 20.0),
              const Text("Your posts on Firebase",
                  style: TextStyle(
                    color: Colors.lightGreen,
                    fontSize: 22.0,
                  ),
                  textAlign: TextAlign.center),
              const SizedBox(height: 20.0),
              Expanded(
                child: FirebaseAnimatedList(
                  query: _fDBRef,
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  reverse: false,
                  defaultChild: const Text("Fetching Data Please Wait"),
                  itemBuilder: (context, snapShot, animation, index) {
                    final title = snapShot.child('title').value.toString();
                    final id = snapShot.child('id').value.toString();

                    if (searchController.text.isEmpty) {
                      return ListTile(
                        title: Text(snapShot.child("title").value.toString()),
                        subtitle: Text(snapShot.child('id').value.toString()),
                        trailing: PopupMenuButton(
                            icon: const Icon(Icons.more_horiz),
                            itemBuilder: (context) => [
                                  PopupMenuItem(
                                    value: 1,
                                    child: ListTile(
                                      onTap: () {
                                        Navigator.pop(context);
                                        showMyDialog(title, id);
                                      },
                                      leading: const Icon(Icons.edit_outlined),
                                      trailing: const Text("Edit"),
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: 1,
                                    child: ListTile(
                                      onTap: () {
                                        Navigator.pop(context);
                                        _fDBRef.child(id).remove();
                                      },
                                      leading: const Icon(Icons.delete_outline),
                                      trailing: const Text("Delete"),
                                    ),
                                  )
                                ]),
                      );
                    } else if (title.toLowerCase().contains(
                        searchController.text.toString().toLowerCase())) {
                      return ListTile(
                        title: Text(snapShot.child('title').value.toString()),
                        leading: Text(snapShot.child('id').value.toString()),
                      );
                    } else {
                      return const Text("");
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          onPressed: () {},
          child: IconButton(
              onPressed: () {
                Utils().ToastMassege("Let's move to\nPost your thoughts");
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) => const PostOnFirebase(),
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
                  _fDBRef
                      .child(id)
                      .update({
                        'title': updateController.text.toString(),
                      })
                      .then((value) {
                    Utils().ToastMassege("Updated Successfully");
                  }).onError((error, stackTrace) {
                    Utils().ToastMassege(
                      error.toString(),
                    );
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
