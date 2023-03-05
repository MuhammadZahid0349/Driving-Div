import 'package:driving_div/Screens/main_Screen.dart';
import 'package:driving_div/Screens/sign_Up_Screen.dart';
import 'package:driving_div/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              25.h.heightBox,
              Image(
                image: AssetImage("assets/logo.png"),
                width: 350.w,
                height: 250.h,
                alignment: Alignment.center,
              ),
              20.h.heightBox,
              "Login as a Rider".text.make(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: Column(
                  children: [
                    20.h.heightBox,
                    TextFormField(
                      controller: emailTextController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter Email';
                        } else if (!value.contains('@')) {
                          return 'Please enter Valid Email';
                        } else if (!value.contains('.com')) {
                          return 'Please enter Valid Email';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(fontSize: 14.sp),
                          hintStyle:
                              TextStyle(fontSize: 10.sp, color: Colors.grey)),
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    20.h.heightBox,
                    TextField(
                      controller: passwordTextController,
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(fontSize: 14.sp),
                          hintStyle:
                              TextStyle(fontSize: 10.sp, color: Colors.grey)),
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    20.h.heightBox,
                    ElevatedButton(
                        onPressed: () {
                          if (passwordTextController.text.isEmpty) {
                            displayToastMsg(
                                "Password is Mandatory !!", context);
                          } else {
                            loginedUser(context);
                          }
                        },
                        child: Text("Login")),
                    20.h.heightBox,
                    TextButton(
                        onPressed: () {
                          Get.to(() => SignUpScreen());
                        },
                        child: Text("Do not have an Account? Register Here!!"))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void loginedUser(BuildContext context) async {
    final User firebaseUser = (await _auth
            .signInWithEmailAndPassword(
                email: emailTextController.text,
                password: passwordTextController.text)
            .catchError((errMsg) {
      displayToastMsg("Error " + errMsg.toString(), context);
    }))
        .user!;
    // UserCredential userCredential = await _auth
    //     .signInWithEmailAndPassword(
    //         email: emailTextController.text.trim(),
    //         password: passwordTextController.text.trim())
    //     .catchError((errMsg) {
    //   displayToastMsg("Error " + errMsg.toString(), context);
    // });

    // final User user = userCredential.user!;

    if (firebaseUser != null) {
      userRef
          .child(firebaseUser.uid)
          .once()
          .then((value) => (DataSnapshot snap) {
                if (snap.value != null) {
                  Get.to(() => MainScreen());
                  displayToastMsg("Your are Logged in now!!", context);
                } else {
                  _auth.signOut();
                  displayToastMsg(
                      "No record exists for this user  \n Please create a new Account!!",
                      context);
                }
              });
    } else {
      displayToastMsg("Error Occured can not been Login!!", context);
    }
  }
}
