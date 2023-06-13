import 'package:json_annotation/json_annotation.dart';
import 'package:room_finder_flutter/models/tourguide/serializable.dart';

part 'firestore_user.g.dart';

@JsonSerializable()
class FirestoreUser implements Serializable {
  @JsonKey(name: 'doc_id')
  String? docId;
  String uid;
  @JsonKey(name: 'display_name')
  String displayName;
  @JsonKey(name: 'photo_url')
  String photoURL;
  String email;
  List<String> groups;

  FirestoreUser(
      {this.docId,
      this.uid = '',
      this.displayName = '',
      this.photoURL = '',
      this.email = '',
      this.groups = const []});

  factory FirestoreUser.fromJson(Map<String, dynamic> json) => _$FirestoreUserFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FirestoreUserToJson(this);
}
