import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_flutter/provider.dart';
import 'package:firebase_flutter/views/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => schoolProvider(),
      )
    ],
    builder: (context, child) {
      return MaterialApp(
          initialRoute: '/',
          debugShowCheckedModeBanner: false,
          routes: {
            '/': (context) => const HomePage(),
          });
    },
  ));
}
