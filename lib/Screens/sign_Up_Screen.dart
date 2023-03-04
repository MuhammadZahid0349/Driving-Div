import 'package:driving_div/Screens/login_Screens.dart';
import 'package:driving_div/Screens/main_Screen.dart';
import 'package:driving_div/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  TextEditingController nameTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController phoneTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              10.h.heightBox,
              Image(
                image: AssetImage("assets/logo.png"),
                width: 250.w,
                height: 250.h,
                alignment: Alignment.center,
              ),
              5.h.heightBox,
              "Sign Up as a Rider".text.make(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.h),
                child: Column(
                  children: [
                    5.h.heightBox,
                    TextFormField(
                      controller: nameTextController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: "Name",
                          labelStyle: TextStyle(fontSize: 14.sp),
                          hintStyle:
                              TextStyle(fontSize: 10.sp, color: Colors.grey)),
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    20.h.heightBox,
                    TextFormField(
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
                      controller: emailTextController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(fontSize: 14.sp),
                          hintStyle:
                              TextStyle(fontSize: 10.sp, color: Colors.grey)),
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    20.h.heightBox,
                    TextFormField(
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(11),
                      ],
                      controller: phoneTextController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          labelText: "Phone",
                          labelStyle: TextStyle(fontSize: 14.sp),
                          hintStyle:
                              TextStyle(fontSize: 10.sp, color: Colors.grey)),
                      style: TextStyle(fontSize: 14.sp),
                    ),
                    20.h.heightBox,
                    TextFormField(
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
                          if (nameTextController.text.length < 5) {
                            displayToastMsg(
                                "Name must be at least 4 characters", context);
                          } else if (phoneTextController.text.isEmpty) {
                            displayToastMsg(
                                "Phone Number is mandatory", context);
                          } else if (passwordTextController.text.length < 6) {
                            displayToastMsg(
                                "Password must be at least 6 characters",
                                context);
                          } else {
                            registerNewUser(context);
                          }
                        },
                        child: Text("Create Account")),
                    10.h.heightBox,
                    TextButton(
                        onPressed: () {
                          Get.to(() => LoginScreen());
                        },
                        child: Text("Already have an Account? Login Here!!"))
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

  void registerNewUser(BuildContext context) async {
    
    // final User firebaseUser = (await _auth.createUserWithEmailAndPassword(email: emailTextController.text, password: passwordTextController.text)).user!;

    UserCredential userCredential = await _auth
        .createUserWithEmailAndPassword(
            email: emailTextController.text.trim(),
            password: passwordTextController.text.trim())
        .catchError((errMsg) {
      displayToastMsg("Error " + errMsg.toString(), context);
    });

    final User user = userCredential.user!;

    if (userCredential != null) {
      Map userDataMap = {
        "name": nameTextController.text.trim(),
        "email": emailTextController.text.trim(),
        "phone": phoneTextController.text.trim(),
        "password": passwordTextController.text.trim(),
      };
      userRef.child(user.uid).set(userDataMap);
      displayToastMsg(
          "Congrulations, Your Account has been Created!!", context);
      Get.to(() => MainScreen());
    } else {
      displayToastMsg("New User Account has not been Created!!", context);
    }
  }
}

displayToastMsg(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}
