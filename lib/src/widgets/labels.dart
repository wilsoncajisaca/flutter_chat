import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String rute;
  final String title;
  final String buttomTitle;

  const Labels({
    Key key,
    @required this.rute,
    @required this.title,
    @required this.buttomTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                this.title,
                style: TextStyle(fontWeight: FontWeight.w400),
              ),
              RaisedButton(
                shape: StadiumBorder(),
                color: Colors.transparent,
                elevation: 0,
                child: Text(
                  this.buttomTitle,
                  style: TextStyle(
                    color: Colors.blue[500],
                  ),
                ),
                onPressed: () {
                  Navigator.pushReplacementNamed(context, rute);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
