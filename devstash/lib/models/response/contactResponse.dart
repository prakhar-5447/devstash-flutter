class ContactResponse {
  String? id;
  String? userid;
  String? city;
  String? state;
  String? country;
  String? countryCode;
  String? phoneNo;

  ContactResponse({
    this.id,
    this.userid,
    this.city,
    this.state,
    this.country,
    this.countryCode,
    this.phoneNo,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userid': userid,
      'city': city,
      'state': state,
      'country': country,
      'countryCode': countryCode,
      'phoneNo': phoneNo,
    };
  }
}
