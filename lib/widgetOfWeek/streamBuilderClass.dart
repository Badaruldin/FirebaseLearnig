import 'package:flutter/material.dart';

class StreamBuilderClass extends StatefulWidget {
  const StreamBuilderClass({Key? key}) : super(key: key);

  @override
  State<StreamBuilderClass> createState() => _StreamBuilderClassState();
}

Stream<String> streamifyFunction()async*{
  int str='A'.codeUnitAt(0);//Dart does not support char datatype. So, that's the reason you would go for int with CodeUnitAt
  while(str <= 'Z'.codeUnitAt(0)){
    await Future.delayed(const Duration(seconds: 1));
    yield String.fromCharCode(str); //then decompression from int to String
    str++;
    // yield str;
  }
}


class _StreamBuilderClassState extends State<StreamBuilderClass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Let's play with StreamBuilder")),
      body: Center(
        child: StreamBuilder(stream:streamifyFunction(),
          builder: (context,  snapshot) {
          return Text(snapshot.data.toString());
          },),
      ),
    );
  }
}
