import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:morning_holic_app/constants/color.dart';

class CustomTextFormField extends StatefulWidget {
  final TextEditingController textController;

  final String? placeHolder;
  String? Function(String?)? validator;
  bool isValidatorOn;

  List<TextInputFormatter>? textInputFormatters;
  int maxLength;

  CustomTextFormField({
    required this.textController,
    required this.placeHolder,
    this.validator,
    this.isValidatorOn = false,
    this.textInputFormatters,
    this.maxLength = 10,
    super.key,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textController,
      inputFormatters: widget.textInputFormatters,
      maxLength: widget.maxLength,
      cursorColor: GREY_COLOR,
      autovalidateMode: widget.isValidatorOn ? AutovalidateMode.always : AutovalidateMode.disabled,
      validator: widget.validator,
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
            widget.textController.clear();
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
        counterText: '',
      ),
      style: const TextStyle(
        color: Colors.black87,
        fontSize: 15.0,
      ),
    );
  }
}
