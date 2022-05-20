import 'dart:io';

import 'package:flutter/material.dart';

class StickyImageWidget extends StatelessWidget
{
  final String imageURI;
  const StickyImageWidget(this.imageURI, {Key? key}):
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          body: Image.file(
          File(imageURI),
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
    )));
  }
}