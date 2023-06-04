import 'package:json_annotation/json_annotation.dart';
import 'package:room_finder_flutter/models/tourguide/serializable.dart';

part 'firestore_group_chat.g.dart';

@JsonSerializable()
class FirestoreGroupChat implements Serializable {
  /// Người tạo group
  @JsonKey(name: 'created_by')
  String createdBy;

  /// Id group tương ứng với docId của từng group cũng là tourId
  String id;

  /// Danh sách id thành viên trong group
  List<String> members;

  /// Thời gian tạo group
  @JsonKey(name: 'create_at')
  DateTime createAt;

  // Thời gian chỉnh sửa group
  @JsonKey(name: 'modified_at')
  DateTime modifiedAt;

  /// Tên group
  @JsonKey(name: 'title_group')
  String titleGroup;

  /// Loại group
  /// 0 : Single
  /// 1 : Multi
  int type;

  FirestoreGroupChat({
    this.createdBy = '',
    this.id = '',
    this.members = const [],
    this.titleGroup = '',
    this.type = 1,
    required this.createAt,
    required this.modifiedAt,
  });

  factory FirestoreGroupChat.fromJson(Map<String, dynamic> json) =>
      _$FirestoreGroupChatFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FirestoreGroupChatToJson(this);
}
