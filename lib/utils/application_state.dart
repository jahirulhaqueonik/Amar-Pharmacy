import 'package:amar_pharmacy/utils/common.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
//import 'package:get/get.dart';

enum ApplicationLoginState { loggetOut, loogedIn }

class ApplicationState extends ChangeNotifier {
  User? user;

  ApplicationLoginState loginState = ApplicationLoginState.loggetOut;

  ApplicationState() {
    init();
  }

  Future<void> init() async {
    FirebaseAuth.instance.userChanges().listen((userFir) {
      if (userFir != null) {
        loginState = ApplicationLoginState.loogedIn;
        user = userFir;
      } else {
        loginState = ApplicationLoginState.loggetOut;
      }
      notifyListeners();
    });
  }

  Future<void> signIn(String email, String password,
      void Function(FirebaseAuthException e) errorCallBack) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      errorCallBack(e);
    }
  }

  Future<void> signUp(String email, String password,
      void Function(FirebaseAuthException e) errorCallBack) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      //stripe user create
      await CommonUtil.backendCall(userCredential.user!, CommonUtil.stripeUserCreate);

    } on FirebaseAuthException catch (e) {
      errorCallBack(e);
    }
  }

  void singOut() async{
    await FirebaseAuth.instance.signOut();
  }

}
