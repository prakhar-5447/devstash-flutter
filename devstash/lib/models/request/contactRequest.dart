class ContactRequest {
  String? userid;
  String? city;
  String? state;
  String? country;
  String? countryCode;
  String? phoneNo;

  ContactRequest(
      {this.userid,
      this.city,
      this.state,
      this.country,
      this.countryCode,
      this.phoneNo});

  Map<String, dynamic> toJson() {
    return {
      'userId': userid,
      'city': city,
      'state': state,
      'country': country,
      'countryCode': countryCode,
      'phoneNo': phoneNo,
    };
  }
}
