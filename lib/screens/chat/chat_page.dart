import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:room_finder_flutter/provider/AuthProvider.dart';
import 'package:room_finder_flutter/screens/chat/components/conversation_list.dart';
import 'package:room_finder_flutter/screens/chat/interactor/chat_bloc.dart';
import 'package:room_finder_flutter/screens/chat/interactor/chat_event.dart';
import 'package:room_finder_flutter/screens/chat/interactor/chat_state.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/app_languages.dart';
import 'package:room_finder_flutter/utils/base_page.dart';
import 'package:room_finder_flutter/widget/text_form_field_title.dart';

class ChatPageScreen extends StatelessWidget {
  const ChatPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return BlocProvider(
      create: (BuildContext context) => GetIt.I.get<ChatBloc>()
        ..add(FetchGroupChat(authProvider.user.id, authProvider.user.role)),
      child: BasePage(
        unFocusWhenTouchOutsideInput: true,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(40),
            child: AppBar(
              leading: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      rf_lang_doan_chat,
                      style: boldTextStyle(color: Colors.black, size: 20),
                    ),
                  ]).paddingSymmetric(horizontal: 16),
              leadingWidth: 150,
              elevation: 0,
              backgroundColor: whiteSmoke,
              systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: whiteSmoke, statusBarIconBrightness: Brightness.dark),
            ),
          ),
          body: BlocBuilder<ChatBloc, ChatState>(
            builder: (context, state) {
              return RefreshIndicator(
                onRefresh: () async {
                  context
                      .read<ChatBloc>()
                      .add(FetchGroupChat(authProvider.user.id, authProvider.user.role));
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormFieldTitle(
                      hintText: rf_lang_searchHint,
                      borderRadius: 20,
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey.shade600,
                        size: 20,
                      ),
                      widthPrefix: 50,
                      paddingBottom: 10,
                      onChanged: (value) => context.read<ChatBloc>().add(SearchGroupEvent(value)),
                    ),
                    ListView.separated(
                      itemCount: state.groupChat.length,
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(top: 0),
                      itemBuilder: (context, index) {
                        return ConversationList(
                          data: state.groupChat[index],
                          userID: authProvider.user.id ?? '',
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider(height: 1, color: rf_faqBgColor);
                      },
                    ),
                  ],
                ).paddingOnly(left: 16, top: 8, right: 16),
              );
            },
          ),
        ),
      ),
    );
  }
}
