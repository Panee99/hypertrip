import 'package:chatview/chatview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/ui/chat_detail/components/member_item.dart';
import 'package:room_finder_flutter/ui/chat_detail/interactor/chat_detail_bloc.dart';
import 'package:room_finder_flutter/ui/chat_detail/interactor/chat_detail_state.dart';

class MemberList extends StatelessWidget {
  final List<ChatUser> members;
  const MemberList({Key? key, required this.members}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: GetIt.I.get<ChatDetailBloc>(),
      child: BlocBuilder<ChatDetailBloc, ChatDetailState>(
        builder: (context, state) {
          return SafeArea(
            child: Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.only(left: 100),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  20.height,
                  Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      "Danh sách thành viên",
                      style: boldTextStyle(size: 24),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: members.map((member) => MemberItem(data: member)).toList(),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}