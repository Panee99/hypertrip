import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:room_finder_flutter/data/repositories/firestore_repository.dart';
import 'package:room_finder_flutter/models/chat/firestore_group_chat.dart';
import 'package:room_finder_flutter/screens/chat/interactor/chat_event.dart';
import 'package:room_finder_flutter/screens/chat/interactor/chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final FirestoreRepository _firestoreRepository;

  ChatBloc(this._firestoreRepository) : super(ChatLoadingState(groupChat: const [], error: '')) {
    on<FetchGroupChat>(_fetchGroupChat);
  }

  FutureOr<void> _fetchGroupChat(FetchGroupChat event, Emitter<ChatState> emit) async {
    if (event.userid != null) {
      await emit.forEach<List<FirestoreGroupChat>>(
        _firestoreRepository.fetchGroupByUserID(event.userid!),
        onError: (error, StackTrace stackTrace) {
          return state;
        },
        onData: (List<FirestoreGroupChat> result) {
          return state.copyWith(groupChat: result);
        },
      );
    }
  }
}
