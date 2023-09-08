import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:morning_holic_app/constants/color.dart';

class CustomPasswordTextFormField extends StatefulWidget {
  final TextEditingController textController;

  final String? placeHolder;
  String? Function(String?)? validator;

  double width;
  double height;
  List<TextInputFormatter>? textInputFormatters;
  int maxLength;

  CustomPasswordTextFormField({
    required this.placeHolder,
    required this.textController,
    this.validator,
    this.width = 320.0,
    this.height = 30.0,
    this.textInputFormatters,
    this.maxLength = 20,
    super.key,
  });

  @override
  State<CustomPasswordTextFormField> createState() => _CustomPasswordTextFormFieldState();
}

class _CustomPasswordTextFormFieldState extends State<CustomPasswordTextFormField> {
  bool _passwordVisible = false;

  @override
  void initState() {
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textController,
      inputFormatters: widget.textInputFormatters,
      maxLength: widget.maxLength,
      cursorColor: GREY_COLOR,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: widget.validator,
      obscureText: !_passwordVisible,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 0,
          horizontal: 10.0,
        ),
        labelText: widget.placeHolder,
        labelStyle: const TextStyle(color: GREY_COLOR),
        suffixIcon: IconButton(
          icon: Icon(
            _passwordVisible
            ? Icons.visibility_off
            : Icons.visibility
          ),
          iconSize: 20.0,
          color: GREY_COLOR,
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
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
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 0.4,
            color: Colors.red,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 0.4,
            color: Colors.red,
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
