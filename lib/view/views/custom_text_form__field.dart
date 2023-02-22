import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  CustomTextFormField(
      {this.isPassword = false,
      this.isEnable = true,
      this.onTap,
      this.keyBoardType = TextInputType.text,
      this.hintText,
      this.onChange,
      this.onSubmit,
      this.prefixIcon,
      this.labelWidget,
      this.suffixIcon,
      this.raduis = 0.0,
      required this.controller,
      this.validator,
      Key? key})
      : super(key: key);
  bool isPassword;
  bool isEnable;
  double raduis;
  TextEditingController controller;
  String? Function(String? value)? validator;
  final void Function()? onTap;
  void Function(String value)? onChange;
  void Function(String value)? onSubmit;
  final String? hintText;
  Widget? labelWidget;
  TextInputType keyBoardType;
  Widget? suffixIcon;
  Widget? prefixIcon;
  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        textAlign: TextAlign.center,
        enabled: widget.isEnable,
        onFieldSubmitted: widget.onSubmit,
        onChanged: widget.onChange,
        onTap: widget.onTap,
        controller: widget.controller,
        validator: widget.validator,
        obscureText: widget.isPassword,
        keyboardType: widget.keyBoardType,
        decoration: InputDecoration(
          label: widget.labelWidget,
          contentPadding: const EdgeInsets.all(2.0),
          suffixIcon: widget.suffixIcon,
          prefixIcon: widget.prefixIcon,
          hintText: widget.hintText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(widget.raduis))),
        ),
      ),
    );
  }
}
