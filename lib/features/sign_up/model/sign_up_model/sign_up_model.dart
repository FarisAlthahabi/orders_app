import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'sign_up_model.g.dart';

@JsonSerializable()
@immutable
class SignUpModel {
  const SignUpModel({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? password,
    String? confirmPassword,
  })  : _firstName = firstName,
        _lastName = lastName,
        _phoneNumber = phoneNumber,
        _password = password,
        _confirmPassword = confirmPassword;

  factory SignUpModel.fromJson(Map<String, dynamic> json) =>
      _$SignUpModelFromJson(json);

  final String? _firstName;

  final String? _lastName;

  final String? _phoneNumber;

  final String? _password;

  final String? _confirmPassword;

  Map<String, dynamic> toJson() => _$SignUpModelToJson(this);

  SignUpModel copyWith({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? password,
    String? confirmPassword,
  }) {
    return SignUpModel(
      firstName: firstName ?? _firstName,
      lastName: lastName ?? _lastName,
      phoneNumber: phoneNumber ?? _phoneNumber,
      password: password ?? _password,
      confirmPassword: confirmPassword ?? _confirmPassword,
    );
  }

  @JsonKey(name: 'first_name')
  String get firstName {
    return _firstName ?? (throw "First name can't be empty");
  }

  @JsonKey(name: 'last_name')
  String get lastName {
    return _lastName ?? (throw "Last name can't be empty");
  }

  @JsonKey(name: "phone")
  String get phoneNumber {
    return _phoneNumber ?? (throw "Phone Number can't be empty");
  }

  String get password {
    return _password ?? (throw "Password can't be empty");
  }

  @JsonKey(name: 'password_confirmation')
  String get confirmPassword {
    return _confirmPassword ?? (throw "Confirm Password can't be empty");
  }

}
