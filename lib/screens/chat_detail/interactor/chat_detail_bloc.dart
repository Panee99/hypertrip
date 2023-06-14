import 'dart:async';
import 'dart:io';

import 'package:chatview/chatview.dart';
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:room_finder_flutter/data/repositories/firestore_repository.dart';
import 'package:room_finder_flutter/data/repositories/repositories.dart';
import 'package:room_finder_flutter/data/repositories/tour_group_repository.dart';
import 'package:room_finder_flutter/managers/firebase_messaging_manager.dart';
import 'package:room_finder_flutter/models/chat/firestore_message.dart';
import 'package:room_finder_flutter/models/chat/firestore_user.dart';
import 'package:room_finder_flutter/screens/chat_detail/interactor/chat_detail_event.dart';
import 'package:room_finder_flutter/screens/chat_detail/interactor/chat_detail_state.dart';
import 'package:room_finder_flutter/utils/app_languages.dart';
import 'package:room_finder_flutter/utils/app_utils.dart';
import 'package:room_finder_flutter/utils/page_states.dart';
import 'package:room_finder_flutter/widget/common.dart';

class ChatDetailBloc extends Bloc<ChatDetailEvent, ChatDetailState> {
  final FirestoreRepository _firestoreRepository;
  final AppRepository _appRepository;
  final TourGroupRepository _tourGroupRepository;
  final FoursquareRepository _foursquareRepository;
  final FirebaseMessagingManager _firebaseMessagingManager;

  ChatDetailBloc(
    this._firestoreRepository,
    this._appRepository,
    this._tourGroupRepository,
    this._foursquareRepository,
    this._firebaseMessagingManager,
  ) : super(ChatDetailState(
          messages: const [],
          error: '',
          message: '',
          firestoreUser: FirestoreUser(),
          status: PageState.loading,
          members: const [],
          deviceTokens: const [],
        )) {
    on<FetchMessageGroupChat>(_fetchMessageGroupChat);
    on<SendMessageGroupChat>(_sendMessageGroupChat);
    on<GetMembersTourGroup>(_getMembersTourGroup);
    on<StatusMapEvent>(_statusMapEvent);
    on<RequestPermissionLocationEvent>(_requestPermissionLocationEvent);
    on<DragPanelEvent>(_dragPanelEvent);
    on<GetAllTokenFCMDeviceGroup>(_getAllTokenFCMDeviceGroup);
  }

  FutureOr<void> _fetchMessageGroupChat(
      FetchMessageGroupChat event, Emitter<ChatDetailState> emit) async {
    await emit.forEach<List<FirestoreMessage>>(
      _firestoreRepository.fetchMessagesByGroupId(event.groupId),
      onError: (error, StackTrace stackTrace) {
        return state;
      },
      onData: (List<FirestoreMessage> result) {
        print("_fetchMessageGroupChat ${result.length}");
        return state.copyWith(
          messages: result,
          status: PageState.success,
        );
      },
    );
  }

  FutureOr<void> _sendMessageGroupChat(
      SendMessageGroupChat event, Emitter<ChatDetailState> emit) async {
    if (event.userId.isEmpty || event.groupId.isEmpty)
      toast(rf_lang_errorSystem);

    if (event.message.isEmpty) return;

    String message = event.message;
    if (event.type == MessageType.image || event.type == MessageType.voice) {
      File file = File(event.message);
      if (!file.existsSync()) {
        toast(rf_lang_notReadFile);
        return;
      }

      if (AppUtils.isMaxFileSize(file)) {
        toast(rf_lang_maxSizeFile);
      }

      final pathFile = await _appRepository.attachmentsFile(file);
      if (pathFile.url.isEmpty) {
        toast(rf_lang_notSendFile);
        return;
      }

      message = pathFile.url;
    }

    final result = await _firestoreRepository.saveMessage(
        event.userId, event.type, message, DateTime.now(), event.groupId);

    String content = state.currentUser?.name ?? '';
    switch (event.type) {
      case MessageType.image:
        content += ' đã gửi một hình ảnh mới';
        break;
      case MessageType.text:
        content += ' đã gửi một tin nhắn mới';
        break;
      case MessageType.voice:
        // TODO: Handle this case.
        break;
      case MessageType.custom:
        content += ' đã chia sẻ vị trí hiện tại';
        break;
    }
    _firebaseMessagingManager.sendFCMNotifications(
        state.deviceTokens, event.groupName, content);

    if (result == null) toast(rf_lang_currentNotSendFile);
  }

  FutureOr<void> _getMembersTourGroup(
      GetMembersTourGroup event, Emitter<ChatDetailState> emit) async {
    final profiles =
        await _tourGroupRepository.getMembersTourGroup(event.groupId);
    final currentUser =
        profiles.firstWhereOrNull((profile) => profile.id == event.userId);
    emit(state.copyWith(
        currentUser: currentUser?.toMember(),
        members: profiles.map((e) => e.toMember()).toList()));
  }

  FutureOr<void> _statusMapEvent(
      StatusMapEvent event, Emitter<ChatDetailState> emit) async {
    bool permissionGeo = false;
    if (!state.isPermissionGeolocation) {
      permissionGeo = await _foursquareRepository.isPermissionGeolocation();

      final position = await _foursquareRepository.getCurrentLocation();
      emit(state.copyWith(
          isOpenMap: !event.isOpenMap,
          isPermissionGeolocation: permissionGeo,
          position: position));
    } else {
      emit(state.copyWith(isOpenMap: !event.isOpenMap));
    }
  }

  FutureOr<void> _requestPermissionLocationEvent(
      RequestPermissionLocationEvent event,
      Emitter<ChatDetailState> emit) async {
    bool permissionGeo = await _foursquareRepository.requestPermission();

    emit(state.copyWith(isPermissionGeolocation: permissionGeo));
  }

  FutureOr<void> _dragPanelEvent(
      DragPanelEvent event, Emitter<ChatDetailState> emit) {
    emit(state.copyWith(isCanDrag: event.isTap));
  }

  FutureOr<void> _getAllTokenFCMDeviceGroup(
      GetAllTokenFCMDeviceGroup event, Emitter<ChatDetailState> emit) async {
    final response = await _tourGroupRepository
        .getAllTokenFCMDeviceGroup(state.members.map((e) => e.id).toList());

    emit(state.copyWith(deviceTokens: response));
  }
}
