import 'package:flutter/material.dart';

import '../constants/color.dart';

class CustomRadioButton extends StatefulWidget {
  final List<String> options;
  final ValueChanged<String?> onChanged;
  final double fontSize;
  final String? currentValue;

  const CustomRadioButton({
    Key? key,
    required this.options,
    required this.onChanged,
    this.fontSize = 20.0,
    required this.currentValue,
  }) : super(key: key);

  @override
  State<CustomRadioButton> createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: widget.options.map((option) {
        return SizedBox(
          width: 140,
          height: 50,
          child: RadioListTile(
            activeColor: PRIMARY_COLOR,
            title: Text(option, overflow: TextOverflow.visible, maxLines: 1,),
            value: option,
            groupValue: widget.currentValue,
            onChanged: widget.onChanged,
            visualDensity: VisualDensity(horizontal: VisualDensity.minimumDensity),
            contentPadding: EdgeInsets.all(0),
          ),
        );
      }).toList(),
    );
  }
}
