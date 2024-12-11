// ignore_for_file: public_member_api_docs, sort_constructors_first
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
    this.confirmPassword,
  })  : _firstName = firstName,
        _lastName = lastName,
        _phoneNumber = phoneNumber,
        _password = password;

  factory SignUpModel.fromJson(Map<String, dynamic> json) =>
      _$SignUpModelFromJson(json);

  final String? _firstName;
  final String? _lastName;
  final String? _phoneNumber;
  final String? _password;
  final String? confirmPassword;

  Map<String, dynamic> toJson() => _$SignUpModelToJson(this);

  String get firstName {
    return _firstName ?? (throw "First name can't be empty");
  }

  String get lastName {
    return _lastName ?? (throw "Last name can't be empty");
  }

  String get phoneNumber {
    return _phoneNumber ?? (throw "Phone Number can't be empty");
  }

  String get password {
    return _password ?? (throw "Password can't be empty");
  }

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
      confirmPassword: confirmPassword ?? this.confirmPassword,
    );
  }
}
