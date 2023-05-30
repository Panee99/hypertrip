part of 'repositories.dart';

class TourGuideRepository {
  FutureOr<void> onSendingSMS(String phone) async {
    if (phone.isNotEmpty) {
      String formatPhoneNumber = AppUtils.formatPhoneNumber(phone);
      String bodySeparator = Platform.isIOS ? '&' : '?';
      String message = 'Tôi yêu Việt Nam';

      final uri =
          Uri.parse('sms:${formatPhoneNumber + bodySeparator}body=${Uri.encodeComponent(message)}');
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw 'Could not launch $uri';
      }
    }
  }
}
