import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:room_finder_flutter/data/repositories/repositories.dart';
import 'package:room_finder_flutter/data/repositories/traveler_respository.dart';
import 'package:room_finder_flutter/models/tourguide/assign_group_response.dart';
import 'package:room_finder_flutter/models/tourguide/tour_variant.dart';
import 'package:room_finder_flutter/models/user/profile_response.dart';
import 'package:room_finder_flutter/screens/chat/interactor/chat_event.dart';
import 'package:room_finder_flutter/screens/chat/interactor/chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final TourGuideRepository _tourGuideRepository;
  final TravelerRepository _travelerRepository;

  List<AssignGroupResponse> _originList = [];

  ChatBloc(this._tourGuideRepository, this._travelerRepository)
      : super(ChatLoadingState(groupChat: [], error: '')) {
    on<FetchGroupChat>(_fetchGroupChat);
    on<SearchGroupEvent>(_searchGroupEvent);
  }

  Future<void> _fetchGroupChat(FetchGroupChat event, Emitter<ChatState> emit) async {
    try {
      if (event.userid != null && event.userid!.isNotEmpty) {
        List<AssignGroupResponse> result = [];
        if (event.role == RoleStatus.TourGuide) {
          result = (await _tourGuideRepository.getAllAssignedGroups(event.userid!))
              .where((element) => element.tourVariant?.status == TourVariantStatus.Accepting)
              .toList();
        } else {
          result.add(await _travelerRepository.getAllCurrentGroups(event.userid!));
        }
        _originList = result;
        emit(state.copyWith(groupChat: result));
      }
    } catch (ex) {
      emit(ChatErrorState(error: ex.toString(), groupChat: state.groupChat));
    }
  }

  Future<void> _searchGroupEvent(SearchGroupEvent event, Emitter<ChatState> emit) async {
    try {
      final lstAfterSearch = event.key.isNotEmpty
          ? _originList.where((assignGroupResponse) {
              if (assignGroupResponse.groupName.toLowerCase().contains(event.key.toLowerCase()))
                return true;

              if ((assignGroupResponse.tourVariant?.code
                      .toLowerCase()
                      .contains(event.key.toLowerCase()) ??
                  false)) return true;

              if ((assignGroupResponse.tourVariant?.tour?.destination
                      .toLowerCase()
                      .contains(event.key.toLowerCase()) ??
                  false)) return true;
              if ((assignGroupResponse.tourVariant?.tour?.description
                      .toLowerCase()
                      .contains(event.key.toLowerCase()) ??
                  false)) return true;

              return false;
            }).toList()
          : _originList;
      emit(state.copyWith(groupChat: lstAfterSearch));
    } catch (ex) {
      emit(ChatErrorState(error: ex.toString(), groupChat: state.groupChat));
    }
  }
}
