import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_learing/firebase_options.dart';
import 'package:firebase_learing/widgetOfWeek/animatedListView.dart';
import 'package:firebase_learing/widgetOfWeek/image_compresser_class.dart';
import 'package:firebase_learing/widgetOfWeek/image_compressor_widget_asiftaj.dart';
import 'package:firebase_learing/widgetOfWeek/whatsapp_like_message_grouping.dart';
import 'package:flutter/material.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:ThemeData(brightness: Brightness.light),
      darkTheme:ThemeData(brightness: Brightness.dark),
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      home: ImageCompressorWidget(),
    );
  }
}
