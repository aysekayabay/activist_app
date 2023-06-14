import 'package:flutter/material.dart';

import '../../constants/theme/theme_constants.dart';

// ignore: must_be_immutable
class CustomTextfield extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  bool isVisible;
  final bool isPassword;
  final bool isSearch;
  CustomTextfield({
    super.key,
    required this.hintText,
    required this.controller,
    required this.keyboardType,
    required this.textInputAction,
    this.isVisible = true,
    this.isPassword = false,
    this.isSearch = false,
  });

  @override
  State<CustomTextfield> createState() => _CustomTextfieldState();
}

class _CustomTextfieldState extends State<CustomTextfield> {
  bool obsecure = true;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.isVisible,
      child: TextField(
        controller: widget.controller,
        obscureText: widget.isPassword ? obsecure : false,
        style: TextStyle(color: AppColors.vanillaShake),
        decoration: InputDecoration(
          hintText: widget.hintText,
          prefixIcon: widget.isSearch ? Icon(Icons.search) : null,
          suffixIcon: Visibility(
            visible: widget.isPassword,
            child: IconButton(
              icon: Icon(obsecure ? Icons.visibility : Icons.visibility_off),
              onPressed: () {
                setState(
                  () {
                    obsecure = !obsecure;
                  },
                );
              },
            ),
          ),
        ),
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
      ),
    );
  }
}
