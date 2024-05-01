import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WhatsappLikeMessageGrouping extends StatefulWidget {
  const WhatsappLikeMessageGrouping({Key? key}) : super(key: key);

  @override
  State<WhatsappLikeMessageGrouping> createState() =>
      _WhatsappLikeMessageGroupingState();
}

class _WhatsappLikeMessageGroupingState
    extends State<WhatsappLikeMessageGrouping> {
  List<MessageModel> messagesList = [
    MessageModel(
        timeStamp: DateTime.now().microsecondsSinceEpoch,
        message: "Sheeraz",
        isMe: true),
    MessageModel(
        timeStamp: DateTime.now().microsecondsSinceEpoch,
        message: "Faizan",
        isMe: true),
    MessageModel(
        timeStamp: DateTime.now().microsecondsSinceEpoch,
        message: "Kashif",
        isMe: false),
    MessageModel(
        timeStamp: DateTime.now().microsecondsSinceEpoch,
        message: "Waseem",
        isMe: true),
    MessageModel(
        timeStamp: DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day - 1,
          DateTime.now().hour,
          DateTime.now().minute,
          DateTime.now().second,
        ).microsecondsSinceEpoch,
        message: "Javaid",
        isMe: false),
    //yesterday msg
    MessageModel(
        timeStamp: DateTime(
                DateTime.now().year,
                DateTime.now().month,
                DateTime.now().day - 1,
                DateTime.now().hour,
                DateTime.now().minute)
            .microsecondsSinceEpoch,
        message: "Usman",
        isMe: false),
    MessageModel(
        timeStamp: DateTime(
                DateTime.now().year,
                DateTime.now().month,
                DateTime.now().day - 2,
                DateTime.now().hour,
                DateTime.now().minute)
            .microsecondsSinceEpoch,
        message: "Ali Haidar",
        isMe: false),
  ];

//to convert Microseconds
  DateTime convertingDateAndTimeFormat(String timeInput) {
    var formattedDate =
        DateTime.fromMicrosecondsSinceEpoch(int.parse(timeInput));
    return DateTime(formattedDate.year, formattedDate.month, formattedDate.day);
  }

  String groupingMessageDateAndTime(String time) {
    var inputDateTime = DateTime.fromMicrosecondsSinceEpoch(int.parse(time));
    final todayDate = DateTime.now();
    final today = DateTime(todayDate.year, todayDate.month, todayDate.day);
    final yesterday =
        DateTime(todayDate.year, todayDate.month, todayDate.day - 1);
    String diff = '';
    var inputDate =
        DateTime(inputDateTime.year, inputDateTime.month, inputDateTime.day);

    if (inputDate == today) {
      diff = "Today";
    } else if (inputDate == yesterday) {
      diff = 'Yesterday';
    } else {
      diff = DateFormat.yMMMd().format(inputDateTime).toString();
    }
    return diff;
  }

  //message time in 24 hours format AM/PM
  String messageRealTime(String inputTime) {
    var inputDateTime =
        DateTime.fromMicrosecondsSinceEpoch(int.parse(inputTime));
    String time = DateFormat('jm').format(inputDateTime).toString();
    return time;
  }

  //controllers
  final msgController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Expanded(
              child: ListView.builder(
                  controller: _scrollController,
                  shrinkWrap: true,
                  reverse: true,
                  itemCount: messagesList.length,
                  physics: const ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    bool isSameDate = false;
                    String newDate = '';

                    final DateTime finalDate = convertingDateAndTimeFormat(
                        messagesList[index].timeStamp.toString());

                    if (index == 0 && messagesList.length == 1) {
                      newDate = groupingMessageDateAndTime(
                          messagesList[index].timeStamp.toString());
                    } else if (index == messagesList.length - 1) {
                      newDate = groupingMessageDateAndTime(
                          messagesList[index].timeStamp.toString());
                    } else {
                      final date = convertingDateAndTimeFormat(
                          messagesList[index].timeStamp.toString());
                      final previousMsgDate = convertingDateAndTimeFormat(
                          messagesList[index + 1].timeStamp.toString());

                      isSameDate = date.isAtSameMomentAs(previousMsgDate);

                      newDate = isSameDate
                          ? ''
                          : groupingMessageDateAndTime(
                                  messagesList[index - 1].timeStamp.toString())
                              .toString();
                    }
                    return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                            crossAxisAlignment: messagesList[index].isMe
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: [
                              if (newDate.isNotEmpty)
                                Center(
                                    child: Container(
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black54,
                                                width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                            color: Colors.lightGreen),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(newDate),
                                        ))),
                              Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 5.0),
                                  child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      color: messagesList[index].isMe
                                          ? Colors.lightGreen.shade200
                                          : Colors.pinkAccent.shade100,
                                      child: Align(
                                          alignment: messagesList[index].isMe
                                              ? Alignment.topRight
                                              : Alignment.topLeft,
                                          child: Stack(children: [
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 5.0,vertical: 10.0),
                                              child: Text(
                                                messagesList[index].message,
                                                style: const TextStyle(
                                                    fontSize: 18.0),
                                              ),
                                            ),
                                            Positioned(
                                                bottom: 0,
                                                right: 0,
                                                child: Text(
                                                  messageRealTime(
                                                      messagesList[index]
                                                          .timeStamp
                                                          .toString()),
                                                  style:
                                                      const TextStyle(fontSize: 10.0),
                                                  textAlign: TextAlign.right,
                                                )),
                                          ]))))
                            ]));
                  })),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(children: [
                Expanded(
                  child: TextFormField(
                    controller: msgController,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                ),
                GestureDetector(
                  child: CircleAvatar(
                      child: Icon(Icons.send_outlined, color: Colors.green)),
                  onTap: () {
                    MessageModel newModelmsg = MessageModel(
                        timeStamp: DateTime.now().microsecondsSinceEpoch,
                        message: msgController.text.toString(),
                        isMe: true);
                    messagesList.insert(0, newModelmsg);
                    msgController.clear();

                    setState(() {});
                  },
                )
              ]),
            ),
          )
        ]),
      ),
    );
  }
}

//model for adding data to List
class MessageModel {
  int timeStamp;
  String message;
  bool isMe;

  MessageModel(
      {required this.timeStamp, required this.message, required this.isMe});
}
