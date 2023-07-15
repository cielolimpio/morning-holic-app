import 'package:flutter/material.dart';

import '../constants/color.dart';

class CustomRadioButton extends StatefulWidget {
  final List<String> options;
  final double fontSize;
  final double width;

  const CustomRadioButton({
    Key? key,
    required this.options,
    this.fontSize = 20.0,
    this.width = 140,
  }) : super(key: key);

  @override
  State<CustomRadioButton> createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  String _current = "";
  double width = 0;

  @override
  void initState() {
    super.initState();
    _current = widget.options.first;
    width = widget.width;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: widget.options.map((option) {
        return SizedBox(
          width: width,
          child: RadioListTile(
            activeColor: PRIMARY_COLOR,
            title: Text(option, overflow: TextOverflow.visible, maxLines: 1,),
            value: option,
            groupValue: _current,
            onChanged: (value) {
              setState(() {
                _current = value.toString();
              });
            },
            visualDensity: VisualDensity(horizontal: VisualDensity.minimumDensity),
            contentPadding: EdgeInsets.all(0),
          ),
        );
      }).toList(),
    );
  }
}
