
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Txt.dart';

Widget commonAppBar(String title){
  return AppBar(
    title: Txt(title,color: Colors.black),
    centerTitle: true,
    backgroundColor: Colors.orangeAccent.shade200,
  );
}