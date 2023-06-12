import 'dart:async';
import 'dart:io';

import 'package:chatview/chatview.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:room_finder_flutter/data/repositories/firestore_repository.dart';
import 'package:room_finder_flutter/data/repositories/repositories.dart';
import 'package:room_finder_flutter/models/chat/firestore_message.dart';
import 'package:room_finder_flutter/models/chat/firestore_user.dart';
import 'package:room_finder_flutter/screens/chat_detail/interactor/chat_detail_event.dart';
import 'package:room_finder_flutter/screens/chat_detail/interactor/chat_detail_state.dart';
import 'package:room_finder_flutter/utils/page_states.dart';
import 'package:room_finder_flutter/widget/common.dart';

class ChatDetailBloc extends Bloc<ChatDetailEvent, ChatDetailState> {
  final FirestoreRepository _firestoreRepository;
  final AppRepository _appRepository;

  ChatDetailBloc(this._firestoreRepository, this._appRepository)
      : super(ChatDetailLoadingState(
          messages: const [],
          error: '',
          message: '',
          firestoreUser: FirestoreUser(),
          status: PageState.loading,
        )) {
    on<FetchMessageGroupChat>(_fetchMessageGroupChat);
    on<SendMessageGroupChat>(_sendMessageGroupChat);
    on<GetProfileUser>(_getProfileUser);
  }

  FutureOr<void> _fetchMessageGroupChat(
      FetchMessageGroupChat event, Emitter<ChatDetailState> emit) async {
    await emit.forEach<List<FirestoreMessage>>(
      _firestoreRepository.fetchMessagesByGroupId(event.groupId),
      onError: (error, StackTrace stackTrace) {
        return state;
      },
      onData: (List<FirestoreMessage> result) {
        return state.copyWith(messages: result, status: PageState.success);
      },
    );
  }

  FutureOr<void> _sendMessageGroupChat(
      SendMessageGroupChat event, Emitter<ChatDetailState> emit) async {
    if (event.userId.isEmpty || event.groupId.isEmpty)
      toast("Lỗi hệ thống, vui lòng liên hệ hỗ trợ");

    if (event.message.isEmpty) return;

    String message = event.message;
    if (event.type == MessageType.image || event.type == MessageType.voice) {
      File file = File(event.message);
      final pathFile = await _appRepository.attachmentsFile(file);
      if (pathFile.url.isEmpty) {
        toast("Lỗi không gửi được file");
        return;
      }

      message = pathFile.url;
    }

    final result = await _firestoreRepository.saveMessage(
        event.userId, event.type, message, DateTime.now(), event.groupId);

    if (result == null) toast("Hiện tại không thể gửi message");
  }

  FutureOr<void> _getProfileUser(GetProfileUser event, Emitter<ChatDetailState> emit) async {
    final firestoreUser = await _appRepository.getProfileUser(event.userId);
    emit(state.copyWith(firestoreUser: firestoreUser));
  }
}
