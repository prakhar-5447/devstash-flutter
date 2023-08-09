class SocialsRequest {
  String? twitter;
  String? instagram;
  String? linkedin;
  String? github;
  String? other;

  SocialsRequest(
      {this.twitter, this.instagram, this.linkedin, this.github, this.other});

  @override
  String toString() {
    return 'SocialsRequestt{ twitter: $twitter, instagram: $instagram, github: $github, linkedin: $linkedin, other : $other}';
  }

  Map<String, dynamic> toJson() {
    return {
      'twitter': twitter,
      'linkedin': linkedin,
      'github': github,
      'instagram': instagram,
      'other': other,
    };
  }
}
