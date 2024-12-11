part of 'sign_up_repo.dart';

@Injectable(as: SignUpRepo)
class SignUpRepoImp implements SignUpRepo {
  final dioClient = DioClient();
  @override
  Future<void> signUp(SignUpModel signUpModel) async {
    try {
      //TODO : implement this
      final response = await dioClient.post(
        "endpoint",
        data: signUpModel.toJson() ,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> signIn() async {
    try {
      //TODO : implement this
      final response = await dioClient.get("endpoint");
    } catch (e) {
      rethrow;
    }
  }
}
