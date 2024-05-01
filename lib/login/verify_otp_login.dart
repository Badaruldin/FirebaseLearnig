import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_learing/homescreen/homescreen.dart';
import 'package:firebase_learing/signup/ButtonCustomWidget.dart';
import 'package:firebase_learing/utils/utils.dart';
import 'package:flutter/material.dart';

class VerifyLoginOtp extends StatefulWidget {
  const VerifyLoginOtp({Key? key, required this.verificationId})
      : super(key: key);

  final String verificationId;

  @override
  State<VerifyLoginOtp> createState() => _VerifyLoginOtpState();
}

class _VerifyLoginOtpState extends State<VerifyLoginOtp> {
  final _auth = FirebaseAuth.instance;
  final otpController = TextEditingController();

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
            children: [
              TextFormField(
                controller: otpController,
                decoration: const InputDecoration(
                    labelText: "Your OTP", border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                style: const TextStyle(
                  color: Colors.black45,
                ),
              ),
              ButtonCustomWidget(
                  widget: const Text("Verify"),
                  onPressed: () async {
                    final credential = PhoneAuthProvider.credential(
                        verificationId: widget.verificationId,
                        smsCode: otpController.toString());
                    try {
                      await _auth.signInWithCredential(credential);
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    } on Exception catch (e) {
                      Utils().ToastMassege(e.toString());
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
