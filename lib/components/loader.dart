import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loader extends StatelessWidget {
  final double scale;
  const Loader({Key? key, this.scale = 1}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale,
      child: CircularProgressIndicator(
        color: Colors.black,
        semanticsLabel: 'Circular progess bar',
      ),
    );
  }
}
