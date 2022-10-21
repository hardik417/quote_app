import 'package:flutter/material.dart';

class Txt extends StatelessWidget {
  String? text;
  Color? color;
  double? size;
  FontWeight? fontWeight;
  bool? isOverFlow;
  TextAlign? txtAlign;
  int? maxLine;
  String? fontFamily;
  bool isUnderline = false;

  Txt(this.text,
      {this.size, this.color, this.fontWeight, this.isOverFlow = false, this.txtAlign, this.maxLine, this.fontFamily, this.isUnderline = false});

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      textAlign: txtAlign ?? TextAlign.center,
      maxLines: maxLine ?? 1,
      style: TextStyle(
          color: color,
          fontSize: size,
          fontWeight: fontWeight,
          fontFamily: fontFamily ?? "Josefin Sans",
          decoration: isUnderline ? TextDecoration.underline : TextDecoration.none),
      overflow: isOverFlow! ? TextOverflow.ellipsis : TextOverflow.visible,
    );
  }
}
