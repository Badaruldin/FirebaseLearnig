import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_learing/widgetOfWeek/animateContainerClass.dart';
import 'package:flutter/material.dart';

class CheckInternetClass extends StatelessWidget {
  CheckInternetClass({Key? key}) : super(key: key);
  final Connectivity connection = Connectivity();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder(
                stream: connection.onConnectivityChanged,
                builder: (_, snapshot) {
                  return CheckInternetWidget(
                    snapshot: snapshot,
                    child: const Text(''
                        'Successfully connected'),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

class CheckInternetWidget extends StatelessWidget {
  const CheckInternetWidget(
      {Key? key, required this.snapshot, required this.child})
      : super(key: key);
  final AsyncSnapshot snapshot;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (snapshot.connectionState == ConnectionState.active) {
      final state = snapshot.data;
      if (state == ConnectivityResult.none) {
        return const Text("No internet Connection 1");
      } else {
        return Expanded(child: const AnimatedContainerClass());
      }
    } else {
      return const Text('No Connection state 2');
    }
  }
}
