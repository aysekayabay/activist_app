import 'package:akademi_bootcamp/core/base/state/base_state.dart';
import 'package:akademi_bootcamp/core/components/buttons/custom_button.dart';
import 'package:akademi_bootcamp/core/components/textfield/custom_textfield.dart';
import 'package:akademi_bootcamp/core/constants/image/image_constants.dart';
import 'package:akademi_bootcamp/core/constants/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../core/components/buttons/circle_icon_button.dart';
import 'auth_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  BaseState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends BaseState<LoginView> {
  AuthViewModel _viewModel = AuthViewModel();
  bool obsecure = false;
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
                marginPadding: EdgeInsets.symmetric(horizontal: AppSizes.mediumSize) + EdgeInsets.only(bottom: AppSizes.highSize),
                onTap: () => _viewModel.authFunction(context)),
            // dividerWidget(),
            iconButtons(),
            Observer(builder: (context) {
              return TextButton(onPressed: () => _viewModel.changeAuthType(), child: Text(_viewModel.authType == AuthType.SIGN_IN ? _viewModel.signIn : _viewModel.logIn));
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
        Center(child: Container(padding: EdgeInsets.all(AppSizes.lowSize), color: AppColors.black, child: Text("or", style: themeData.textTheme.labelLarge!.copyWith(color: AppColors.vanillaShake)))),
      ],
    );
  }

  Row iconButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CircleIconButton(
            iconPath: ImageConstants.FACEBOOK,
            onTap: () {
              _viewModel.authType = AuthType.FACEBOOK;
              _viewModel.authFunction(context);
            }),
        CircleIconButton(
            iconPath: ImageConstants.GOOGLE,
            onTap: () {
              _viewModel.authType = AuthType.GOOGLE;
              _viewModel.authFunction(context);
            }),
        CircleIconButton(
            iconPath: ImageConstants.TWITTER,
            onTap: () {
              _viewModel.authType = AuthType.TWITTER;
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
          Positioned(left: 20, top: 150, child: Text(_viewModel.authType == AuthType.SIGN_IN ? _viewModel.signIn : _viewModel.logIn, style: themeData.textTheme.displayMedium)),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSizes.mediumSize),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    labelText(_viewModel.authType == AuthType.SIGN_IN ? "Name" : "Email"),
                    CustomTextfield(
                        hintText: "Xxxx Xxxx",
                        controller: _viewModel.nameController,
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
            SizedBox(height: 20),
          ],
        );
      }),
    );
  }

  Padding labelText(String label) {
    return Padding(
      padding: EdgeInsets.all(AppSizes.lowSize),
      child: Text(label, style: themeData.textTheme.labelMedium),
    );
  }
}
