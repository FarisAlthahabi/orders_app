import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:orders_app/features/home/model/store_model/store_model.dart';

part 'states/home_state.dart';

part 'states/general_home_state.dart';

@injectable
class HomeCubit extends Cubit<GeneralHomeState> {
  HomeCubit() : super(HomeInitial());

  Future<void> getStores() async {
    emit(HomeLoading());
    final stores = Stores.localStores;
    try {
      if (stores.isEmpty) {
        emit(HomeEmpty("There is no stores"));
      } else {
        emit(HomeSuccess(stores));
      }
    } catch (e) {
      emit(HomeFail(e.toString()));
    }
  }
}
