import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_learing/signup/signup.dart';
import 'package:firebase_learing/widgetOfWeek/streamBuilderClass.dart';
import 'package:firebase_learing/widgetOfWeek/streamBuilderScoket.dart';
import 'package:flutter/material.dart';

class SplashScreenNew extends StatefulWidget {
  const SplashScreenNew({Key? key}) : super(key: key);

  @override
  State<SplashScreenNew> createState() => _SplashScreenNewState();
}
  final _auth=FirebaseAuth.instance;
  User? user=_auth.currentUser;

class _SplashScreenNewState extends State<SplashScreenNew> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Icon(Icons.local_fire_department_outlined,
            size: 300.0, color: Colors.green),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  splashTimerFunction();
  }
  void splashTimerFunction()async{
    if(user !=null){
      Timer(const Duration(seconds: 3), () async{
        await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const StreamBuilderSocket()),
        );
      });
    } else{
      Timer(const Duration(seconds: 3), () async{
        await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => const SignUp()),
        );
      });
    }
  }
}
