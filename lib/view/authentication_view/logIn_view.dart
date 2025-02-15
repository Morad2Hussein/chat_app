import 'package:chatapp/constant.dart';
import 'package:chatapp/methods/methods.dart';
import 'package:chatapp/widgets/custom_button.dart';
import 'package:chatapp/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  String? emailAddress;

  String? password;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
          backgroundColor: kPrimaryColor,
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.15,
                  ),
                  CircleAvatar(
                    radius: 110,
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
                  const SizedBox(height: 25,),
                  const Padding(
                    padding: EdgeInsets.only(top: 30.0, left: 20),
                    child: Text(
                      textAlign: TextAlign.start,
                      "LogIn",
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
                    validator: validateEmail,
                    type: TextInputType.emailAddress,
                    onChanged: (data) {
                      emailAddress = data;
                    },
                    hinText: "email",
                  ),
                  CustomTextField(
                    obscureText: true,
                    validator: validatePassword,
                    type: TextInputType.visiblePassword,
                    onChanged: (data) {
                      password = data;
                    },
                    hinText: "password",
                  ),

                  CustomButton( onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });

                      try {
                        UserCredential user = await signInUser(emailAddress!, password!);
                        showSnackBar(context, "Login successful");
                        Navigator.pushNamed(context, '/ChatView' , arguments: emailAddress);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          showSnackBar(context, 'No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          showSnackBar(context, 'Wrong password provided.');
                        } else {
                          showSnackBar(context, e.message ?? "Something went wrong");
                        }
                      } catch (e) {
                        showSnackBar(context, e.toString());
                      }

                      setState(() {
                        isLoading = false;
                      });
                    }
                  },
                      text: "LogIn"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "don't have an account",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'pacifico',
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/SingUp');
                          },
                          child: const Text(
                            "SignUp",
                            style: TextStyle(
                              color: Color(0XFF053CA6),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'pacifico',
                            ),
                          ))
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}


Future<UserCredential> signInUser(String email, String password) async {
  var auth = FirebaseAuth.instance;
  UserCredential user = await auth.signInWithEmailAndPassword(
    email: email,
    password: password,
  );
  return user;
}