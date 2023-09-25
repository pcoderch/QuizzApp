class RankingStat {
  String username;
  int score;
  int avatarId;

  RankingStat({
    required this.username,
    required this.score,
    required this.avatarId,
  });

  factory RankingStat.fromJson(Map<String, dynamic> json) {
    return RankingStat(
      username: json['username'] as String,
      score: json['score'] as int,
      avatarId: json['avatarId'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'score': score,
      'avatarId': avatarId,
    };
  }

  String getUsername() {
    return username;
  }

  int getScore() {
    return score;
  }

  int getAvatarId() {
    return avatarId;
  }

  void setUsername(String username) {
    this.username = username;
  }

  void setScore(int score) {
    this.score = score;
  }

  void setAvatarId(int avatarId) {
    this.avatarId = avatarId;
  }
}