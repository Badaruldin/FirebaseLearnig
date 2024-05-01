import 'package:flutter/material.dart';

class CustomDropDownList extends StatefulWidget {
  const CustomDropDownList({Key? key}) : super(key: key);

  @override
  State<CustomDropDownList> createState() => _CustomDropDownListState();
}

final List<String> players = [
  'Babar Azam',
  'Fakhar Zaman',
  'M Rizwan',
  'S Afridi',
  'Amar Jammal'
];
bool isOpen = false;
String selectedVal='Select Option';
class _CustomDropDownListState extends State<CustomDropDownList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Drop Down Button'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  isOpen = !isOpen;
                  setState(() {});
                },
                child: Container(
                  height: 50.0,
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  decoration: BoxDecoration(
                      color: Colors.grey,
                      border: Border.all(color: Colors.black, width: 1)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(selectedVal),
                      isOpen? Icon(Icons.arrow_drop_down):Icon(Icons.arrow_drop_up),
                    ],
                  ),
                ),
              ),
              if (isOpen)
                ListView(
                  primary: true,
                  shrinkWrap: true,
                  children: players
                      .map(
                        (e) => InkWell(
                          onTap: () {
                            selectedVal=e;
                            isOpen = false;
                            setState(() {});
                          },
                          child: Card(
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              height: 50.0,
                              decoration: BoxDecoration(
                                  color: Colors.grey,
                                  border: Border.all(
                                      color: Colors.black, width: 1.0)),
                              child: Text(
                                e.toString(),
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                )
            ],
          ),
        ),
      ),
    );
  }
}

//Traditional method
//import 'package:flutter/material.dart';
//
// class CustomDropDownList extends StatefulWidget {
//   const CustomDropDownList({Key? key}) : super(key: key);
//
//   @override
//   State<CustomDropDownList> createState() => _CustomDropDownListState();
// }
//
// final List<String> players = ['Babar Azam', 'Fakhar Zaman', 'M Rizwan', 'S Afridi', 'Amaar Jammal'];
//
// class _CustomDropDownListState extends State<CustomDropDownList> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               DropdownButtonFormField(
//                   value:players[0],
//                   items: players.map((e) => DropdownMenuItem(value: e,child: Text(e))).toList(),
//                   onChanged: (selectedVal){
//                 setState(() {
//                 });
//                   })
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
