import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:orders_app/features/sign_up/repo/sign_up_repo.dart';

part 'states/logout_state.dart';

part 'states/general_dashboard_state.dart';

@injectable
class DashboardCubit extends Cubit<GeneralDashboardState> {
  DashboardCubit(this.signUpRepo) : super(GeneralDashboardInitial());

  final SignUpRepo signUpRepo;

  Future<void> logout() async {
    emit(LogoutLoading());
    try {
      await signUpRepo.logout();
      emit(LogoutSuccess("logout_successfully".tr()));
    } catch (e) {
      emit(LogoutFail(e.toString()));
    }
  }
}
