class emojies {
  String? slug;
  String? character;
  String? unicodeName;
  String? codePoint;
  String? group;
  String? subGroup;

  emojies(
      {this.slug,
      this.character,
      this.unicodeName,
      this.codePoint,
      this.group,
      this.subGroup});

  emojies.fromJson(Map<String, dynamic> json) {
    slug = json['slug'];
    character = json['character'];
    unicodeName = json['unicodeName'];
    codePoint = json['codePoint'];
    group = json['group'];
    subGroup = json['subGroup'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['slug'] = this.slug;
    data['character'] = this.character;
    data['unicodeName'] = this.unicodeName;
    data['codePoint'] = this.codePoint;
    data['group'] = this.group;
    data['subGroup'] = this.subGroup;
    return data;
  }
}
