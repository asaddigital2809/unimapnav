import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unimapnav/util/color_resources.dart';

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final TextInputType? textInputType;
  final Function()? onTap;
  final int? maxLine;
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final TextInputAction? textInputAction;
  final bool isPhoneNumber;
  final bool isValidator;
  final String? validatorMessage;
  final Color? fillColor;
  final TextCapitalization capitalization;
  final Icon? prefixIcon;
  final String? initialValue;
  final bool isEnabled;
  final int? maxLength;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;
  CustomTextField(
      {this.controller,
        this.onTap,
      this.labelText,
      this.textInputType,
      this.maxLine,
      this.focusNode,
      this.nextNode,
      this.textInputAction,
      this.isPhoneNumber = false,
      this.isValidator = false,
      this.validatorMessage,
      this.capitalization = TextCapitalization.none,
      this.fillColor,
      this.prefixIcon,
      this.initialValue,
      this.isEnabled = true,
      this.maxLength,
      this.onChanged,
        this.onEditingComplete
      });

  @override
  Widget build(context) {
    return TextFormField(
      onTap: onTap,
      controller: controller,
      maxLines: maxLine ?? 1,
      textCapitalization: capitalization,
      maxLength: isPhoneNumber ? 15 : maxLength,
      focusNode: focusNode,
      keyboardType: textInputType ?? TextInputType.text,
      //keyboardType: TextInputType.number,
      initialValue: initialValue,
      enabled: isEnabled,
      textInputAction: textInputAction ?? TextInputAction.next,
      onFieldSubmitted: (v) {
        if (nextNode == null) {
          FocusManager.instance.primaryFocus?.unfocus();
        } else {
          FocusScope.of(context).requestFocus(nextNode);
        }
      },
      onEditingComplete: onEditingComplete,
      onChanged: onChanged,
      //autovalidate: true,
      inputFormatters: [
        isPhoneNumber
            ? FilteringTextInputFormatter.digitsOnly
            : FilteringTextInputFormatter.singleLineFormatter
      ],
      validator: (input) {
        if (input!.isEmpty) {
          if (isValidator) {
            return validatorMessage ?? "";
          }
        }
        return null;
      },
      decoration: InputDecoration(

        filled: fillColor != null,
        // prefixIcon: prefixIcon ?? null,
        fillColor: fillColor,
        contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 15),
        isDense: true,
        counterText: '',
        label: Text(labelText ?? ''),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(15)),
        enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: ColorResources.SILVER_GREY),
    borderRadius: BorderRadius.circular(15)),

        errorStyle: TextStyle(
            color: Colors.red[400],
            fontWeight: FontWeight.bold,
            fontSize: 13,
            height: 2),
        // errorBorder: OutlineInputBorder(
        //     borderSide: BorderSide(color: ColorResources.getRed(context)),
        //     borderRadius: BorderRadius.circular(15)),
        border: InputBorder.none,
      ),
    );
  }
}
class CustomTextFieldSearch extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? textInputType;
  final int? maxLine;
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final TextInputAction? textInputAction;
  final bool isPhoneNumber;
  final bool isValidator;
  final String? validatorMessage;
  final Color? fillColor;
  final TextCapitalization capitalization;
  final Icon? prefixIcon;
  final Widget? suffixIcon;
   final bool? autoFocus;
  final String? initialValue;
  final bool isEnabled;
  final int? maxLength;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;
  CustomTextFieldSearch(
      {this.controller,
      this.hintText,
      this.textInputType,
      this.maxLine,
      this.focusNode,
      this.nextNode,
        this.autoFocus,
      this.textInputAction,
      this.isPhoneNumber = false,
      this.isValidator = false,
      this.validatorMessage,
      this.capitalization = TextCapitalization.none,
      this.fillColor,
      this.prefixIcon,
      this.initialValue,
        this.suffixIcon,
      this.isEnabled = true,
      this.maxLength,
      this.onChanged,
        this.onEditingComplete
      });

  @override
  Widget build(context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLine ?? 1,
      textCapitalization: capitalization,
      maxLength: isPhoneNumber ? 15 : maxLength,
      focusNode: focusNode,
      autofocus: autoFocus ?? false,
      keyboardType: textInputType ?? TextInputType.text,
      //keyboardType: TextInputType.number,
      initialValue: initialValue,
      enabled: isEnabled,
      textInputAction: textInputAction ?? TextInputAction.next,
      onFieldSubmitted: (v) {
        if (nextNode == null) {
          FocusManager.instance.primaryFocus?.unfocus();
        } else {
          FocusScope.of(context).requestFocus(nextNode);
        }
      },
      onEditingComplete: onEditingComplete,
      onChanged: onChanged,
      //autovalidate: true,
      inputFormatters: [
        isPhoneNumber
            ? FilteringTextInputFormatter.digitsOnly
            : FilteringTextInputFormatter.singleLineFormatter
      ],
      validator: (input) {
        if (input!.isEmpty) {
          if (isValidator) {
            return validatorMessage ?? "";
          }
        }
        return null;
      },
      style: TextStyle(
        color: ColorResources.WHITE
      ),
      decoration: InputDecoration(
        filled: fillColor != null,
        prefixIcon: prefixIcon ?? null,
        suffixIcon: suffixIcon ?? null,
        fillColor: fillColor,
        contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 15),
        isDense: true,
        counterText: '',
        label: Text(hintText ?? ''),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(15)),
        enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: ColorResources.WHITE),
    borderRadius: BorderRadius.circular(15)),

        errorStyle: TextStyle(
            color: Colors.red[400],
            fontWeight: FontWeight.bold,
            fontSize: 13,
            height: 2),
        // errorBorder: OutlineInputBorder(
        //     borderSide: BorderSide(color: ColorResources.getRed(context)),
        //     borderRadius: BorderRadius.circular(15)),
        border: InputBorder.none,
      ),
    );
  }
}
class CustomTextFieldTwo extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? textInputType;
  final int? maxLine;
  final FocusNode? focusNode;
  final FocusNode? nextNode;
  final TextInputAction? textInputAction;
  final bool isPhoneNumber;
  final bool isValidator;
  final String? validatorMessage;
  final Color? fillColor;
  final TextCapitalization capitalization;
  final Icon? prefixIcon;
  final String? initialValue;
  final bool isEnabled;
  final int? maxLength;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;
  CustomTextFieldTwo(
      {this.controller,
      this.hintText,
      this.textInputType,
      this.maxLine,
      this.focusNode,
      this.nextNode,
      this.textInputAction,
      this.isPhoneNumber = false,
      this.isValidator = false,
      this.validatorMessage,
      this.capitalization = TextCapitalization.none,
      this.fillColor,
      this.prefixIcon,
      this.initialValue,
      this.isEnabled = true,
      this.maxLength,
      this.onChanged,
        this.onEditingComplete
      });

  @override
  Widget build(context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLine ?? 1,
      textCapitalization: capitalization,
      maxLength: isPhoneNumber ? 15 : maxLength,
      focusNode: focusNode,
      keyboardType: textInputType ?? TextInputType.text,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
        //To remove first '0'
        FilteringTextInputFormatter.deny(RegExp(r'^0+'))
      ],
      //keyboardType: TextInputType.number,
      initialValue: initialValue,
      enabled: isEnabled,
      textInputAction: textInputAction ?? TextInputAction.next,
      onFieldSubmitted: (v) {
        if (nextNode == null) {
          FocusManager.instance.primaryFocus?.unfocus();
        } else {
          FocusScope.of(context).requestFocus(nextNode);
        }
      },
      onEditingComplete: onEditingComplete,
      onChanged: onChanged,
      //autovalidate: true,

      validator: (input) {
        if (input!.isEmpty) {
          if (isValidator) {
            return validatorMessage ?? "";
          }
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: hintText ?? '',
        label: Text(hintText ?? ''),
        filled: fillColor != null,
        // prefixIcon: prefixIcon ?? null,
        fillColor: fillColor,
        contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 15),
        isDense: true,
        counterText: '',
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: ColorResources.SILVER_GREY),
            borderRadius: BorderRadius.circular(15)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.circular(15)),

        errorStyle: TextStyle(
            color: Colors.red[400],
            fontWeight: FontWeight.bold,
            fontSize: 13,
            height: 2),
        // errorBorder: OutlineInputBorder(
        //     borderSide: BorderSide(color: ColorResources.getRed(context)),
        //     borderRadius: BorderRadius.circular(15)),
        border: InputBorder.none,
      ),
    );
  }
}
