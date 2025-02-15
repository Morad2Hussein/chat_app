import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  const CustomButton({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return    Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        width: MediaQuery.of(context).size.width * 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextButton(
          onPressed: onPressed,
          child:  Text(text, style:const TextStyle(
            color:  Color(0XFF2271EA),
            fontFamily: 'pacifico',
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),),
        ),
      ),
    );
  }
}
/*
import 'package:chatapp/widgets/custom_button.dart';
import 'package:chatapp/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../constant.dart';

class SignupView extends StatelessWidget {
  SignupView({super.key});
  String? emailAddress;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            CircleAvatar(
              radius: 100,
              backgroundImage: kImage,
            ),
            const Text(
              textAlign: TextAlign.center,
              "Welcome to Chat",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 30,
                fontFamily: 'pacifico',
              ),
            ),
            const SizedBox(height: 25),
            const Padding(
              padding: EdgeInsets.only(top: 30.0, left: 20),
              child: Text(
                textAlign: TextAlign.start,
                "SignUp ",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: 'pacifico',
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              onChanged: (data) {
                emailAddress = data;
              },
              hinText: "email",
            ),
            CustomTextField(
              onChanged: (data) {
                password = data;
              },
              hinText: "password",
            ),
            CustomButton(
              onPressed: () async {
                if (emailAddress == null || password == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please enter email and password")),
                  );
                  return;
                }

                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return const Center(
                      child: CircularProgre ssIndicator(),
                    );
                  },
                );

                try {
                  var auth = FirebaseAuth.instance;
                  UserCredential user = await auth.createUserWithEmailAndPassword(
                    email: emailAddress!,
                    password: password!,
                  );
                  Navigator.of(context).pop(); // لإغلاق المؤشر
                  print("User signed up: ${user.user!.email}");
                } catch (e) {
                  Navigator.of(context).pop(); // لإغلاق المؤشر
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Error: $e")),
                  );
                }
              },
              text: "SignUp",
            ),

      ),
    );
  }
}

 */