import 'package:amar_pharmacy/components/custom_button.dart';
import 'package:amar_pharmacy/utils/application_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _loadingButton = false;

  void signOutButtonPressed(){
    setState((){
      _loadingButton = true;
    }) ;
    Provider.of<ApplicationState>(context, listen: false).singOut();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Text(
              "Hi There",
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          CustomButton(
            text: "Sign Out",
            onPress: signOutButtonPressed,
            loading: _loadingButton,
          ),
        ],
      ),
    );
  }
}
