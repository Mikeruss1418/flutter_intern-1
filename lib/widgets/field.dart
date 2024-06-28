import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Field extends StatefulWidget {
  const Field(
      {super.key,
      this.controller,
      this.fliter,
      this.maxLength,
      required this.labeltxt,
      this.errortxt,
      this.maxlines,
      this.keyboard,
      this.onchange});

  final TextEditingController? controller;
  final TextInputFormatter? fliter;

  final int? maxLength;

  final String labeltxt;
  final String? errortxt;

  final Function(String)? onchange;
  final int? maxlines;
  final TextInputType? keyboard;

  @override
  State<Field> createState() => _FieldState();
}

class _FieldState extends State<Field> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: widget.keyboard,
      controller: widget.controller,
      maxLines: widget.maxlines,
      inputFormatters: [widget.fliter!],
      maxLength: widget.maxLength,
      onChanged: (val) {
        if (widget.onchange != null) {
          widget.onchange!(val);
        }
      },
      decoration: InputDecoration(
        labelText: widget.labeltxt,
        errorText: widget.errortxt,
        border: const OutlineInputBorder(),
        enabledBorder: const OutlineInputBorder(),
        focusedBorder: const OutlineInputBorder(),
        errorBorder: const OutlineInputBorder(),
      ),
    );
  }
}
