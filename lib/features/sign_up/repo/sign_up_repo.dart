import 'package:injectable/injectable.dart';
import 'package:orders_app/features/sign_up/model/sign_in_model/sign_in_model.dart';
import 'package:orders_app/features/sign_up/model/sign_in_post_model/sign_in_post_model.dart';
import 'package:orders_app/features/sign_up/model/sign_up_model/sign_up_model.dart';
import 'package:orders_app/global/di/di.dart';
import 'package:orders_app/global/dio/dio.dart';
import 'package:orders_app/global/repos/user_repo.dart';

part "sign_up_repo_imp.dart";

abstract class SignUpRepo {
  Future<void> signUp(SignUpModel signUpModel);

  Future<SignInModel> signIn(SignInPostModel signInPostModel);

  Future<void> logout();
}
