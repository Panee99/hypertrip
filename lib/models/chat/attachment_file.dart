import 'package:json_annotation/json_annotation.dart';
import 'package:room_finder_flutter/models/tourguide/serializable.dart';

part 'attachment_file.g.dart';

@JsonSerializable()
class AttachmentFile implements Serializable{
  String id;
  String contentType;
  String url;

  AttachmentFile({this.id = '', this.contentType = '', this.url = ''});

  factory AttachmentFile.fromJson(Map<String, dynamic> json) => _$AttachmentFileFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AttachmentFileToJson(this);
}
