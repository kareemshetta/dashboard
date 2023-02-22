import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  CustomButton(
      {required this.onPressed,
      required this.buttonTitle,
      this.radius = 0.0,
      this.color = Colors.lightBlue,
      this.buttonTextColor = Colors.white,
      this.isUpper = false,
      Key? key})
      : super(key: key);
  void Function()? onPressed;
  final String buttonTitle;
  final bool isUpper;
  final Color buttonTextColor;
  final Color color;
  final double radius;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(radius))),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          isUpper ? buttonTitle.toUpperCase() : buttonTitle,
          style: TextStyle(color: buttonTextColor),
        ),
      ),
    );
  }
}
