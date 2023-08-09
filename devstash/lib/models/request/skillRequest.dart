class SkillRequest {
  String? skill;

  SkillRequest({
    this.skill,
  });

  Map<String, dynamic> toJson() {
    return {'skill': skill};
  }
}
