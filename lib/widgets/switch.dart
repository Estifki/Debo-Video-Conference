import 'package:flutter/material.dart';

class BottomSheetSwitch extends StatefulWidget {
  const BottomSheetSwitch(
      {Key? key,
      required this.label,
      required this.switchValue,
      required this.valueChanged})
      : super(key: key);

  final bool switchValue;
  final ValueChanged valueChanged;
  final String label;

  @override
  _BottomSheetSwitch createState() => _BottomSheetSwitch();
}

class _BottomSheetSwitch extends State<BottomSheetSwitch> {
  bool? _switchValue;

  @override
  void initState() {
    _switchValue = widget.switchValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
        title: Text(widget.label),
        value: _switchValue!,
        onChanged: (bool value) {
          setState(() {
            _switchValue = value;
            widget.valueChanged(value);
          });
        });
  }
}
