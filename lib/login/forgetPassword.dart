import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_learing/login/login.dart';
import 'package:firebase_learing/signup/ButtonCustomWidget.dart';
import 'package:firebase_learing/utils/utils.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatelessWidget {
  ForgetPasswordScreen({Key? key}) : super(key: key);
  final _emailController=TextEditingController();
  final _auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Forget Password"),),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: "Enter your Registered Email",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter your Email first";
                      } else if (value.length < 5) {
                        return "Incomplete Email";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  const SizedBox(height: 25.0),
                  ButtonCustomWidget(
                    widget: const Text("Verify Email"),
                    onPressed: () {
                      _auth.sendPasswordResetEmail(email: _emailController.text.toString().trim()).then((value) async {
                          Utils().ToastMassege("Check your EMails");
                          await Future.delayed(const Duration(seconds: 2)).then((value){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Login()),
                            );
                          });
                        }).onError((error, stackTrace) {
                          Utils().ToastMassege(error.toString());
                        });
                    },
                  ),
                  const SizedBox(height: 8.0),
                ]),
          ),
        ),
    );
  }
}
