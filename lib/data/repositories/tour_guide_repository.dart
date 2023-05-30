part of 'repositories.dart';

class TourGuideRepository {
  /// Check if a phone number is valid for making a sms, and if it is in the correct phone number format, then make the sms.
  FutureOr<void> onSendingSMS({required String phone}) async {
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

  /// Check if a phone number is valid for making a call, and if it is in the correct phone number format, then make the call.
  FutureOr<void> onCall({required String phone}) async {
    final url = Uri.parse("tel:$phone");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
