// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      json['first_name'] as String?,
      json['last_name'] as String?,
      json['email'] as String?,
      json['phone_number'] as String?,
      (json['favorite_images'] as String).split(',').toList(),
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'phone_number': instance.phoneNumber,
      'favorite_images': instance.favoriteImages!.join(','),
    };
