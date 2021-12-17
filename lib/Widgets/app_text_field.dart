import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  // const AppTextField({Key? key}) : super(key: key);
  String hint;
  late final controller;
  AppTextField({required this.hint, required this.controller});
  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(hintText: "${widget.hint}"),
      validator: (val) => val!.isEmpty ? "Field is empty" : null,
      onChanged: (val) {
        setState(() {
          widget.controller = val;
        });
      },
    );
  }
}
