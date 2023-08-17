class UserProfile {
  String name;
  String username;
  String description;
  // String address;
  String email;
  // List<String> skills;
  // List<Map<String, String?>> socials; // Updated to allow nullable strings
  // List<Map<String, String?>> education; // Updated to allow nullable strings

  UserProfile({
    required this.name,
    required this.username,
    required this.description,
    // required this.address,
    required this.email,
    // required this.skills,
    // required this.socials,
    // required this.education,
  });

  // Create a method to convert UserProfile to a Map
  Map<String, dynamic> toJson() {
    // List<Map<String, String?>> socialsList = socials
    //     .map((entry) => {
    //           'type': entry['type'],
    //           'url': entry['url'],
    //         })
    //     .toList();

    // List<Map<String, String?>> educationList = education
    //     .map((entry) => {
    //           'level': entry['level'],
    //           'schoolName': entry['schoolName'],
    //           'subject': entry['subject'],
    //           'fromYear': entry['fromYear'],
    //           'toYear': entry['toYear'],
    //         })
    //     .toList();

    return {
      'name': name,
      'username': username,
      'description': description,
      // 'address': address,
      'email': email,
      // 'skills': skills,
      // 'socials': socialsList,
      // 'education': educationList,
    };
  }
}
