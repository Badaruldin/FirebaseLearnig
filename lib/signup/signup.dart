import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_learing/login/login.dart';
import 'package:firebase_learing/signup/ButtonCustomWidget.dart';
import 'package:firebase_learing/utils/utils.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final auth = FirebaseAuth.instance;

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final _key = GlobalKey<FormState>();

  bool showCircle = false;

// final FirebaseAuth auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "SignUp",
        ),
        centerTitle: true,
        leading: const Icon(Icons.supervised_user_circle_rounded),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Expanded(
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
                      height: 20.0,
                    ),
                    TextFormField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.password),
                        labelText: "Enter your Password",
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                      obscuringCharacter: '&',
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     setState(() {
                      //       showCircle = false;
                      //     });
                      //     return "Enter your Password first";
                      //   } else {
                      //     return null;
                      //   }
                      // },
                    ),
                    const SizedBox(height: 25.0),
                    ButtonCustomWidget(
                      widget: showCircle
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text("Sign Up"),
                      onPressed: () {
                        signupUser(context);
                      },
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Login()),
                        );
                      },
                      child: const Text("Already have an account"),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  void signupUser(BuildContext context) {
    if (_key.currentState!.validate()) {
      setState(() {
        showCircle = true;
      });
      auth
          .createUserWithEmailAndPassword(
              email: emailController.text.trim(), password: passwordController.text.trim())
          .then(
        (value) {
          Utils().ToastMassege("${emailController.text} registered");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Login()),
          );
          setState(() {
            showCircle = false;
          });
        },
      ).onError(
        (error, stackTrace) {
          Utils().ToastMassege(error.toString());
          setState(
            () {
              showCircle = false;
            },
          );
        },
      );
    }
  }
}
