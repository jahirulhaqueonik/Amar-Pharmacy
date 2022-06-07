import 'dart:developer';

import 'package:amar_pharmacy/components/custom_text_input.dart';
import 'package:amar_pharmacy/utils/application_state.dart';
import 'package:amar_pharmacy/utils/common.dart';
import 'package:amar_pharmacy/utils/custom_theme.dart';
import 'package:amar_pharmacy/utils/login_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/custom_button.dart';
import '../utils/login_data.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _loadingButton = false;

  Map<String, String> data = {};

  _LoginScreenState() {
    data = LoginData.signIn;
  }

  void switchLogin() {
    setState(() {
      if (mapEquals(data, LoginData.signUp)) {
        data = LoginData.signIn;
      } else {
        data = LoginData.signUp;
      }
    });
  }

  loginError(FirebaseAuthException e){
    log("error");
    if(e.message != ''){
      setState((){
        _loadingButton = false;
      });
      //need to show alert
      CommonUtil.showAlert(context,'Error Processing Your Request', e.message.toString());
    }
  }

  void loginButtonPressed () {
    setState((){
      _loadingButton = true;
    });
    ApplicationState applicationState = Provider.of(context,  listen: false);
    if(mapEquals(data, LoginData.signUp)){
      applicationState.signUp(_emailController.text, _passwordController.text, loginError);
    }else{
      applicationState.signIn(_emailController.text, _passwordController.text, loginError);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 40.0, bottom: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      data["heading"] as String,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
                  ),
                  Text(data["subHeading"] as String,
                      style: Theme.of(context).textTheme.bodySmall)
                ],
              ),
            ),
            model(data, _emailController, _passwordController),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 50,
                  child: TextButton(
                    onPressed: switchLogin,
                    child: Text(
                      data["footer"] as String,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
  model(Map<String, String> data, TextEditingController emailController,
      TextEditingController passwordController)  {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20.0),
      padding: const EdgeInsets.only(right: 20, left: 20, top: 30, bottom: 56),
      decoration: CustomTheme.getCardDecoration(),
      child: Column(
        children: [
          CustomTextInput(
              label: "Your email address",
              placeholder: "email@addres.com",
              icon: Icons.person_outlined,
              textEditingController: _emailController),

          CustomTextInput(
              label: "Password",
              placeholder: "password",
              password: true,
              icon: Icons.lock_outlined,
              textEditingController: _passwordController),

          CustomButton(text: data["label"] as String, onPress: loginButtonPressed, loading: _loadingButton),
        ],
      ),
    );
  }
}
