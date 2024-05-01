import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceClass extends StatefulWidget {
  const SharedPreferenceClass({Key? key}) : super(key: key);

  @override
  State<SharedPreferenceClass> createState() => _SharedPreferenceClassState();
}

final nameController = TextEditingController();
final ageController = TextEditingController();

class _SharedPreferenceClassState extends State<SharedPreferenceClass> {
  String name = '';
  String age = '';
  bool married = false;

  @override
  void initState() {
    super.initState();
    // sharedSupportFun();
  }

  void sharedSupportFun() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    name = sharedPreferences.getString('name')!;
    age = sharedPreferences.getString('age')!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Explore Shared Preferences"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder(
              future: SharedPreferences.getInstance(),
              builder: (context, snapshot) {
                return ListTile(
                    title: Text(snapshot.data?.getString('name') ?? ''),
                    subtitle: Text(snapshot.data?.getString('age')?? ''));
              }),
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
              hintText: "Your Name",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: ageController,
            decoration: const InputDecoration(
              hintText: "Your age",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          Text(name),
          Text(age.toString()),
          Text(married.toString()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();

          sharedPreferences.setString('name', nameController.text.toString());
          sharedPreferences.setString('age', ageController.text.toString());
          sharedPreferences.setBool('married', false);

          name = sharedPreferences.getString('name') ?? 'no val';
          age = sharedPreferences.getString('age')!;
          married = sharedPreferences.getBool('married')!;

          nameController.clear();
          ageController.clear();
          setState(() {});
        },
        backgroundColor: Colors.black,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.offline_share,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      //just checkout bottom sheet
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 5.0,
        color: Colors.deepPurple,
        padding: const EdgeInsets.all(8.0),
        height: 50.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Icon(
              Icons.hot_tub_outlined,
              color: Colors.grey,
            ),
            Icon(
              Icons.live_help_outlined,
              color: Colors.teal.withOpacity(1),
            ),
            Icon(
              Icons.fullscreen_exit_outlined,
              color: Colors.green.withOpacity(0.5),
            ),
            const Icon(
              Icons.push_pin_outlined,
              color: Colors.orangeAccent,
            )
          ],
        ),
      ),
    );
  }
}
