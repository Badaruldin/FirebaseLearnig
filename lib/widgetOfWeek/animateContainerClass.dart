import 'dart:math';
import 'package:flutter/material.dart';
class AnimatedContainerClass extends StatefulWidget {
  const AnimatedContainerClass({Key? key}) : super(key: key);

  @override
  State<AnimatedContainerClass> createState() => _AnimatedContainerClassState();
}
double _width=150;
double _height=100;
Color? _color=Colors.pink;
class _AnimatedContainerClassState extends State<AnimatedContainerClass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.move_up_outlined),
        title: const Text("wanna some Animations?"),
        backgroundColor: _color,
      ),
      body: Center(
        child: AnimatedContainer(
            height: _height,
            width: _width,
            color: _color,
            duration: const Duration(seconds: 1)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Random rand=Random();
          _height=rand.nextInt(450).toDouble();
          _width=rand.nextInt(300).toDouble();
          _color=Color.fromRGBO(rand.nextInt(256), rand.nextInt(256), rand.nextInt(256), 1);
          // _color=Color.fromARGB(rand.nextInt(256), rand.nextInt(256), rand.nextInt(256), 1);
          setState(() {

          });
        },
        backgroundColor: _color,
        // shape: const OutlineInputBorder(),
        child: const Icon(Icons.animation_outlined),
      ),
    );
  }
}
