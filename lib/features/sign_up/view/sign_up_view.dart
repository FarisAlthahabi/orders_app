import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:orders_app/global/router/router.gr.dart';
import 'package:orders_app/global/theme/components/colors.dart';
import 'package:orders_app/global/utils/constants.dart';
import 'package:orders_app/global/widgets/main_button.dart';
import 'package:orders_app/global/widgets/main_text_field.dart';

abstract class SignUpViewCallBacks {
  void onPasswordChanged(String password);

  void onPasswordSubmitted(String password);

  void onConfirmPasswordChanged(String confirmPassword);

  void onConfirmPasswordSubmitted(String confirmPassword);

  void onEmailChanged(String email);

  void onEmailSubmitted(String email);

  void onPhoneNumberChanged(String phoneNumber);

  void onPhoneNumberSubmitted(String phoneNumber);

  void onSignUpOrInTap();

  void onShowSignUpOrIn();
}

@RoutePage()
class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SignUpPage();
  }
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>
    implements SignUpViewCallBacks {
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final confirmPasswordFocusNode = FocusNode();
  final phoneNumberFocusNode = FocusNode();

  bool showSignInOrUp = true;

  @override
  void onConfirmPasswordSubmitted(String confirmPassword) {
    phoneNumberFocusNode.requestFocus();
  }

  @override
  void onEmailSubmitted(String email) {
    passwordFocusNode.requestFocus();
  }

  @override
  void onPasswordSubmitted(String password) {
    confirmPasswordFocusNode.requestFocus();
  }

  @override
  void onPhoneNumberSubmitted(String phoneNumber) {
    phoneNumberFocusNode.unfocus();
  }

  @override
  void onConfirmPasswordChanged(String confirmPassword) {
    // TODO: implement onConfirmPasswordChanged
  }

  @override
  void onPasswordChanged(String password) {
    // TODO: implement onPasswordChanged
  }

  @override
  void onEmailChanged(String email) {
    // TODO: implement onEmailChanged
  }

  @override
  void onPhoneNumberChanged(String phoneNumber) {
    // TODO: implement onPhoneNumberChanged
  }

  @override
  void onSignUpOrInTap() {
    if (showSignInOrUp) {
      context.router.push(DashboardRoute());
    }
  }

  @override
  void onShowSignUpOrIn() {
    setState(() {
      showSignInOrUp = !showSignInOrUp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 25),
                    Text(
                      showSignInOrUp ? "sign_in".tr() : "create_account".tr(),
                      style: TextStyle(
                        color: Color(0xFF32324D),
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        height: 1.24,
                      ),
                    ),
                    AnimatedSizeAndFade.showHide(
                      show: !showSignInOrUp,
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          Text(
                            "have_to_know_your_info".tr(),
                            style: TextStyle(
                              color: AppColors.grey,
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                              height: 1.24,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    MainTextField(
                      onChanged: onEmailChanged,
                      onSubmitted: onEmailSubmitted,
                      focusNode: emailFocusNode,
                      hintText: "email".tr(),
                      textInputType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 20),
                    MainTextField(
                      onChanged: onPasswordChanged,
                      onSubmitted: onPasswordSubmitted,
                      focusNode: passwordFocusNode,
                      hintText: "password".tr(),
                      textInputType: TextInputType.visiblePassword,
                    ),
                    SizedBox(height: 20),
                    AnimatedSizeAndFade.showHide(
                      show: !showSignInOrUp,
                      child: Column(
                        children: [
                          MainTextField(
                            onChanged: onConfirmPasswordChanged,
                            onSubmitted: onConfirmPasswordSubmitted,
                            focusNode: confirmPasswordFocusNode,
                            hintText: "confirm_password".tr(),
                            textInputType: TextInputType.visiblePassword,
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                    AnimatedSizeAndFade.showHide(
                      show: !showSignInOrUp,
                      child: MainTextField(
                        onChanged: onPhoneNumberChanged,
                        onSubmitted: onPhoneNumberSubmitted,
                        focusNode: phoneNumberFocusNode,
                        hintText: "phone_number".tr(),
                        textInputType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: AppConstants.padding32V16H,
              child: Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Bounce(
                      onPressed: onShowSignUpOrIn,
                      duration: AppConstants.duration200ms,
                      child: Text.rich(
                        style: TextStyle(
                          color: AppColors.grey,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          height: 1.24,
                        ),
                        textAlign: TextAlign.center,
                        TextSpan(
                          text: showSignInOrUp
                              ? "not_have_account".tr()
                              : "have_account".tr(),
                          children: [
                            TextSpan(
                              text: showSignInOrUp
                                  ? "sign_up".tr()
                                  : "sign_in".tr(),
                              style: TextStyle(
                                color: AppColors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    MainButton(
                      onPressed: onSignUpOrInTap,
                      text: showSignInOrUp ? "sign_in".tr() : "sign_up".tr(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
