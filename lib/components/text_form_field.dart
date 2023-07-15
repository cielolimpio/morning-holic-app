import 'package:flutter/material.dart';
import 'package:morning_holic_app/constants/color.dart';

class CustomTextFormField extends StatefulWidget {
  final String? placeHolder;
  double width;
  double height;

  CustomTextFormField(
      {required this.placeHolder,
      this.width = 320.0,
      this.height = 30.0,
      super.key});

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  TextEditingController textarea = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textarea,
      cursorColor: GREY_COLOR,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 0,
          horizontal: 10.0,
        ),
        labelText: widget.placeHolder,
        labelStyle: const TextStyle(color: GREY_COLOR),
        suffixIcon: IconButton(
          icon: const Icon(Icons.highlight_remove_rounded),
          iconSize: 20.0,
          color: GREY_COLOR,
          onPressed: () {
            textarea.clear();
          },
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 0.2,
            color: GREY_COLOR,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 0.2,
            color: GREY_COLOR,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.never,
      ),
      style: const TextStyle(
        color: Colors.black,
        fontSize: 15.0,
      ),
    );
  }
}
