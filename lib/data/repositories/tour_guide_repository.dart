part of 'repositories.dart';

class TourGuideRepository {
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

  FutureOr<void> onCall({required String phone}) async {
    final url = Uri.parse("tel:$phone");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
