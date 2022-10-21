import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WidgetButton extends StatelessWidget {
  WidgetButton({required this.onPressed,
    required this.text, required this.height, required this.minWidth,


  });
  final GestureTapCallback onPressed;
  final String text;
  final double height;
  final double minWidth;

  @override
  Widget build(BuildContext context,) {
    return
      MaterialButton(
        height: height,minWidth: minWidth,
        color: Colors.blue,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: onPressed,
        child:  Text(text.toString(),style: const TextStyle(color: Colors.white,fontSize: 15)));
  }
}