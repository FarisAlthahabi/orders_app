part of 'sign_up_repo.dart';

@Injectable(as: SignUpRepo)
class SignUpRepoImp implements SignUpRepo {
  final dioClient = DioClient();

  @override
  Future<void> signUp(SignUpModel signUpModel) async {
    final String userRole =
        await get<UserRepo>().getKey(UserRepo.keys.userRole);
    try {
      await dioClient.post(
        "auth/$userRole/register",
        data: signUpModel.toJson(),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<SignInModel> signIn(SignInPostModel signInPostModel) async {
    final String userRole =
        await get<UserRepo>().getKey(UserRepo.keys.userRole);
    try {
      final response = await dioClient.post(
        "auth/$userRole/login",
        data: signInPostModel.toJson(),
      );
      final data = response.data["data"] as Map<String, dynamic>;
      return SignInModel.fromJson(data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    final String userRole =
        await get<UserRepo>().getKey(UserRepo.keys.userRole);
    try {
      await dioClient.post(
        "auth/$userRole/logout",
      );
    } catch (e) {
      rethrow;
    }
  }
}
