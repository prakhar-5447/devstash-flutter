class EducationRequest {
  String? id;
  String? collegeorSchoolName;
  String? educationLevel;
  String? fromYear;
  String? toYear;
  String? subject;

  EducationRequest(
      {this.id,
      this.collegeorSchoolName,
      this.subject,
      this.fromYear,
      this.toYear,
      this.educationLevel});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'level': educationLevel,
      'subject': subject,
      'fromYear': fromYear,
      'toYear': toYear,
      'schoolname': collegeorSchoolName
    };
  }
}
