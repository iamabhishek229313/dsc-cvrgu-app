class EventData {
  String eventLink;
  String eventPoster;
  String eventTitle;
  String to;
  String eventHost;
  List<String> eventParticipants;
  String from;
  String eventLocation;
  String eventId;
  Timestamp timestamp;
  String eventDescription;
  String eventStatus;

  EventData(
      {this.eventLink,
      this.eventPoster,
      this.eventTitle,
      this.to,
      this.eventHost,
      this.eventParticipants,
      this.from,
      this.eventLocation,
      this.eventId,
      this.timestamp,
      this.eventDescription,
      this.eventStatus});

  EventData.fromJson(Map<String, dynamic> json) {
    eventLink = json['EventLink'];
    eventPoster = json['EventPoster'];
    eventTitle = json['EventTitle'];
    to = json['To'];
    eventHost = json['EventHost'];
    // if (json['EventParticipants'] != null) {
    //   eventParticipants = new List<Null>();
    //   json['EventParticipants'].forEach((v) {
    //     eventParticipants.add(v);
    //   });
    // }
    from = json['From'];
    eventLocation = json['EventLocation'];
    eventId = json['EventId'];
    timestamp = json['timestamp'] != null
        ? (json['timestamp'] is String)
            ? null
            : Timestamp.fromJson(json['timestamp'])
        : null;
    eventDescription = json['EventDescription'];
    eventStatus = json['EventStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['EventLink'] = this.eventLink;
    data['EventPoster'] = this.eventPoster;
    data['EventTitle'] = this.eventTitle;
    data['To'] = this.to;
    data['EventHost'] = this.eventHost;
    if (this.eventParticipants != null) {
      data['EventParticipants'] = this.eventParticipants.map((v) => v).toList();
    }
    data['From'] = this.from;
    data['EventLocation'] = this.eventLocation;
    data['EventId'] = this.eventId;
    if (this.timestamp != null) {
      data['timestamp'] = this.timestamp.toJson();
    }
    data['EventDescription'] = this.eventDescription;
    data['EventStatus'] = this.eventStatus;
    return data;
  }
}

class Timestamp {
  int iSeconds;
  int iNanoseconds;

  Timestamp({this.iSeconds, this.iNanoseconds});

  Timestamp.fromJson(Map<String, dynamic> json) {
    iSeconds = json['_seconds'];
    iNanoseconds = json['_nanoseconds'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_seconds'] = this.iSeconds;
    data['_nanoseconds'] = this.iNanoseconds;
    return data;
  }
}
