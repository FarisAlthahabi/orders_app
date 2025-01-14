import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:orders_app/features/select_role/model/user_role_enum/user_role_enum.dart';
import 'package:orders_app/global/repos/user_repo.dart';

part 'main_navigation_state.dart';

@injectable
class MainNavigationCubit extends Cubit<MainNavigationState> {
  MainNavigationCubit(this.userRepo) : super(MainNavigationInitial());

  final UserRepo userRepo;

  Future<void> detectRoute() async {
    if (await userRepo.getKey(UserRepo.keys.userRole) ==
        UserRoleEnum.customer.name) {
      emit(AppManagerRouteState());
    } else if (await userRepo.getKey(UserRepo.keys.userRole) ==
        UserRoleEnum.driver.name) {
      emit(DriverAppManagerRouteState());
    }
  }
}
