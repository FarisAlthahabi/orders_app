// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignInPostModel _$SignInPostModelFromJson(Map<String, dynamic> json) =>
    SignInPostModel(
      phoneNumber: json['phone'] as String?,
      password: json['password'] as String?,
    );

Map<String, dynamic> _$SignInPostModelToJson(SignInPostModel instance) =>
    <String, dynamic>{
      'phone': instance.phoneNumber,
      'password': instance.password,
    };
