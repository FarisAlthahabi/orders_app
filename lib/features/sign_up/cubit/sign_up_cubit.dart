import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:orders_app/features/sign_up/repo/sign_up_repo.dart';

part 'sign_up_state.dart';

@injectable
class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit(this.signUpRepo) : super(SignUpInitial());

  final SignUpRepo signUpRepo;

  void setPhoneNumber(String phoneNumber) {}

  Future<void> signUp() async {
    emit(SignUpLoading());
    try {
      await signUpRepo.signUp();
      emit(SignUpSuccess());
    } catch (e) {
      emit(SignUpFail(e.toString()));
    }
  }
}
