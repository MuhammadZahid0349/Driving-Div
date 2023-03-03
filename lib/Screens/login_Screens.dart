import 'package:driving_div/Screens/sign_Up_Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                          print("Logged in button Cliked .....");
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
}
