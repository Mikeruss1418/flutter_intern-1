import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Field extends StatefulWidget {
  const Field(
      {super.key,
      this.controller,
      required this.fliter,
      this.maxLength,
      required this.labeltxt,
      this.errortxt,
      this.maxlines,
      this.minlines,
      this.keyboard,
      this.onchange});

  final TextEditingController? controller;
  final TextInputFormatter fliter;
  final int? maxLength;//can also use LengthLimitingTextInputFormatter(int)

  final String labeltxt;
  final String? errortxt;

  final Function(String)? onchange;
  final int? maxlines;
  final int? minlines;
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
      
      minLines: widget.minlines,// here by setting the maxLines and minLines i can create a dynamic textfield which only expand 
                                //when it goes to next line
      maxLines: widget.maxlines,
      inputFormatters: [widget.fliter,],
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
