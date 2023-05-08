import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:room_finder_flutter/models/TourFinderModel.dart';
import 'package:room_finder_flutter/screens/RFAboutUsScreen.dart';
import 'package:room_finder_flutter/screens/RFHelpScreen.dart';
import 'package:room_finder_flutter/screens/RFNotificationScreen.dart';
import 'package:room_finder_flutter/screens/RFRecentlyViewedScreen.dart';
import 'package:room_finder_flutter/screens/account/WarningSettingScreen.dart';
import 'package:room_finder_flutter/utils/RFImages.dart';

List<TourFinderModel> categoryList() {
  List<TourFinderModel> categoryListData = [];
  categoryListData.add(TourFinderModel(roomCategoryName: "Hồ Chí Minh"));
  categoryListData.add(TourFinderModel(roomCategoryName: "Phú Quốc"));
  categoryListData.add(TourFinderModel(roomCategoryName: "Đà Nẵng"));
  categoryListData.add(TourFinderModel(roomCategoryName: "Cần Thơ"));
  categoryListData.add(TourFinderModel(roomCategoryName: "Hà Nội"));

  return categoryListData;
}

List<TourFinderModel> tourList() {
  List<TourFinderModel> tourListData = [];
  tourListData.add(TourFinderModel(
      img: rf_hotel1,
      color: greenColor.withOpacity(0.6),
      roomCategoryName:
          "DU LỊCH THỤY SĨ [ZURICH – LUCERNE – ISELTWALD – INTERLAKEN – GRINDELWALD - GRUYÈRES – ZERMATT – MATTERHORN - MONTREUX – LAUSANNE - GENEVA]",
      price: "\ 500.000 đ / ",
      rentDuration: "tour",
      location: "Ho Chi Minh",
      address: "4 ngày 3 đêm",
      description: "9 joined | ",
      views: "20 Views"));
  tourListData.add(TourFinderModel(
      img: rf_hotel2,
      color: redColor,
      roomCategoryName:
          "Tour Đà Nẵng – Bà Nà – Hội An – Ngũ Hành Sơn từ Hà Nội 3N2Đ cực HOT",
      price: "\ 500 đ/ ",
      rentDuration: "tour",
      location: "Hà Nội",
      address: "3 ngày 2 đêm",
      description: "5 joined | ",
      views: "10 Views"));
  tourListData.add(TourFinderModel(
      img: rf_hotel3,
      color: greenColor.withOpacity(0.6),
      roomCategoryName:
          "Tour Đà Nẵng – Bà Nà – Hội An – Ngũ Hành Sơn từ TP.HCM | Giá Cực SHOCK",
      price: "\ 60 đ/ ",
      rentDuration: "per day",
      location: "Quang Ngai",
      address: "3 ngày 2 đêm",
      description: "10 joined | ",
      views: "06 Views"));
  tourListData.add(TourFinderModel(
      img: rf_hotel4,
      color: redColor,
      roomCategoryName: "Ca Mau Tour",
      price: "\ 500 đ/ ",
      rentDuration: "tour",
      location: "Ca Mau",
      address: "non-participating",
      description: "16 joined | ",
      views: "12 Views"));
  tourListData.add(TourFinderModel(
      img: rf_hotel5,
      color: greenColor.withOpacity(0.6),
      roomCategoryName: "Hoa Ky Tour",
      price: "\ 2000 đ/ ",
      rentDuration: "tour",
      location: "Hoa Ky",
      address: "non-participating",
      description: "9 joined | ",
      views: "25 Views"));
  tourListData.add(TourFinderModel(
      img: rf_hotel2,
      color: redColor,
      roomCategoryName: "Canada Tour",
      price: "\ 5000 đ/ ",
      rentDuration: "tour",
      location: "Canada",
      address: "non-participating",
      description: "5 joined | ",
      views: "10 Views"));

  return tourListData;
}

List<TourFinderModel> locationList() {
  List<TourFinderModel> locationListData = [];
  locationListData.add(TourFinderModel(
      img: rf_location1, price: "10 Found", location: "Phú Quốc"));
  locationListData.add(TourFinderModel(
      img: rf_location2, price: "4 Found", location: "Đà Nẵng"));
  locationListData.add(TourFinderModel(
      img: rf_location3, price: "12 Found", location: "Hồ Chí Minh"));
  locationListData.add(TourFinderModel(
      img: rf_location4, price: "16 Found", location: "Hà Nội"));
  locationListData.add(TourFinderModel(
      img: rf_location5, price: "20 Found", location: "Cần Thơ"));
  locationListData.add(TourFinderModel(
      img: rf_location6, price: "25 Found", location: "Nha Trang"));

  return locationListData;
}

List<TourFinderModel> faqList() {
  List<TourFinderModel> faqListData = [];
  faqListData.add(TourFinderModel(
      img: rf_faq,
      price: "What do we get here in this app?",
      description:
          "That which doesn't kill you makes you stronger, right? Unless it almost kills you, and renders you weaker. Being strong is pretty rad though, so go ahead."));
  faqListData.add(TourFinderModel(
      img: rf_faq,
      price: "What is the use of this App?",
      description:
          "Sometimes, you've just got to say 'the party starts here'. Unless you're not in the place where the aforementioned party is starting. Then, just shut up."));
  faqListData.add(TourFinderModel(
      img: rf_faq,
      price: "How to get from location A to B?",
      description:
          "If you believe in yourself, go double or nothing. Well, depending on how long it takes you to calculate what double is. If you're terrible at maths, don't."));

  return faqListData;
}

