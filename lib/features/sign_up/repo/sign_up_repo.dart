import 'package:injectable/injectable.dart';
import 'package:orders_app/features/sign_up/model/sign_up_model/sign_up_model.dart';
import 'package:orders_app/global/dio/dio.dart';

part "sign_up_repo_imp.dart";

abstract class SignUpRepo {
  Future<void> signUp(SignUpModel signUpModel);

  Future<void> signIn();
}
