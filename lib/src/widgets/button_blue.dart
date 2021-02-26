import 'package:flutter/material.dart';

class ButtonBlue extends StatelessWidget {
  final String text;

  final Function onPressed;

  const ButtonBlue({Key key, @required this.text, @required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      elevation: 2,
      highlightElevation: 5,
      color: Colors.blue,
      shape: StadiumBorder(),
      child: Container(
        width: double.infinity,
        height: 45,
        child: Center(
            child: Text(this.text,
                style: TextStyle(color: Colors.white, fontSize: 17))),
      ),
      onPressed: this.onPressed,
    );
  }
}
