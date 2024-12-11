import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:orders_app/features/sign_up/model/sign_up_model/sign_up_model.dart';
import 'package:orders_app/features/sign_up/repo/sign_up_repo.dart';

part 'sign_up_state.dart';

@injectable
class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this.signUpRepo) : super(SignUpInitial());

  final SignUpRepo signUpRepo;
  SignUpModel _signUpModel = SignUpModel();
  
  void setFirstName(String firstName) {
    _signUpModel = _signUpModel.copyWith(firstName: firstName);
  }
  void setLastName(String lastName) {
    _signUpModel = _signUpModel.copyWith(lastName: lastName);
  }
  void setPhoneNumber(String phoneNumber) {
    _signUpModel = _signUpModel.copyWith(phoneNumber: phoneNumber);
  }
  void setPassword(String password) {
    _signUpModel = _signUpModel.copyWith(password: password);
  }

  void setConfirmPassword(String confirmPassword) {
    _signUpModel = _signUpModel.copyWith(confirmPassword: confirmPassword);
  }


  Future<void> signUp() async {
    emit(SignUpLoading());
    try {
      await signUpRepo.signUp(_signUpModel);
      emit(SignUpSuccess());
    } catch (e) {
      emit(SignUpFail(e.toString()));
    }
  }
}
