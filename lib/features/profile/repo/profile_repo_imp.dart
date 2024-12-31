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
}
