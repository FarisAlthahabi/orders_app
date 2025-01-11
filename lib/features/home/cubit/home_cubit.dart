import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:orders_app/features/home/model/store_model/store_model.dart';
import 'package:orders_app/features/home/repo/home_repo.dart';

part 'states/home_state.dart';

part 'states/general_home_state.dart';

@injectable
class HomeCubit extends Cubit<GeneralHomeState> {
  HomeCubit(this.homeRepo) : super(HomeInitial());

  final HomeRepo homeRepo;

  Future<void> getStores() async {
    emit(HomeLoading());
    try {
      final stores = await homeRepo.getStores();
      if (stores.isEmpty) {
        emit(HomeEmpty("there_is_no_stores".tr()));
      } else {
        emit(HomeSuccess(stores));
      }
    } catch (e) {
      emit(HomeFail(e.toString()));
    }
  }

  Future<void> getSearchedStores(String input) async {
    emit(HomeLoading());

    try {
      final stores = await homeRepo.getSearchedStores(input);
      if (stores.isEmpty) {
        emit(HomeEmpty("there_is_no_stores".tr()));
      } else {
        emit(HomeSuccess(stores));
      }
    } catch (e) {
      if (e.toString().contains("could not be found")) {
        emit(HomeEmpty(e.toString()));
      } else {
        emit(HomeFail(e.toString()));
      }
    }
  }
}
