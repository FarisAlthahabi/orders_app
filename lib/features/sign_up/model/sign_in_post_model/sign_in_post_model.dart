import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'sign_in_post_model.g.dart';

@JsonSerializable()
@immutable
class SignInPostModel {
  const SignInPostModel({
    String? phoneNumber,
    String? password,
  })  : _phoneNumber = phoneNumber,
        _password = password;

  factory SignInPostModel.fromJson(Map<String, dynamic> json) =>
      _$SignInPostModelFromJson(json);

  final String? _phoneNumber;

  final String? _password;

  Map<String, dynamic> toJson() => _$SignInPostModelToJson(this);

  SignInPostModel copyWith({
    String? phoneNumber,
    String? password,
  }) {
    return SignInPostModel(
      phoneNumber: phoneNumber ?? _phoneNumber,
      password: password ?? _password,
    );
  }

  @JsonKey(name: "phone")
  String get phoneNumber {
    return _phoneNumber ?? (throw "Phone Number can't be empty");
  }

  String get password {
    return _password ?? (throw "Password can't be empty");
  }
}
