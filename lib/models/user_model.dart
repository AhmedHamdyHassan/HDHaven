import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  UserModel(
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.favoriteImages,
  );

  String? firstName;
  String? lastName;
  String? email;
  String? phoneNumber;
  List<String>? favoriteImages;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
