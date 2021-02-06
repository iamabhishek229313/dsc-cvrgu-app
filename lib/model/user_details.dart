class UserDetail {
  String collegeName;
  String email;
  String name;
  String stream;
  int year;
  int batchYear;
  int timestamp;

  UserDetail({this.collegeName, this.email, this.name, this.stream, this.year, this.batchYear, this.timestamp});

  UserDetail.fromJson(Map<String, dynamic> json) {
    collegeName = json['CollegeName'];
    email = json['Email'];
    name = json['Name'];
    stream = json['Stream'];
    year = json['Year'];
    batchYear = json['batch_year'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CollegeName'] = this.collegeName;
    data['Email'] = this.email;
    data['Name'] = this.name;
    data['Stream'] = this.stream;
    data['Year'] = this.year;
    data['batch_year'] = this.batchYear;
    data['timestamp'] = this.timestamp;
    return data;
  }
}
