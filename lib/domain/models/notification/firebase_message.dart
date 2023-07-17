import 'package:hypertrip/utils/app_assets.dart';

class FirebaseMessage {
  String id;
  String title;
  String payload;
  FirebaseMessageType type;
  DateTime? timestamp;
  bool isRead;
  String imageUrl;

  FirebaseMessage({
    this.id = "0",
    this.title = '',
    this.payload = '',
    this.type = FirebaseMessageType.AttendanceActivity,
    this.timestamp,
    this.isRead = true,
    this.imageUrl = '',
  });

  FirebaseMessage.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? '0',
        title = json['title'] ?? '',
        payload = json['payload'] ?? '',
        type = _parseMessageType(json['type']),
        timestamp = json['timestamp'] != null
            ? DateTime.parse(json['timestamp'])
            : null,
        isRead = json['isRead'] ?? true,
        imageUrl = json['imageUrl'] ?? '';

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'payload': payload,
    'type': _getMessageTypeString(type),
    'timestamp': timestamp?.toIso8601String(),
    'isRead': isRead,
    'imageUrl': imageUrl,
  };

  FirebaseMessage copyWith({
    String? id,
    String? title,
    String? payload,
    FirebaseMessageType? type,
    DateTime? timestamp,
    bool? isRead,
    String? imageUrl,
  }) {
    return FirebaseMessage(
      id: id ?? this.id,
      title: title ?? this.title,
      payload: payload ?? this.payload,
      type: type ?? this.type,
      timestamp: timestamp ?? this.timestamp,
      isRead: isRead ?? this.isRead,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  static FirebaseMessageType _parseMessageType(String value) {
    switch (value) {
      case 'AttendanceActivity':
        return FirebaseMessageType.AttendanceActivity;
      case 'TourStarted':
        return FirebaseMessageType.TourStarted;
      default:
        return FirebaseMessageType.AttendanceActivity;
    }
  }

  static String _getMessageTypeString(FirebaseMessageType type) {
    switch (type) {
      case FirebaseMessageType.AttendanceActivity:
        return 'AttendanceActivity';
      case FirebaseMessageType.TourStarted:
        return 'TourStarted';
      default:
        return 'AttendanceActivity';
    }
  }
}

enum FirebaseMessageType {
  AttendanceActivity,
  TourStarted,
}

extension FirebaseMessageTypeExtension on FirebaseMessageType {
  String get image {
    switch (this) {
      case FirebaseMessageType.AttendanceActivity:
        return AppAssets.icons_ic_attendacnce_png;
      case FirebaseMessageType.TourStarted:
        return AppAssets.icons_ic_start_tour_jpg;
      default:
        return '';
    }
  }
}