List<TourFinderModel> notificationList() {
  List<TourFinderModel> notificationListData = [];
  notificationListData.add(TourFinderModel(
      price: "Welcome",
      unReadNotification: false,
      description: "Don't forget to complete your personal info."));
  notificationListData.add(TourFinderModel(
      price: "There are 4 available properties, you recently selected. ",
      unReadNotification: true,
      description: "Click here for more details."));

  return notificationListData;
}

List<TourFinderModel> yesterdayNotificationList() {
  List<TourFinderModel> yesterdayNotificationListData = [];
  yesterdayNotificationListData.add(TourFinderModel(
      price: "There are 4 available properties, you recently selected. ",
      unReadNotification: false,
      description: "Click here for more details."));
  yesterdayNotificationListData.add(TourFinderModel(
      price: "There are 4 available properties, you recently selected. ",
      unReadNotification: true,
      description: "Click here for more details."));
  yesterdayNotificationListData.add(TourFinderModel(
      price: "There are 4 available properties, you recently selected. ",
      unReadNotification: true,
      description: "Click here for more details."));

  return yesterdayNotificationListData;
}

List<TourFinderModel> settingList() {
  List<TourFinderModel> settingListData = [];
  settingListData.add(TourFinderModel(
      img: rf_notification,
      roomCategoryName: "Notifications",
      newScreenWidget: RFNotificationScreen()));
  settingListData.add(TourFinderModel(
      img: settings,
      roomCategoryName: "Warning Setting",
      newScreenWidget: WarningSettingScreen()));
  settingListData.add(TourFinderModel(
      img: rf_recent_view,
      roomCategoryName: "Recent Viewed",
      newScreenWidget: RFRecentlyViewedScreen()));
  settingListData.add(TourFinderModel(
      img: rf_faq,
      roomCategoryName: "Get Help",
      newScreenWidget: RFHelpScreen()));
  settingListData.add(TourFinderModel(
      img: rf_about_us,
      roomCategoryName: "About us",
      newScreenWidget: RFAboutUsScreen()));
  settingListData.add(TourFinderModel(
      img: rf_sign_out,
      roomCategoryName: "Sign Out",
      newScreenWidget: SizedBox()));

  return settingListData;
}

List<TourFinderModel> applyHotelList() {
  List<TourFinderModel> applytourListData = [];
  applytourListData.add(TourFinderModel(roomCategoryName: "Applied (5)"));
  applytourListData.add(TourFinderModel(roomCategoryName: "Liked"));

  return applytourListData;
}

List<TourFinderModel> availableHotelList() {
  List<TourFinderModel> availabletourListData = [];
  availabletourListData
      .add(TourFinderModel(roomCategoryName: "All Available(14)"));
  availabletourListData.add(TourFinderModel(roomCategoryName: "Booked"));

  return availabletourListData;
}

List<TourFinderModel> appliedHotelList() {
  List<TourFinderModel> appliedHotelData = [];
  appliedHotelData.add(TourFinderModel(
      img: rf_hotel1,
      roomCategoryName: "1 BHK at Lalitpur",
      price: "RS 8000 ",
      rentDuration: "1.2 km from Gwarko",
      location: "Mahalaxmi Lalitpur",
      address: "Booked",
      views: "3.0"));
  appliedHotelData.add(TourFinderModel(
      img: rf_hotel2,
      roomCategoryName: "Big Room",
      price: "RS 5000 ",
      rentDuration: "1.2 km from Mahalaxmi",
      location: "Imadol",
      address: "Booked",
      views: "4.0"));
  appliedHotelData.add(TourFinderModel(
      img: rf_hotel3,
      roomCategoryName: "4 Room for Student",
      price: "RS 6000 ",
      rentDuration: "1.2 km from Imadol",
      location: "Kupondole",
      address: "Booked",
      views: "2.5"));
  appliedHotelData.add(TourFinderModel(
      img: rf_hotel4,
      roomCategoryName: "Hall and Room",
      price: "RS 5000 ",
      rentDuration: "1.2 km from Kupondole",
      location: "Koteshwor Lalitpur",
      address: "Booked",
      views: "4.5"));
  appliedHotelData.add(TourFinderModel(
      img: rf_hotel5,
      roomCategoryName: "Big Room",
      price: "RS 2000 ",
      rentDuration: "1.2 km from Koteshwor",
      location: "Imadol",
      address: "Booked",
      views: "5.0"));

  return appliedHotelData;
}

List<TourFinderModel> hotelImageList() {
  List<TourFinderModel> hotelImageListData = [];
  hotelImageListData.add(TourFinderModel(img: rf_hotel1));
  hotelImageListData.add(TourFinderModel(img: rf_hotel2));
  hotelImageListData.add(TourFinderModel(img: rf_hotel3));
  hotelImageListData.add(TourFinderModel(img: rf_hotel4));

  return hotelImageListData;
}
