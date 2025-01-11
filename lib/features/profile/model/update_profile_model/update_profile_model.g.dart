// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateProfileModel _$UpdateProfileModelFromJson(Map<String, dynamic> json) =>
    UpdateProfileModel(
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      phoneNumber: json['phone'] as String?,
      location: json['location'] as String?,
    );

Map<String, dynamic> _$UpdateProfileModelToJson(UpdateProfileModel instance) =>
    <String, dynamic>{
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'location': instance.location,
      'phone': instance.phoneNumber,
    };
