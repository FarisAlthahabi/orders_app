import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:orders_app/global/widgets/main_button.dart';
import 'package:orders_app/global/widgets/main_text_field.dart';

abstract class SignUpViewCallBacks {
  void onFirstNameChanged(String firstName);

  void onLastNameChanged(String lastName);
  
  void onEmailChanged(String email);
  
  void onPhoneNumberChanged(String phoneNumber);

  void onSignUpTap();
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
      @override
  void onFirstNameChanged(String firstName) {
    // TODO: implement onFirstNameChanged
  }
  
  @override
  void onLastNameChanged(String lastName) {
    // TODO: implement onLastNameChanged
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
  void onSignUpTap() {
    // TODO: implement onSignUpTap
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 25),
                Text(
                  "create_account".tr(),
                  style: TextStyle(
                    color: Color(0xFF32324D),
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    height: 1.24,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "have_to_know_your_info".tr(),
                  style: TextStyle(
                    color: Color(0xFF8E8EA9),
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    height: 1.24,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30),
                MainTextField(
                  onChanged: onFirstNameChanged,
                  hintText: "first_name".tr(),
                ),
                SizedBox(height: 20),
                MainTextField(
                  onChanged: onLastNameChanged,
                  hintText: "last_name".tr(),
                ),
                SizedBox(height: 20),
                MainTextField(
                  onChanged: onEmailChanged,
                  hintText: "email".tr(),
                  textInputType: TextInputType.emailAddress,
                ),
                SizedBox(height: 20),
                MainTextField(
                  onChanged: onPhoneNumberChanged,
                  hintText: "phone_number".tr(),
                  textInputType: TextInputType.number,
                ),
                SizedBox(height: 200),
                MainButton(
                  onPressed: onSignUpTap,
                  text: "sign_up".tr(),
                ),
                SizedBox(height: 30)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
