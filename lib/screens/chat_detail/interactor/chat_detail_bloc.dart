import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:room_finder_flutter/data/repositories/firestore_repository.dart';
import 'package:room_finder_flutter/models/chat/firestore_message.dart';
import 'package:room_finder_flutter/models/chat/firestore_user.dart';
import 'package:room_finder_flutter/screens/chat_detail/interactor/chat_detail_event.dart';
import 'package:room_finder_flutter/screens/chat_detail/interactor/chat_detail_state.dart';

class ChatDetailBloc extends Bloc<ChatDetailEvent, ChatDetailState> {
  final FirestoreRepository _firestoreRepository;

  ChatDetailBloc(this._firestoreRepository)
      : super(ChatDetailLoadingState(
            messages: const [], error: '', message: '', firestoreUser: FirestoreUser())) {
    on<FetchMessageGroupChat>(_fetchMessageGroupChat);
    on<SendMessageGroupChat>(_sendMessageGroupChat);
    on<GetUserFirestore>(_getUserFirestore);
  }

  FutureOr<void> _fetchMessageGroupChat(
      FetchMessageGroupChat event, Emitter<ChatDetailState> emit) async {
    await emit.forEach<List<FirestoreMessage>>(
      _firestoreRepository.fetchMessagesByGroupId(event.groupId),
      onError: (error, StackTrace stackTrace) {
        return state;
      },
      onData: (List<FirestoreMessage> result) {
        return state.copyWith(messages: result);
      },
    );
  }

  FutureOr<void> _sendMessageGroupChat(
      SendMessageGroupChat event, Emitter<ChatDetailState> emit) async {
    await _firestoreRepository.saveMessage(
        event.userId, event.message, DateTime.now(), event.groupId);
  }

  FutureOr<void> _getUserFirestore(GetUserFirestore event, Emitter<ChatDetailState> emit) async {
    final firestoreUser = await _firestoreRepository.getUserByUserID(event.userId);
    emit(state.copyWith(firestoreUser: firestoreUser));
  }
}
