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
    if (_firstName == null || _firstName.isEmpty) {
      throw "First name can't be empty";
    }
    return _firstName;
  }

  @JsonKey(name: 'last_name')
  String get lastName {
    if (_lastName == null || _lastName.isEmpty) {
      throw "Last name can't be empty";
    }
    return _lastName;
  }

  @JsonKey(name: "phone")
  String get phoneNumber {
    if (_phoneNumber == null || _phoneNumber.isEmpty) {
      throw "Phone Number can't be empty";
    }
    return _phoneNumber;
  }

  String get password {
    if (_password == null || _password.isEmpty) {
      throw "Password can't be empty";
    }
    return _password;
  }

  @JsonKey(name: 'password_confirmation')
  String get confirmPassword {
    if (_confirmPassword == null || _confirmPassword.isEmpty) {
      throw "Confirm Password can't be empty";
    }
    return _confirmPassword;
  }
}
