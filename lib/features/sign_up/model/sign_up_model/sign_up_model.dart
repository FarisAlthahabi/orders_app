import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

@JsonSerializable()
@immutable
class SignUpModel {
  final String phoneNumber;
  const SignUpModel({
    required this.phoneNumber,
  });
}
