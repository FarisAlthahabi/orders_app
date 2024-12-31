import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:orders_app/features/profile/model/customer_model/customer_model.dart';
import 'package:orders_app/features/profile/repo/profile_repo.dart';

part 'states/profile_state.dart';

part 'states/general_profile_state.dart';

@injectable
class ProfileCubit extends Cubit<GeneralProfileState> {
  ProfileCubit(this.profileRepo) : super(ProfileInitial());

  final ProfileRepo profileRepo;

  Future<void> getProfile() async {
    emit(ProfileLoading());

    try {
      final customer = await profileRepo.getProfile();
      emit(ProfileSuccess(customer));
    } catch (e) {
      emit(ProfileFail(e.toString()));
    }
  }
}
