import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:orders_app/features/profile/model/customer_model/customer_model.dart';
import 'package:orders_app/features/profile/model/update_profile_model/update_profile_model.dart';
import 'package:orders_app/global/dio/dio_client.dart';

part 'profile_repo_imp.dart';

abstract class ProfileRepo {
  Future<CustomerModel> getProfile();

  Future<CustomerModel> updateProfile(
    UpdateProfileModel updateProfileModel,
    XFile? imagePicked,
  );
}
