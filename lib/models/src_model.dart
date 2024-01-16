import 'package:json_annotation/json_annotation.dart';
part 'src_model.g.dart';

@JsonSerializable()
class SrcModel {
  SrcModel({
    this.original,
    this.large2x,
    this.large,
    this.medium,
    this.small,
    this.portrait,
    this.landscape,
    this.tiny,
  });

  String? original;
  String? large2x;
  String? large;
  String? medium;
  String? small;
  String? portrait;
  String? landscape;
  String? tiny;

  factory SrcModel.fromJson(Map<String, dynamic> json) =>
      _$SrcModelFromJson(json);

  Map<String, dynamic> toJson() => _$SrcModelToJson(this);
}
