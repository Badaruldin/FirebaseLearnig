import 'dart:async';

import 'package:flutter/material.dart';

class StreamBuilderSocket extends StatefulWidget {
  const StreamBuilderSocket({Key? key}) : super(key: key);

  @override
  State<StreamBuilderSocket> createState() => _StreamBuilderSocketState();
}

StreamSocketFunctionality stream = StreamSocketFunctionality();

List<String> listOfMessages = ['Faizan'];
final textController = TextEditingController();

class _StreamBuilderSocketState extends State<StreamBuilderSocket> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Move on to Stream 2.0 version"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: StreamBuilder(
              stream: stream.getResponse,
              builder: (context, snapshot) {
                return ListView.builder(itemCount: listOfMessages.length,
                itemBuilder: (context,index){
                  return Card(child: ListTile(title:Text(listOfMessages[index])),);
                });
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: TextFormField(controller: textController,
                      decoration:
                          const InputDecoration(border: OutlineInputBorder()))),
              IconButton(
                  onPressed: () {
                    listOfMessages.add(textController.text.toString());
                    stream.addResponse(listOfMessages);
                    textController.clear();
                  },
                  icon: const Icon(Icons.send_outlined))
            ],
          )
        ],
      ),
    );
  }
}

class StreamSocketFunctionality {
  final _streamController = StreamController<List<String>>.broadcast();

  void Function(List<String>) get addResponse => _streamController.sink.add;//to add data to stream

  Stream<List<String>> get getResponse =>
      _streamController.stream.asBroadcastStream();//always listening data from stream
}
