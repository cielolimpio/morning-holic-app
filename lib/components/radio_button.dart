import 'package:flutter/material.dart';

import '../constants/color.dart';

class CustomRadioButton extends StatefulWidget {
  final List<String> options;
  final double fontSize;

  const CustomRadioButton({
    Key? key,
    required this.options,
    this.fontSize = 20.0,
  }) : super(key: key);

  @override
  State<CustomRadioButton> createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  String _current = "";

  @override
  void initState() {
    super.initState();
    _current = widget.options.first;
  }

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
