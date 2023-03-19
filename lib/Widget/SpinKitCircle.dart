
import 'package:flutter/material.dart';

class SpinKitCircle extends StatelessWidget {
 double size;
 Color color;
 SpinKitCircle({@required this.color, @required this.size});
  @override
  Widget build(BuildContext context) {
    
    return Container(
      height: size,
      width: size,
      child: CircularProgressIndicator(color: color,),
    );}}