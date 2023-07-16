import 'package:akademi_bootcamp/core/components/app_bar/custom_app_bar.dart';
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
      backgroundColor: AppColors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            authTop(),
            authBody(),
            CustomButton(
                title: _viewModel.continueLabel,
                isFilled: true,
                verticalPadding: 12,
                marginPadding: EdgeInsets.symmetric(horizontal: AppSizes.mediumSize) + EdgeInsets.only(bottom: AppSizes.lowSize, top: AppSizes.mediumSize),
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

  Widget iconButtons() {
    return Observer(builder: (_) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _viewModel.authType == AuthType.LOG_IN
              ? CircleIconButton(
                  iconPath: ImageConstants.GOOGLE,
                  onTap: () {
                    _viewModel.authType = AuthType.GOOGLE;
                    _viewModel.authFunction(context);
                  })
              : SizedBox()
        ],
      );
    });
  }

  Widget authTop() {
    return Observer(builder: (context) {
      return Stack(
        children: [
          Image.asset(ImageConstants.AUTH_IMAGE),
          CustomAppBar(
            context: context,
            left: AppBarWidgets.BACK_WITH_SHADOW,
            leftIconColor: AppColors.vanillaShake,
            onTapLeft: () => Navigator.pop(context),
          ),
          Positioned(
              left: 20,
              bottom: 30,
              child: Text(_viewModel.authType == AuthType.SIGN_IN ? _viewModel.signIn : _viewModel.logIn, style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: AppColors.vanillaShake))),
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
            _viewModel.authType == AuthType.SIGN_IN ? labelText("Ad") : SizedBox(),
            CustomTextfield(
                hintText: "Xxxx Xxxx",
                controller: _viewModel.fullnameController,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                isVisible: _viewModel.authType == AuthType.SIGN_IN),
            labelText("Email"),
            CustomTextfield(
              hintText: "xxxx@xxx.xxx",
              controller: _viewModel.emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
            ),
            labelText("Şifre"),
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
      child: Text(label, style: Theme.of(context).textTheme.displayMedium!.copyWith(color: AppColors.vanillaShake)),
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
                  style: Theme.of(context).textTheme.displayMedium!.copyWith(color: AppColors.black),
                  textAlign: TextAlign.center,
                ),
                Divider(
                  color: Colors.grey,
                  height: 4.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Email",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.black),
                  ),
                ),
                TextField(
                  controller: _viewModel.forgotPasswordController,
                  decoration: InputDecoration(
                    hintText: "xxxx@xxx.xxx",
                    hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(color: AppColors.grey),
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
                      style: Theme.of(context).textTheme.displayMedium,
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
