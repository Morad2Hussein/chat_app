import 'package:chatapp/methods/methods.dart';
import 'package:chatapp/widgets/custom_button.dart';
import 'package:chatapp/widgets/custom_text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../constant.dart';

class SingupView extends StatefulWidget {
  SingupView({super.key});

  @override
  State<SingupView> createState() => _SingupViewState();
}

class _SingupViewState extends State<SingupView> {
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
                  const SizedBox(
                    height: 25,
                  ),
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
                    type: TextInputType.emailAddress,

                    onChanged: (data) {
                      emailAddress = data;
                    },
                    hinText: "email",
                    validator: validateEmail,
                  ),
                  CustomTextField(
                    obscureText: true,
                    type: TextInputType.visiblePassword,
                    onChanged: (data) {
                      password = data;
                    },
                    hinText: "password",
                    validator: validatePassword,
                  ),
                  CustomButton(
                      onPressed: () async {
                        if(formKey.currentState!.validate()){
                          isLoading = true;
                          setState(() {

                          });
                          try {
                            UserCredential user = await resgisterUser();
                            showSnackBar(context,"success");
                            Navigator.pushNamed(context, '/ChatView' , arguments: emailAddress);

                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              print('The password provided is too weak.');
                              showSnackBar(context,'The password provided is too weak.');
                            } else if (e.code == 'email-already-in-use') {
                              print('The account already exists for that email.');
                              showSnackBar(context,'The account already exists for that email.');
                            }
                          } catch (e) {
                            showSnackBar(context,e.toString());
                          }
                          isLoading = false;
                          setState(() {

                          });
                        }

                        else{

                        }
                      },
                      text: "SignUp"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "already have an account",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'pacifico',
                        ),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "LogIn",
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



  Future<UserCredential> resgisterUser() async {
    var auth = FirebaseAuth.instance;
    UserCredential user =
        await auth.createUserWithEmailAndPassword(
            email: emailAddress!, password: password!);
    return user;
  }
}

