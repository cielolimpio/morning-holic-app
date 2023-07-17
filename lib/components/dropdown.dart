import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../constants/color.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> options;
  final String hint;
  final double width;
  final double height;
  final double fontSize;

  const CustomDropdown({
    Key? key,
    required this.options,
    this.hint = 'initial',
    this.width = 100.0,
    this.height = 50.0,
    this.fontSize = 20.0,
  }) : super(key: key);

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  double width = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    width = widget.width;
  }
  String? _selectedValue;
  bool _showMenu = false;

  BorderSide borderSide = const BorderSide(
    color: Colors.grey,
    width: 1.5,
  );

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        isExpanded: true,
        hint: _getHint(),
        items: widget.options
            .map((item) => _getDropdownMenuItem(item))
            .toList(),
        value: _selectedValue,
        onChanged: (value) => _onChanged(value),
        onMenuStateChange: (showMenu) => _onMenuStateChange(showMenu),
        buttonStyleData: _getButtonStyleData(),
        iconStyleData: _getIconStyleData(),
        dropdownStyleData: _getDropdownStyleData(),
        menuItemStyleData: _getMenuItemStyleData(),
      ),
    );
  }

  Row _getHint() {
    return Row(
      children:[
        Expanded(
          child: Text(
            widget.hint,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  DropdownMenuItem<String> _getDropdownMenuItem(String item) {
    return DropdownMenuItem<String>(
      value: item,
      child: Padding(
        padding: const EdgeInsets.only(left: 14, right: 14),
        child: Text(
          item,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }

  void _onChanged(String? value) {
    setState(() {
      _selectedValue = value as String;
    });
  }

  void _onMenuStateChange(bool showMenu) {
    setState(() {
      _showMenu = showMenu;
    });
  }

  ButtonStyleData _getButtonStyleData() {
    return ButtonStyleData(
      width: 100,
      height: 50,
      padding: _selectedValue == null
          ? const EdgeInsets.only(left: 14, right: 14)
          : null,
      decoration: BoxDecoration(
        borderRadius: _showMenu
            ? const BorderRadius.vertical(top: Radius.circular(10))
            : BorderRadius.circular(10),
        border: Border.all(
            color: PRIMARY_COLOR,
            width: 2.0
        ),
        color: Colors.white,
      ),
      elevation: 2,
    );
  }

  IconStyleData _getIconStyleData() {
    return IconStyleData(
      icon: Icon(
        _showMenu
            ? Icons.keyboard_arrow_up
            : Icons.keyboard_arrow_down,
        color: PRIMARY_COLOR,
      ),
      iconSize: 18,
    );
  }

  DropdownStyleData _getDropdownStyleData() {
    return DropdownStyleData(
      offset: const Offset(0, 2.0),
      maxHeight: 200,
      decoration: BoxDecoration(
        border: Border.fromBorderSide(borderSide),
        borderRadius: const BorderRadius.vertical(
            bottom: Radius.circular(10)
        ),
        color: Colors.white,
      ),
      scrollbarTheme: ScrollbarThemeData(
        radius: const Radius.circular(40),
        thickness: MaterialStateProperty.all<double>(6),
        thumbVisibility: MaterialStateProperty.all<bool>(true),
      ),
    );
  }

  MenuItemStyleData _getMenuItemStyleData() {
    return MenuItemStyleData(
        height: 40,
        selectedMenuItemBuilder: (ctx, child) {
          return Container(
            decoration: BoxDecoration(
                color: PRIMARY_COLOR,
                border: Border.symmetric(vertical: borderSide)
            ),
            child: child,
          );
        }
    );
  }
}
