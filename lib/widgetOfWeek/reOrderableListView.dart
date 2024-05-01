import 'package:flutter/material.dart';

class ReOrderableListViewClass extends StatefulWidget {
  const ReOrderableListViewClass({Key? key}) : super(key: key);

  @override
  State<ReOrderableListViewClass> createState() =>
      _ReOrderableListViewClassState();
}

List<String> thingList = ["Waseem","Jutti","Nimara","Sheeraz","Tiaba","Sameen"];

class _ReOrderableListViewClassState extends State<ReOrderableListViewClass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dynamic ListView.builder"),
      ),
      body: ReorderableListView.builder(
          itemBuilder: (context, index) {
            return ListTile(shape: const OutlineInputBorder(),
                key: ValueKey(thingList[index]),
                title: Text(thingList[index]));
          },
          itemCount: thingList.length,
          onReorder: (oldIndex, newIndex) {
           setState(() {
             if (newIndex > oldIndex) {
               newIndex--;
             }
             final elem = thingList.removeAt(oldIndex);
             thingList.insert(newIndex, elem);
           });
          }),
    );
  }
}
