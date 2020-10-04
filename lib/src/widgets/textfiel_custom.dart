import 'package:flutter/material.dart';

class TextFieldCustom extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final TextInputType inputType;
  final TextEditingController textController;
  final bool obscureText;

  const TextFieldCustom({
    Key key,
    this.icon,
    this.hintText,
    this.inputType = TextInputType.text,
    this.textController,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black12,
            blurRadius: 12,
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 15),
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(this.icon),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              autocorrect: false,
              keyboardType: this.inputType,
              controller: this.textController,
              obscureText: this.obscureText,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: this.hintText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
