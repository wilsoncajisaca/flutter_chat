import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Logo extends StatelessWidget {
  final String title;

  const Logo({Key key, this.title = 'Bienvenido a Messenger'})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Column(
          children: [
            SvgPicture.asset(
              'assets/svg/login.svg',
              height: MediaQuery.of(context).size.height * 0.35,
            ),
            SizedBox(height: 15),
            Text(
              this.title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.blue[500],
              ),
            )
          ],
        ),
      ),
    );
  }
}
