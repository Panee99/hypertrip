import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:room_finder_flutter/models/chat/firestore_group_chat.dart';
import 'package:room_finder_flutter/models/chat/firestore_message.dart';
import 'package:room_finder_flutter/models/chat/firestore_user.dart';
import 'package:room_finder_flutter/models/user/sign_in_model.dart';

class FirestoreRepository {
  final FirebaseFirestore _db;

  FirestoreRepository() : _db = FirebaseFirestore.instanceFor(app: Firebase.app());

  final String COLLECTION_USER = 'user';
  final String COLLECTION_GROUP = 'group';
  final String COLLECTION_MESSAGE = 'message';
  final String COLLECTION_MESSAGES = 'messages';

  /// Lưu trữ User lên Firestore
  FutureOr<void> saveUserToFirestore(ProfileResponse user) async {
    try {
      final QuerySnapshot query = await _db.collection(COLLECTION_USER).get();

      final WriteBatch batch = _db.batch();

      final existingUser = query.docs.firstWhereOrNull(
        (element) {
          final data = element.data() as Map?;
          return data?['uid'] == user.id;
        },
      );

      if (existingUser == null) {
        final data = FirestoreUser(
                uid: user.id ?? '',
                email: user.email ?? '',
                displayName: '${user.firstName} ${user.lastName}',
                photoURL: user.avatarUrl ?? '')
            .toJson();

        data.remove('doc_id');
        data.remove('groups');

        // Add  the new User
        batch.set(_db.collection(COLLECTION_USER).doc(), data);
      } else {
        final data = FirestoreUser.fromJson((existingUser.data() as Map<String, dynamic>?)!);
        data.email = user.email ?? data.email;
        data.displayName = '${user.firstName} ${user.lastName}';
        data.photoURL = user.avatarUrl ?? '';

        final dataClone = data.toJson();
        dataClone.remove('doc_id');
        dataClone.remove('groups');

        batch.update(existingUser.reference, dataClone);
      }

      return batch.commit();
    } catch (ex) {
      print("saveUserToFirestore ${ex}");
    }
  }

  /// Tạo group với danh sách thành viên được chỉ định được truyền vào
  /// Nếu group đó tồn tại rồi thì không cần thêm nữa
  FutureOr<void> saveGroupToFirestore({
    required List<String> users,
    required String titleGroup,
    required String tourId,
  }) async {
    try {
      final QuerySnapshot query = await _db.collection(COLLECTION_GROUP).get();

      final WriteBatch batch = _db.batch();

      final existingGroup = query.docs.firstWhereOrNull((element) {
        final data = element.data() as Map?;
        return data?['id'] == tourId;
      });

      if (existingGroup == null) {
        final data = FirestoreGroupChat(
          createAt: DateTime.now(),
          createdBy: users.first,
          id: tourId,
          modifiedAt: DateTime.now(),
          type: 1,
          members: users,
          titleGroup: titleGroup,
        ).toJson();

        // Add  the new Group
        batch.set(_db.collection(COLLECTION_GROUP).doc(tourId), data);

        return batch.commit();
      }
    } catch (ex) {
      print("saveUserToFirestore ${ex}");
    }
  }

  /// Lấy tất cả danh sách các nhóm từ Firestore dựa trên uid của người dùng.
  Future<List<FirestoreGroupChat>> fetchGroupByUserID(String uid) async {
    CollectionReference groupRef = _db.collection(COLLECTION_GROUP);

    QuerySnapshot querySnapshot = await groupRef.where('members', arrayContains: uid).get();

    List<FirestoreGroupChat> allGroups = [];
    querySnapshot.docs.forEach((doc) {
      FirestoreGroupChat group = FirestoreGroupChat.fromJson(doc.data() as Map<String, dynamic>);
      group.id = doc.id;
      allGroups.add(group);
    });

    return allGroups;
  }

  Future<Map<String, dynamic>?> filterGroup(List<String> users) async {
    CollectionReference groupRef = _db.collection(COLLECTION_GROUP);

    Query query = groupRef;
    for (String userId in users) {
      query = query.where('members', arrayContains: userId);
    }

    QuerySnapshot querySnapshot = await query.get();

    List<Map<String, dynamic>> allGroups = [];
    querySnapshot.docs.forEach((doc) {
      Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
      if (data != null) {
        data['id'] = doc.id;
        allGroups.add(data);
      }
    });

    if (allGroups.isNotEmpty) {
      return allGroups.first;
    } else {
      return null;
    }
  }

  /// Lấy danh sách tin nhắn từ một nhóm dựa trên groupId từ Firestore
  Stream<List<FirestoreMessage>> fetchMessagesByGroupId(String groupId) {
    return _db
        .collection(COLLECTION_MESSAGE)
        .doc(groupId.trim())
        .collection(COLLECTION_MESSAGES)
        .orderBy('sentAt')
        .snapshots()
        .map((querySnapshot) => querySnapshot.docs
            .map((e) => FirestoreMessage.fromJson(e as Map<String, dynamic>))
            .toList());
  }

  /// Send message lên Firestore
  Future<FirestoreMessage> saveMessage(
      String uid, String messageText, DateTime sentAt, String currentGroupId) async {
    if (messageText.trim().isNotEmpty) {
      final data = FirestoreMessage(messageText: messageText, sentAt: sentAt, sentBy: uid);

      try {
        CollectionReference messageCollection =
            _db.collection(COLLECTION_MESSAGE).doc(currentGroupId).collection(COLLECTION_MESSAGES);

        DocumentReference docRef = await messageCollection.add(data.toJson());

        data.docId = docRef.id;

        return data;
      } catch (error) {
        throw error;
      }
    } else {
      throw 'Empty message';
    }
  }
}
