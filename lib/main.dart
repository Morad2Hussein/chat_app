
import 'package:chatapp/firebase_options.dart';
import 'package:chatapp/view/chat_view/chat_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';


import 'view/authentication_view/logIn_view.dart';
import 'view/authentication_view/singUp-view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/':(context)=> LoginView(),

        '/SingUp':(context)=> SingupView(),
        '/ChatView': (context) => ChatView(),

      },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute:   '/',
    );
  }
}


