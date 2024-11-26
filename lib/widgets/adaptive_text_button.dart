import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

class AdaptiveTextButton extends StatelessWidget {
  final String text;
  final Function handler;

  AdaptiveTextButton(this.text,this.handler)
  @override
  Widget build(BuildContext context) {
    return  Platform.isIOS
        ? CupertinoButton(
        child: Text(
          text,
          style: TextStyle(
              color: CupertinoTheme.of(context).primaryColor,
              fontWeight: FontWeight.bold),
        ),
        onPressed: handler)
        : TextButton(
        onPressed: handler,
        child: Text(
          text,
          style: TextStyle(
              color: Theme.of(context).colorScheme.secondary,
              fontWeight: FontWeight.bold),
        ));
  }
}
