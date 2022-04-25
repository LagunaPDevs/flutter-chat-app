import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SendButton extends StatelessWidget {
  Function()? clickAction;

  SendButton({
    Key? key,
    this.clickAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      child: Platform.isIOS
          ? CupertinoButton(child: Text('Send'), onPressed: clickAction)
          : Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconTheme(
                data: IconThemeData(color: Colors.blue.shade400),
                child: IconButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  icon: Icon(
                    Icons.send,
                  ),
                  onPressed: clickAction,
                ),
              ),
            ),
    );
  }
}
