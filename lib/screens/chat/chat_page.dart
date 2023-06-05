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
import 'package:room_finder_flutter/utils/app_languages.dart';

class ChatPageScreen extends StatefulWidget {
  @override
  _ChatPageScreenState createState() => _ChatPageScreenState();
}

class _ChatPageScreenState extends State<ChatPageScreen> {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return BlocProvider(
      create: (BuildContext context) =>
          GetIt.I.get<ChatBloc>()..add(FetchGroupChat(authProvider.user.id)),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(40),
          child: AppBar(
            leading: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    rf_lang_doan_chat,
                    style: boldTextStyle(color: Colors.black, size: 20),
                  ),
                ]).paddingLeft(16),
            leadingWidth: 150,
            elevation: 0,
            backgroundColor: whiteSmoke,
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: whiteSmoke, statusBarIconBrightness: Brightness.dark),
            // actions: [
            //   Row(
            //     children: [
            //       SvgPicture.asset(add_square, height: 20),
            //       16.width,
            //     ],
            //   ).paddingRight(16),
            // ],
          ),
        ),
        body: BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 16),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search...",
                      hintStyle: TextStyle(color: Colors.grey.shade600),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey.shade600,
                        size: 20,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade300,
                      contentPadding: EdgeInsets.all(8),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.grey.shade100)),
                    ),
                  ),
                ),
                ListView.builder(
                  itemCount: state.groupChat.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 16),
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return ConversationList(
                      data: state.groupChat[index],
                      userID: authProvider.user.id ?? '',
                    );
                  },
                ),
              ],
            ).paddingOnly(left: 16, top: 8);
          },
        ),
      ),
    );
  }
}
