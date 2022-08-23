import 'package:chat_app_admin/screens/users_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyBZ2QLgt_rmLdrk_oUGlq0dLkELPKRhq7s",
        authDomain: "chat-app-2ea88.firebaseapp.com",
        projectId: "chat-app-2ea88",
        storageBucket: "chat-app-2ea88.appspot.com",
        messagingSenderId: "943054387069",
        appId: "1:943054387069:web:cf11c138d6b5f0c064fe14"
    ),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat App Admin',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UserScreen(),
    );
  }
}

