import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:orders_app/features/sign_up/model/sign_in_post_model/sign_in_post_model.dart';
import 'package:orders_app/features/sign_up/model/sign_up_model/sign_up_model.dart';
import 'package:orders_app/features/sign_up/repo/sign_up_repo.dart';
import 'package:orders_app/global/di/di.dart';
import 'package:orders_app/global/repos/user_repo.dart';

part 'states/sign_up_state.dart';

part 'states/general_sign_up_state.dart';

@injectable
class SignUpCubit extends Cubit<GeneralSignUpState> {
  SignUpCubit(this.signUpRepo) : super(SignUpInitial());

  final SignUpRepo signUpRepo;
  
  SignUpModel _signUpModel = SignUpModel();
  SignInPostModel _signInPostModel = SignInPostModel();

  void setFirstName(String firstName) {
    _signUpModel = _signUpModel.copyWith(firstName: firstName);
  }

  void setLastName(String lastName) {
    _signUpModel = _signUpModel.copyWith(lastName: lastName);
  }

  void setPhoneNumber(String phoneNumber) {
    _signUpModel = _signUpModel.copyWith(phoneNumber: phoneNumber);
    _signInPostModel = _signInPostModel.copyWith(phoneNumber: phoneNumber);
  }

  void setPassword(String password) {
    _signUpModel = _signUpModel.copyWith(password: password);
    _signInPostModel = _signInPostModel.copyWith(password: password);
  }

  void setConfirmPassword(String confirmPassword) {
    _signUpModel = _signUpModel.copyWith(confirmPassword: confirmPassword);
  }

  Future<void> signUp() async {
    emit(SignUpLoading());
    try {
      await signUpRepo.signUp(_signUpModel);
      emit(SignUpSuccess("signup_successfully".tr()));
    } catch (e) {
      emit(SignUpFail(e.toString()));
    }
  }

  Future<void> signIn() async {
    final userRepo = get<UserRepo>();
    emit(SignUpLoading());
    try {
      final response = await signUpRepo.signIn(_signInPostModel);
      await userRepo.setKey(UserRepo.keys.token, response.token);

      emit(SignInSuccess("login_successfully".tr()));
    } catch (e) {
      emit(SignUpFail(e.toString()));
    }
  }
}
