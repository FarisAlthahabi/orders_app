import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:orders_app/features/profile/model/customer_model/customer_model.dart';
import 'package:orders_app/features/profile/model/update_profile_model/update_profile_model.dart';
import 'package:orders_app/features/profile/repo/profile_repo.dart';

part 'states/profile_state.dart';

part 'states/update_profile_state.dart';

part 'states/general_profile_state.dart';

@injectable
class ProfileCubit extends Cubit<GeneralProfileState> {
  ProfileCubit(this.profileRepo) : super(ProfileInitial());

  final ProfileRepo profileRepo;

  UpdateProfileModel updateProfileModel = UpdateProfileModel();

  XFile? imagePicked;

  void setFirstName(String firstName) {
    updateProfileModel = updateProfileModel.copyWith(
      firstName: firstName,
    );
  }

  void setLastName(String lastName) {
    updateProfileModel = updateProfileModel.copyWith(
      lastName: lastName,
    );
  }

  void setPhoneNumber(String phoneNumber) {
    updateProfileModel = updateProfileModel.copyWith(
      phoneNumber: phoneNumber,
    );
  }

  void setLocation(String location) {
    updateProfileModel = updateProfileModel.copyWith(
      location: location,
    );
  }

  void setPhoto(XFile imagePicked) async {
    this.imagePicked = imagePicked;
  }

  Future<void> getProfile() async {
    emit(ProfileLoading());

    try {
      final customer = await profileRepo.getProfile();
      emit(ProfileSuccess(customer));
    } catch (e) {
      emit(ProfileFail(e.toString()));
    }
  }

  Future<void> updateProfile() async {
    emit(UpdateProfileLoading());

    try {
      final customer =
          await profileRepo.updateProfile(updateProfileModel, imagePicked);
      emit(UpdateProfileSuccess(customer, "profile_updated".tr()));
    } catch (e) {
      emit(UpdateProfileFail(e.toString()));
    }
  }
}
