import 'package:flutter/material.dart';
import 'package:unimapnav/util/color_resources.dart';

class CustomPasswordTextField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final TextInputAction? textInputAction;
  final Icon? prefixIcon;
  Function(String)? onChanged;
  CustomPasswordTextField({this.onChanged,this.controller, this.hintText, this.focusNode, this.nextNode, this.textInputAction, this.prefixIcon});

  @override
  _CustomPasswordTextFieldState createState() => _CustomPasswordTextFieldState();
}

class _CustomPasswordTextFieldState extends State<CustomPasswordTextField> {
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: widget.onChanged,
      cursorColor: Theme.of(context).primaryColor,
      controller: widget.controller,
      obscureText: _obscureText,
      focusNode: widget.focusNode,
      textInputAction: widget.textInputAction ?? TextInputAction.next,
      onFieldSubmitted: (v) {
        setState(() {
          widget.textInputAction == TextInputAction.done
              ? FocusScope.of(context).consumeKeyboardToken()
              : FocusScope.of(context).requestFocus(widget.nextNode);
        });
      },
      validator: (value) {
        return null;
      },
      decoration: InputDecoration(
          suffixIcon: IconButton(icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility), onPressed: _toggle),
          // prefixIcon: widget.prefixIcon ?? null,
          label: Text(widget.hintText ?? ''),
          contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 15),
          isDense: true,
          filled: false,
          fillColor:null,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: ColorResources.SILVER_GREY),
              borderRadius: BorderRadius.circular(15)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Theme.of(context).primaryColor),borderRadius: BorderRadius.circular(15)),
          border: InputBorder.none),
    );
  }
}
