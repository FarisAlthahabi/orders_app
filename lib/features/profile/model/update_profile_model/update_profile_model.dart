import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'update_profile_model.g.dart';

@JsonSerializable()
@immutable
class UpdateProfileModel {
  const UpdateProfileModel({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? location,
  })  : _firstName = firstName,
        _lastName = lastName,
        _phoneNumber = phoneNumber,
        _location = location;

  factory UpdateProfileModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileModelFromJson(json);

  final String? _firstName;
  final String? _lastName;
  final String? _phoneNumber;
  final String? _location;

  UpdateProfileModel copyWith({
    String? firstName,
    String? lastName,
    String? phoneNumber,
    String? location,
  }) {
    return UpdateProfileModel(
      firstName: firstName ?? _firstName,
      lastName: lastName ?? _lastName,
      phoneNumber: phoneNumber ?? _phoneNumber,
      location: location ?? _location,
    );
  }

  String toJsonStr() => jsonEncode(toJson());

  Map<String, dynamic> toJson() => _$UpdateProfileModelToJson(this);

  @JsonKey(name: 'first_name')
  String? get firstName {
    return _firstName;
  }

  @JsonKey(name: 'last_name')
  String? get lastName {
    return _lastName;
  }

  String? get location {
    return _location;
  }

  @JsonKey(name: 'phone')
  String? get phoneNumber {
    return _phoneNumber;
  }
}
