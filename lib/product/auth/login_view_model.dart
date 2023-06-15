import 'package:akademi_bootcamp/core/constants/navigation/navigation_constants.dart';
import 'package:akademi_bootcamp/core/init/navigation/navigation_service.dart';
import 'package:akademi_bootcamp/core/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
part 'login_view_model.g.dart';

class LoginViewModel = _LoginViewModelBase with _$LoginViewModel;

abstract class _LoginViewModelBase with Store {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final String signIn = "Sign In";
  final String continueLabel = "Continue";
  final String logIn = "Log In";
  @observable
  AuthType authType = AuthType.SIGN_IN;

  @action
  changeAuthType() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    if (authType == AuthType.SIGN_IN) {
      authType = AuthType.LOG_IN;
    } else {
      authType = AuthType.SIGN_IN;
    }
  }

  authFunction(BuildContext context) {
    switch (authType) {
      case AuthType.SIGN_IN:
        register(context);
        break;
      case AuthType.LOG_IN:
        login(context);
        break;
      case AuthType.GOOGLE:
        AuthService.instance.signInWithGoogle();
        break;
      case AuthType.FACEBOOK:
        AuthService.instance.signInWithFacebook();
        break;
      case AuthType.TWITTER:
        // AuthService.instance.signInWithTwitter();
        break;
      default:
    }
  }

  register(BuildContext context) async {
    int result = await AuthService.instance.register(context, emailController.text, passwordController.text);
    if (result == 1) {
      //success
      NavigationService.instance.navigateToPage(path: NavigationConstants.HOME);
    } else {
      //failed
    }
  }

  login(BuildContext context) async {
    int result = await AuthService.instance.login(context, emailController.text, passwordController.text);
    if (result == 1) {
      //success
      NavigationService.instance.navigateToPage(path: NavigationConstants.HOME);
    } else {
      //failed
    }
  }
}

enum AuthType { SIGN_IN, LOG_IN, GOOGLE, FACEBOOK, TWITTER }
