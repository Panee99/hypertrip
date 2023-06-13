class TourDetailResponse {
  List<Schedules>? schedules;
  List<Carousel>? carousel;
  String? id;
  String? title;
  String? departure;
  String? destination;
  String? duration;
  String? description;
  Null? policy;
  String? thumbnailUrl;
  int? maxOccupancy;
  String? type;
  String? status;

  TourDetailResponse(
      {this.schedules,
      this.carousel,
      this.id,
      this.title,
      this.departure,
      this.destination,
      this.duration,
      this.description,
      this.policy,
      this.thumbnailUrl,
      this.maxOccupancy,
      this.type,
      this.status});

  TourDetailResponse.fromJson(Map<String, dynamic> json) {
    if (json['schedules'] != null) {
      schedules = <Schedules>[];
      json['schedules'].forEach((v) {
        schedules!.add(new Schedules.fromJson(v));
      });
    }
    if (json['carousel'] != null) {
      carousel = <Carousel>[];
      json['carousel'].forEach((v) {
        carousel!.add(new Carousel.fromJson(v));
      });
    }
    id = json['id'];
    title = json['title'];
    departure = json['departure'];
    destination = json['destination'];
    duration = json['duration'];
    description = json['description'];
    policy = json['policy'];
    thumbnailUrl = json['thumbnailUrl'];
    maxOccupancy = json['maxOccupancy'];
    type = json['type'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.schedules != null) {
      data['schedules'] = this.schedules!.map((v) => v.toJson()).toList();
    }
    if (this.carousel != null) {
      data['carousel'] = this.carousel!.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    data['title'] = this.title;
    data['departure'] = this.departure;
    data['destination'] = this.destination;
    data['duration'] = this.duration;
    data['description'] = this.description;
    data['policy'] = this.policy;
    data['thumbnailUrl'] = this.thumbnailUrl;
    data['maxOccupancy'] = this.maxOccupancy;
    data['type'] = this.type;
    data['status'] = this.status;
    return data;
  }
}

class Schedules {
  String? id;
  int? sequence;
  String? description;
  double? longitude;
  double? latitude;
  String? vehicle;

  Schedules(
      {this.id,
      this.sequence,
      this.description,
      this.longitude,
      this.latitude,
      this.vehicle});

  Schedules.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sequence = json['sequence'];
    description = json['description'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    vehicle = json['vehicle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sequence'] = this.sequence;
    data['description'] = this.description;
    data['longitude'] = this.longitude;
    data['latitude'] = this.latitude;
    data['vehicle'] = this.vehicle;
    return data;
  }
}

class Carousel {
  String? id;
  String? contentType;
  String? url;

  Carousel({this.id, this.contentType, this.url});

  Carousel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    contentType = json['contentType'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['contentType'] = this.contentType;
    data['url'] = this.url;
    return data;
  }
}
