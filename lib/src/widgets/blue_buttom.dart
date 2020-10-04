import 'package:flutter/material.dart';

class BlueButtom extends StatelessWidget {
  final String titleText;
  final Function onPressed;

  const BlueButtom({
    Key key,
    @required this.titleText,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Colors.blue[300],
      shape: StadiumBorder(),
      child: Container(
        width: double.infinity,
        height: 40,
        child: Center(
          child: Text(
            this.titleText,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      onPressed: this.onPressed,
    );
  }
}
