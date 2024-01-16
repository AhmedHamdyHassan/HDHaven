import 'package:json_annotation/json_annotation.dart';
import 'package:wallpaper_app/models/src_model.dart';
part 'wallpaper_model.g.dart';

@JsonSerializable()
class WallpaperModel {
  int? id;
  int? width;
  int? height;
  String? url;
  String? photographer;
  String? photographerUrl;
  int? photographerId;
  String? avgColor;
  SrcModel? srcModel;
  bool? liked;
  String? alt;

  WallpaperModel({
    this.id,
    this.width,
    this.height,
    this.url,
    this.photographer,
    this.photographerUrl,
    this.photographerId,
    this.avgColor,
    this.srcModel,
    this.liked,
    this.alt,
  });

  factory WallpaperModel.fromJson(Map<String, dynamic> json) =>
      _$WallpaperModelFromJson(json);

  Map<String, dynamic> toJson() => _$WallpaperModelToJson(this);
}
