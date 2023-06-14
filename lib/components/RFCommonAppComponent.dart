import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/main.dart';
import 'package:room_finder_flutter/utils/RFColors.dart';
import 'package:room_finder_flutter/utils/RFWidget.dart';

class RFCommonAppComponent extends StatefulWidget {
  final String? title;
  final String? subTitle;
  final String? coverImage;
  final Widget? cardWidget;
  final Widget? subWidget;
  final Widget? accountCircleWidget;
  final double? mainWidgetHeight;
  final double? subWidgetHeight;
  final bool scroll;

  const RFCommonAppComponent(
      {super.key,
      this.title,
      this.subTitle,
      this.coverImage,
      this.cardWidget,
      this.subWidget,
      this.mainWidgetHeight,
      this.subWidgetHeight,
      this.accountCircleWidget,
      this.scroll = true});

  @override
  State<RFCommonAppComponent> createState() => _RFCommonAppComponentState();
}

class _RFCommonAppComponentState extends State<RFCommonAppComponent> {
  Future<void> _handleRefresh() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _handleRefresh,
      child: SingleChildScrollView(
        physics: widget.scroll
            ? const AlwaysScrollableScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 24),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: context.width(),
              height: widget.mainWidgetHeight ?? 300,
              decoration: widget.coverImage == null
                  ? boxDecorationWithRoundedCorners(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
                      backgroundColor: rf_primaryColor,
                    )
                  : boxDecorationWithRoundedCorners(
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(16), bottomRight: Radius.circular(16)),
                      decorationImage: DecorationImage(
                          image: AssetImage(widget.coverImage!), fit: BoxFit.cover)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.title.validate(), style: boldTextStyle(color: white, size: 22)),
                  4.height,
                  Text(widget.subTitle.validate(), style: primaryTextStyle(color: white)),
                ],
              ),
            ),
            Column(
              children: [
                widget.accountCircleWidget ??
                    Container(
                      margin: EdgeInsets.only(
                          top: widget.subWidgetHeight ?? 200, left: 24, bottom: 24, right: 24),
                      padding: const EdgeInsets.all(24),
                      decoration: appStore.isDarkModeOn
                          ? boxDecorationWithRoundedCorners(backgroundColor: context.cardColor)
                          : shadowWidget(context),
                      child: widget.cardWidget.validate(),
                    ),
                widget.subWidget.validate(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
