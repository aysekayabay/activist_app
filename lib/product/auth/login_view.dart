import 'package:akademi_bootcamp/core/base/state/base_state.dart';
import 'package:akademi_bootcamp/core/components/buttons/custom_button.dart';
import 'package:akademi_bootcamp/core/components/textfield/custom_textfield.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  BaseState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends BaseState<LoginView> {
  bool obsecure = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 100),
            CustomTextfield(
              labelText: "Email",
              controller: TextEditingController(),
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
            ),
            SizedBox(
              height: 20,
            ),
            CustomTextfield(labelText: "Şifre", controller: TextEditingController(), keyboardType: TextInputType.number, textInputAction: TextInputAction.next, isPassword: true),
            SizedBox(
              height: 20,
            ),
            CustomButton(title: "Continue", isFilled: false)
          ],
        ),
      ),
    );
  }
}
