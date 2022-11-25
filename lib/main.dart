import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sunglasses/Admin/admin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFf8f3f7),
          primaryColor: Colors.blueGrey,
          primarySwatch: Colors.indigo,
          iconTheme: const IconThemeData(color: Colors.blueGrey),
          textTheme: const TextTheme(
              headline1: TextStyle(fontSize: 50, color: Colors.black26))),
      home: const Admin(),
    );
  }
}
