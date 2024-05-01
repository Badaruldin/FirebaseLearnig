import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedListViewClass extends StatefulWidget {
  const AnimatedListViewClass({Key? key}) : super(key: key);

  @override
  State<AnimatedListViewClass> createState() => _AnimatedListViewClassState();
}

class _AnimatedListViewClassState extends State<AnimatedListViewClass> {
  List<Color> colors = <Color>[
    Colors.redAccent,
    Colors.purple,
    Colors.red,
    Colors.black,
    Colors.teal,
    Colors.green,
    Colors.grey
  ];

  Random random = Random();

  final _key = GlobalKey<AnimatedListState>();

  List<String> _msgList = <String>['Faizan', 'Kashif', 'Imran'];
  int counter = 0;

  final msgController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: AnimatedList(
                key: _key,
                initialItemCount: _msgList.length,
                itemBuilder: (context, index, animation) {
                  return SlideTransition(
                    position:
                        Tween<Offset>(begin: const Offset(-1, 0), end: const Offset(0, 0))
                            .animate(animation),
                    child: InkWell(
                      onTap: () {
                        _key.currentState!.removeItem(
                          index, (context, animation) => Card(
                            child: ListTile(
                              leading: Text(
                                _msgList[index],
                                style:
                                    TextStyle(color: colors[random.nextInt(7)]),
                              ),
                            ),
                          ),
                        );
                        _msgList.removeAt(index);
                      },
                      child: Card(
                        child: ListTile(
                          leading: Text(
                            _msgList[index],
                            style: TextStyle(color: colors[random.nextInt(7)]),
                          ),
                        ),
                      ),
                    ),
                  );

                  // return SizeTransition(
                  //   sizeFactor: animation,
                  //   axis: Axis.vertical,
                  //   child: Card(
                  //     child: ListTile(
                  //       leading: Text(
                  //         _msgList[index],
                  //         style: TextStyle(color: colors[random.nextInt(7)]),
                  //       ),
                  //     ),
                  //   ),
                  // );
                }),
          ),
          Expanded(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: msgController,
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        _key.currentState!.insertItem(0,
                            duration: const Duration(milliseconds: 500));
                        _msgList = [msgController.text.toString(), ..._msgList];
                        // _msgList = []
                        //   ..add(msgController.text.toString())
                        //   ..addAll(_msgList);
                        msgController.clear();
                        setState(() {});
                      },
                      icon: const Icon(Icons.add_to_drive_outlined))
                ]),
          )
        ],
      ),
    );
  }
}

//creating an extension for sized box
extension PaddingSolution on int {
  SizedBox get sh => SizedBox(height: toDouble());

  SizedBox get sw => SizedBox(width: toDouble());
}

//Asif Taj
//import 'dart:math';
//
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
//
//
// class CheckInternetConnectionWidget extends StatelessWidget {
//   final AsyncSnapshot<ConnectivityResult> snapshot;
//   final Widget widget ;
//   const CheckInternetConnectionWidget({
//     Key? key,
//     required this.snapshot,
//     required this.widget
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     switch (snapshot.connectionState) {
//       case ConnectionState.active:
//         final state = snapshot.data!;
//         switch (state) {
//           case ConnectivityResult.none:
//             return Center(child: const Text('Not connected'));
//           default:
//             return  widget;
//         }
//         break;
//       default:
//         return const Text('');
//     }
//   }
// }
//
//
// class InternetConnectivityScreen extends StatelessWidget {
//   InternetConnectivityScreen({Key? key}) : super(key: key);
//
//   List<Color> colors = [Colors.redAccent, Colors.purple , Colors.pinkAccent, Colors.black, Colors.teal, Colors.green, Colors.grey];
//   Random random = Random();
//
//   @override
//   Widget build(BuildContext context) {
//     Connectivity connectivity =  Connectivity() ;
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text('Internet Connectivity'),
//       ),
//       body: SafeArea(
//         child: StreamBuilder<ConnectivityResult>(
//           stream: connectivity.onConnectivityChanged,
//           builder: (_, snapshot){
//             return Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10),
//               child: CheckInternetConnectionWidget(
//                 snapshot: snapshot,
//                 widget: Column(
//                   children: [
//                     Expanded(
//                       child: ListView.builder(
//                           itemCount: 120,
//                           itemBuilder: (context, index){
//                             return Padding(
//                               padding: const EdgeInsets.only(bottom: 8),
//                               child: Container(
//                                   color: colors[random.nextInt(7)],
//                                   height: 100,
//                                   child: Center(child: Text(index.toString()))),
//                             );
//                           }),
//                     )
//                   ],
//                 ),
//               ),
//             ) ;
//           },
//         ),
//       ),
//     );
//   }
// }
