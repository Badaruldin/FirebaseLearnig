import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_learing/login/verify_otp_login.dart';
import 'package:firebase_learing/signup/ButtonCustomWidget.dart';
import 'package:firebase_learing/utils/utils.dart';
import 'package:flutter/material.dart';

class LoginWithPhoneNo extends StatelessWidget {
  LoginWithPhoneNo({Key? key}) : super(key: key);

  final phonenoController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.assignment_ind_sharp),
        title: const Text("Login with Phone No"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: phonenoController,
                decoration: const InputDecoration(
                    labelText: "Your Phone-No",
                    border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                style: const TextStyle(
                  color: Colors.black45,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              ButtonCustomWidget(
                  widget: const Text("Login"),
                  onPressed: () {
                    if (phonenoController.text.trim().isNotEmpty) {
                      _auth.verifyPhoneNumber(phoneNumber: phonenoController.toString(),
                          verificationCompleted: (_) {},
                          verificationFailed: (e) {
                            Utils().ToastMassege(e.toString());
                          },
                          codeSent: (String verificationId, int? token) {
                            Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => VerifyLoginOtp(verificationId: verificationId,)),
                            );
                          },
                          codeAutoRetrievalTimeout: (e) {
                            Utils().ToastMassege(e.toString());
                          });
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
