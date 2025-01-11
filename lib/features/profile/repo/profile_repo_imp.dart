part of 'profile_repo.dart';

@Injectable(as: ProfileRepo)
class ProfileRepoImp implements ProfileRepo {
  final dioClient = DioClient();

  @override
  Future<CustomerModel> getProfile() async {
    try {
      final response = await dioClient.get(
        "profile/show",
      );
      final profile = response.data["profile"] as Map<String, dynamic>;
      return CustomerModel.fromJson(profile);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CustomerModel> updateProfile(
    UpdateProfileModel updateProfileModel,
    XFile? imagePicked,
  ) async {
    try {
      final FormData formData = FormData.fromMap({
        'first_name': updateProfileModel.firstName,
        'last_name': updateProfileModel.lastName,
        'phone': updateProfileModel.phoneNumber,
        'location': updateProfileModel.location,
        'photo': imagePicked != null
            ? await MultipartFile.fromFile(
                imagePicked.path,
                filename: imagePicked.name,
              )
            : null,
      });

      final response = await dioClient.post(
        "profile/updateProfile",
        data: formData,
      );
      final profile = response.data["profile"] as Map<String, dynamic>;
      return CustomerModel.fromJson(profile);
    } catch (e) {
      rethrow;
    }
  }
}
