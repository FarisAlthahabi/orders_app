import 'package:animated_size_and_fade/animated_size_and_fade.dart';
import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:orders_app/features/sign_up/cubit/sign_up_cubit.dart';
import 'package:orders_app/global/di/di.dart';
import 'package:orders_app/global/repos/user_repo.dart';
import 'package:orders_app/global/router/router.gr.dart';
import 'package:orders_app/global/theme/components/colors.dart';
import 'package:orders_app/global/utils/constants.dart';
import 'package:orders_app/global/widgets/loading_indicator.dart';
import 'package:orders_app/global/widgets/main_button.dart';
import 'package:orders_app/global/widgets/main_snack_bar.dart';
import 'package:orders_app/global/widgets/main_text_field.dart';

abstract class SignUpViewCallBacks {
  void onPasswordChanged(String password);

  void onPasswordSubmitted(String password);

  void onConfirmPasswordChanged(String confirmPassword);

  void onConfirmPasswordSubmitted(String confirmPassword);

  void onFirstNameChanged(String firstName);

  void onFirstNameSubmitted(String firstName);

  void onLastNameChanged(String lastName);

  void onLastNameSubmitted(String lastName);

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
    return BlocProvider(
      create: (context) => get<SignUpCubit>(),
      child: SignUpPage(),
    );
  }
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage>
    implements SignUpViewCallBacks {
  late final SignUpCubit signUpCubit = context.read();
  late final UserRepo userRepo = context.read();

  final firstNameFocusNode = FocusNode();
  final lastNameFocusNode = FocusNode();
  final phoneNumberFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  final confirmPasswordFocusNode = FocusNode();

  bool showSignInOrUp = true;

  @override
  void dispose() {
    firstNameFocusNode.dispose();
    lastNameFocusNode.dispose();
    phoneNumberFocusNode.dispose();
    passwordFocusNode.dispose();
    confirmPasswordFocusNode.dispose();

    super.dispose();
  }

  @override
  void onFirstNameChanged(String firstName) {
    signUpCubit.setFirstName(firstName);
  }

  @override
  void onFirstNameSubmitted(String firstName) {
    lastNameFocusNode.requestFocus();
  }

  @override
  void onLastNameChanged(String lastName) {
    signUpCubit.setLastName(lastName);
  }

  @override
  void onLastNameSubmitted(String lastName) {
    phoneNumberFocusNode.requestFocus();
  }

  @override
  void onConfirmPasswordSubmitted(String confirmPassword) {
    confirmPasswordFocusNode.unfocus();
  }

  @override
  void onPasswordSubmitted(String password) {
    passwordFocusNode.unfocus();
  }

  @override
  void onPhoneNumberSubmitted(String phoneNumber) {
    passwordFocusNode.requestFocus();
  }

  @override
  void onConfirmPasswordChanged(String confirmPassword) {
    signUpCubit.setConfirmPassword(confirmPassword);
  }

  @override
  void onPasswordChanged(String password) {
    signUpCubit.setPassword(password);
  }

  @override
  void onPhoneNumberChanged(String phoneNumber) {
    signUpCubit.setPhoneNumber(phoneNumber);
  }

  @override
  void onSignUpOrInTap() {
    if (showSignInOrUp) {
      signUpCubit.signIn();
    } else {
      signUpCubit.signUp();
    }
  }

  @override
  void onShowSignUpOrIn() {
    setState(() {
      showSignInOrUp = !showSignInOrUp;
    });
    firstNameFocusNode.unfocus();
    lastNameFocusNode.unfocus();
    phoneNumberFocusNode.unfocus();
    passwordFocusNode.unfocus();
    confirmPasswordFocusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Padding(
              padding: AppConstants.padding16,
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
                    AnimatedSizeAndFade.showHide(
                      show: !showSignInOrUp,
                      child: Column(
                        children: [
                          MainTextField(
                            onChanged: onFirstNameChanged,
                            onSubmitted: onFirstNameSubmitted,
                            focusNode: firstNameFocusNode,
                            hintText: "first_name".tr(),
                            prefixIcon: Icon(Icons.person),
                          ),
                          SizedBox(height: 20),
                          MainTextField(
                            onChanged: onLastNameChanged,
                            onSubmitted: onLastNameSubmitted,
                            focusNode: lastNameFocusNode,
                            hintText: "last_name".tr(),
                            prefixIcon: Icon(Icons.person),
                          ),
                          SizedBox(height: 20),
                        ],
                      ),
                    ),
                    MainTextField(
                      onChanged: onPhoneNumberChanged,
                      onSubmitted: onPhoneNumberSubmitted,
                      focusNode: phoneNumberFocusNode,
                      hintText: "phone_number".tr(),
                      textInputType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      prefixIcon: Icon(Icons.phone),
                    ),
                    SizedBox(height: 20),
                    MainTextField(
                      onChanged: onPasswordChanged,
                      onSubmitted: onPasswordSubmitted,
                      focusNode: passwordFocusNode,
                      hintText: "password".tr(),
                      textInputType: TextInputType.visiblePassword,
                      prefixIcon: Icon(Icons.lock),
                      isPassword: true,
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
                            prefixIcon: Icon(Icons.lock),
                            isPassword: true,
                          ),
                          SizedBox(height: 20),
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
                    BlocConsumer<SignUpCubit, GeneralSignUpState>(
                      listener: (context, state) {
                        if (state is SignUpSuccess) {
                          userRepo.setKey(UserRepo.keys.isLoggedIn, true);

                          MainSnackBar.showSuccessMessage(
                            context,
                            state.message,
                          );
                          context.router.popAndPush(AppManagerRoute());

                        } else if (state is SignInSuccess) {
                          userRepo.setKey(UserRepo.keys.isLoggedIn, true);
                          MainSnackBar.showSuccessMessage(
                            context,
                            state.message,
                          );
                          context.router.push(AppManagerRoute());

                        } else if (state is SignUpFail) {
                          MainSnackBar.showErrorMessage(
                            context,
                            state.message,
                          );
                        }
                      },
                      builder: (context, state) {
                        var onTap = onSignUpOrInTap;
                        Widget? child;
                        if (state is SignUpLoading) {
                          onTap = () {};
                          child = LoadingIndicator();
                        }
                        return MainButton(
                          onPressed: onTap,
                          text:
                              showSignInOrUp ? "sign_in".tr() : "sign_up".tr(),
                          child: child,
                        );
                      },
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
