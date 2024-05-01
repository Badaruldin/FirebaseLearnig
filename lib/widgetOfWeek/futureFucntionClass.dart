import 'package:flutter/material.dart';

class FutureFunctionClass extends StatefulWidget {
  const FutureFunctionClass({Key? key}) : super(key: key);

  @override
  State<FutureFunctionClass> createState() => _FutureFunctionClassState();
}

int iteration = 0;

Future<DateTime> upcomingFunction() async {
  iteration++;
 await Future.delayed(const Duration(seconds: 1));
   return DateTime.now();
  // return iteration;
}

class _FutureFunctionClassState extends State<FutureFunctionClass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Let's move on Future Function")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
                onPressed: (){
                  upcomingFunction();
                  setState(() {});
                },
                child: const Text("Update Value")),
            FutureBuilder(
                future: upcomingFunction(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.connectionState ==
                          ConnectionState.active ||
                      snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasData) {
                      return InkWell(
                        onTap: () {
                          upcomingFunction();
                          setState(() {});
                        },
                        child: Text(snapshot.data.toString(),
                            style: const TextStyle(fontSize: 25.0)),
                      );
                    } else if (snapshot.hasError) {
                      return const Text(
                        "Something went wrong",
                        style: TextStyle(fontSize: 25.0),
                      );
                    }
                  }
                  return Text(
                    snapshot.data.toString(),
                    style: const TextStyle(fontSize: 25.0),
                  );
                })
          ],
        ),
      ),
    );
  }
}
