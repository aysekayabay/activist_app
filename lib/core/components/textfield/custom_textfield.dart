import 'package:flutter/material.dart';

import '../../constants/theme/theme_constants.dart';

class CustomTextfield extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final bool isPassword;
  final bool isSearch;
  const CustomTextfield({
    super.key,
    required this.labelText,
    required this.controller,
    required this.keyboardType,
    required this.textInputAction,
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
    print(obsecure);
    return TextField(
      controller: widget.controller,
      obscureText: widget.isPassword ? obsecure : false,
      style: TextStyle(color: AppColors.vanillaShake),
      decoration: InputDecoration(
        labelText: widget.labelText,
        prefixIcon: widget.isSearch ? Icon(Icons.search) : null,
        // helperText: "Password must contain special character",
        helperStyle: TextStyle(color: Colors.green),
        hintStyle: TextStyle(color: Colors.grey),
        border: OutlineInputBorder(borderSide: BorderSide(width: 10, color: AppColors.vanillaShake), borderRadius: BorderRadius.all(Radius.circular(15))),
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
    );
  }
}
