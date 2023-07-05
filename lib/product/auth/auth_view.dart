import 'package:akademi_bootcamp/core/components/buttons/custom_button.dart';
import 'package:akademi_bootcamp/core/components/textfield/custom_textfield.dart';
import 'package:akademi_bootcamp/core/constants/image/image_constants.dart';
import 'package:akademi_bootcamp/core/constants/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../core/components/buttons/circle_icon_button.dart';
import 'auth_view_model.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  AuthViewModel _viewModel = AuthViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            authTop(),
            authBody(),
            CustomButton(
                title: _viewModel.continueLabel,
                isFilled: true,
                verticalPadding: AppSizes.mediumSize,
                marginPadding: EdgeInsets.symmetric(horizontal: AppSizes.mediumSize) + EdgeInsets.only(bottom: AppSizes.mediumSize, top: AppSizes.mediumSize),
                onTap: () => _viewModel.authFunction(context)),
            iconButtons(),
            Observer(builder: (context) {
              return TextButton(onPressed: () => _viewModel.changeAuthType(), child: Text(_viewModel.authType == AuthType.SIGN_IN ? _viewModel.logIn : _viewModel.signIn));
            }),
          ],
        ),
      ),
    );
  }

  Stack dividerWidget() {
    return Stack(
      children: [
        Divider(indent: AppSizes.mediumSize, endIndent: AppSizes.mediumSize, thickness: 1, color: AppColors.vanillaShake),
        Center(
            child: Container(
                padding: EdgeInsets.all(AppSizes.lowSize), color: AppColors.black, child: Text("or", style: Theme.of(context).textTheme.labelLarge!.copyWith(color: AppColors.vanillaShake)))),
      ],
    );
  }

  Row iconButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CircleIconButton(
            iconPath: ImageConstants.GOOGLE,
            onTap: () {
              _viewModel.authType = AuthType.GOOGLE;
              _viewModel.authFunction(context);
            }),
      ],
    );
  }

  Widget authTop() {
    return Observer(builder: (context) {
      return Stack(
        children: [
          Image.asset(ImageConstants.AUTH_IMAGE),
          Positioned(
              left: 20,
              top: 150,
              child: Text(_viewModel.authType == AuthType.SIGN_IN ? _viewModel.signIn : _viewModel.logIn, style: Theme.of(context).textTheme.displayMedium!.copyWith(color: AppColors.vanillaShake))),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.mediumSize),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    labelText(
                      _viewModel.authType == AuthType.SIGN_IN ? "Name" : "Email",
                    ),
                    CustomTextfield(
                        hintText: "Xxxx Xxxx",
                        controller: _viewModel.fullnameController,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        isVisible: _viewModel.authType == AuthType.SIGN_IN),
                    CustomTextfield(
                        hintText: "xxxx@xxx.xxx",
                        controller: _viewModel.emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        isVisible: _viewModel.authType == AuthType.LOG_IN),
                  ],
                ),
              )),
        ],
      );
    });
  }

  Widget authBody() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.mediumSize),
      child: Observer(builder: (_) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _viewModel.authType == AuthType.SIGN_IN ? labelText("Email") : SizedBox(),
            CustomTextfield(
                hintText: "xxxx@xxx.xxx",
                controller: _viewModel.emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                isVisible: _viewModel.authType == AuthType.SIGN_IN),
            labelText("Password"),
            CustomTextfield(hintText: "******", controller: _viewModel.passwordController, keyboardType: TextInputType.text, textInputAction: TextInputAction.next, isPassword: true),
            _viewModel.authType == AuthType.LOG_IN
                ? Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: InkWell(
                          onTap: () => forgotPasswordAlertBox(context),
                          child: Text(
                            "Şifremi Unuttum",
                            style: TextStyle(color: AppColors.lightYellow, fontSize: 12),
                          )),
                    ),
                  )
                : SizedBox(),
          ],
        );
      }),
    );
  }

  Padding labelText(String label) {
    return Padding(
      padding: EdgeInsets.all(AppSizes.lowSize),
      child: Text(label, style: Theme.of(context).textTheme.labelMedium!.copyWith(color: AppColors.vanillaShake)),
    );
  }

  forgotPasswordAlertBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(32.0))),
          contentPadding: EdgeInsets.only(top: 20.0),
          content: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Şifreni Yenile",
                  style: TextStyle(fontSize: 20.0),
                  textAlign: TextAlign.center,
                ),
                Divider(
                  color: Colors.grey,
                  height: 4.0,
                ),
                Text("Email"),
                TextField(
                  controller: _viewModel.forgotPasswordController,
                  decoration: InputDecoration(
                    hintText: "xxxx@xxx.xxx",
                  ),
                ),
                InkWell(
                  onTap: () {
                    _viewModel.passwordReset(context);
                    FocusScope.of(context).unfocus();
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                    decoration: BoxDecoration(
                      color: AppColors.orange,
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(32.0), bottomRight: Radius.circular(32.0)),
                    ),
                    child: Text(
                      "Şifre Yenileme Linki Gönder",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
