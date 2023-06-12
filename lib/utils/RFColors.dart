import 'package:flutter/material.dart';

const rf_primaryColor = Color(0xFF6DA9E4);
const rf_splashBgColor = Color(0xFFAFD3E2);
const rf_categoryBgColor = Color(0xFFF3F3F3);
const rf_selectedCategoryBgColor = Color(0xFFE8ECF7);
const rf_faqBgColor = Color(0xFFD5DDF2);
const rf_notificationBgColor = Color(0xFFF2F2F2);
const rf_rattingBgColor = Color(0xFF2DD35c);
const rf_textColor = Color(0xFF4F4F4F);
const textBlurColor = Color(0xFFBDC1C6);
const starRateColor = Color(0xFFF99D00);
const starUnrateColor = Color(0xFFCDCDCD);
const disableButtonColor = Color(0xFFBDC1C6);
const secondaryColor = Color(0xFFFF9900);

// Dark Theme Colors
const appBackgroundColorDark = Color(0xFF121212);
const cardBackgroundBlackDark = Color(0xFF1F1F1F);
const color_primary_black = Color(0xFF131d25);
const appColorPrimaryDarkLight = Color(0xFFF9FAFF);
const iconColorPrimaryDark = Color(0xFF212121);
const iconColorSecondaryDark = Color(0xFFA8ABAD);
const appShadowColorDark = Color(0x1A3E3942);
const appColorPrimary = Color(0xFF1157FA);
const appSecondaryBackgroundColor = Color(0xff343434);
const iconColorPrimary = Color(0xFFFFFFFF);
const iconColorSecondary = Color(0xFFA8ABAD);
const appColorPrimaryLight = Color(0xFFF9FAFF);
const appTextColorPrimary = Color(0xFF212121);
const appTextColorSecondary = Color(0xFF5A5C5E);
const appShadowColor = Color(0x95E9EBF0);

const Color white18 = Color(0x2EFFFFFF);
const Color black18 = Color(0x2E000000);

const Color white8 = Color(0x14FFFFFF);
const Color black8 = Color(0x14000000);

const Color white72 = Color(0xB8FFFFFF);
const Color black72 = Color(0xB8000000);

const Color repliedMessageColor = Color(0xff9f85ff);

Color chatsSeparatorLineColor(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark ? white18 : black18;

Color chatsAttachmentIconColor(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark ? white72 : black72;

Color chatMessageInputBGColor(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark ? white8 : black8;

Color chatMessageOverlayBGColor(BuildContext context) =>
    Theme.of(context).brightness == Brightness.dark ? white8 : black8;
