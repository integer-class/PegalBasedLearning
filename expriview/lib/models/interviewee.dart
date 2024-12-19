class Interviewee {
  final int id;
  final String name;
  final String gender;
  final String email;
  final String? cv;
  final String createdAt;
  final String updatedAt;

  Interviewee({
    required this.id,
    required this.name,
    required this.gender,
    required this.email,
    this.cv,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Interviewee.fromJson(Map<String, dynamic> json) {
    return Interviewee(
      id: json['id'],
      name: json['name'],
      gender: json['gender'],
      email: json['email'],
      cv: json['cv'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}