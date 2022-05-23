import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SingleProductWidget extends StatelessWidget {
 // const SingleProductWidget({Key? key}) : super(key: key);

  List<String> _carouselImages = [];
  var _dotPosition = 0;
  List _products = [];
  var _firestoreInstance = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}
