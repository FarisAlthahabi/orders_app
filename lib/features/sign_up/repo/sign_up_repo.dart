import 'package:injectable/injectable.dart';
import 'package:orders_app/global/dio/dio.dart';

part "sign_up_repo_imp.dart";

abstract class SignUpRepo {
  Future<void> signUp();

  Future<void> signIn();
}
