import 'dart:async';
import 'package:amar_pharmacy/ui/registration_screen.dart';
import 'package:amar_pharmacy/ui/user_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../const/AppColors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'login_screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // splash_screen Timer
    Timer(Duration(seconds: 3),()=>Navigator.push(context, CupertinoPageRoute(builder: (_)=>LoginScreen())));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg_red,
      body: SafeArea(
        child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Amar Pharmacy',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 44.sp),
                ),
                SizedBox(height: 12.h,),
                const CircularProgressIndicator(
                  color: Colors.white,
                )
              ],)
        ),
      ),
    );
  }
}
