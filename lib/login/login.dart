import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_learing/homescreen/homescreen.dart';
import 'package:firebase_learing/login/forgetPassword.dart';
import 'package:firebase_learing/login/loginwith_phoneno.dart';
import 'package:firebase_learing/signup/ButtonCustomWidget.dart';
import 'package:firebase_learing/signup/signup.dart';
import 'package:firebase_learing/utils/utils.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final _key = GlobalKey<FormState>();

  final FirebaseAuth auth = FirebaseAuth.instance;

  bool showCircle = false;

  void loginUser() {
    if (_key.currentState!.validate()) {
      setState(() {
        showCircle = true;
      });
      auth.signInWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text.trim())
          .then((value) {
        Utils().ToastMassege(value.user!.email.toString());
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
        setState(() {
          showCircle = false;
        });
      }).onError((error, stackTrace) {
        Utils().ToastMassege(error.toString());
        setState(() {
          showCircle = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login",
        ),
        centerTitle: true,
        leading: const Icon(Icons.login_outlined),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Form(
            key: _key,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: "Enter your Email",
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
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.password),
                      labelText: "Enter your Password",
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    obscuringCharacter: '^',
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter your Password first";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(height: 25.0),
                  ButtonCustomWidget(
                    widget: showCircle
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Login"),
                    onPressed: () {
                      loginUser();
                    },
                  ),
                  const SizedBox(height: 5.0),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgetPasswordScreen()),
                      );
                    },
                    child: Align(alignment: Alignment.bottomLeft,child: const Text("ForgetPassword?")),
                  ),
                  const SizedBox(height: 8.0),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUp()),
                      );
                    },
                    child: const Text("Don't have an account? SignUp"),
                  ),
                  const SizedBox(height: 5.0),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoginWithPhoneNo()),
                      );
                    },
                    child: const Text("Login with Phone No"),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
