import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:room_finder_flutter/provider/AuthProvider.dart';
import 'package:room_finder_flutter/utils/RFImages.dart';

class RFAvatar extends StatelessWidget {
  const RFAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return CircleAvatar(
      radius: 16,
      backgroundImage: authProvider.user.avatarUrl.validate() != ''
          ? NetworkImage(authProvider.user.avatarUrl.validate()) as ImageProvider<Object>?
          : AssetImage(avatar_placeholoder),
    );
  }
}
