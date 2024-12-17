class Course {
  final String title, email;
  final bool isMale;
  final int happy, disgust, angry, fear, neutral, sad, surprise;

  Course({
    required this.title,
    this.email = "examplemail@gmail.com",
    this.isMale = false,
    this.happy=0, this.disgust=0, this.angry=0, this.fear=0, this.neutral=0, this.sad=0, this.surprise=0
  });
}

List<Course> courses = [
  Course(title: "Jk", isMale: false, email: 'jk@mail.co'),
  Course(title: "MS", isMale: true, email: 'ms@mail.co'),
  Course(title: "AW", isMale: false, email: 'aw@mail.co'),
];

// We need it later
List<Course> recentCourses = [
  Course(
    title: "Riko Saputra",
    happy: 10,
    disgust: 15,
    angry: 20,
    fear: 29,
    neutral: 39,
    sad: 14,
    surprise: 10
    ),
  Course(
    title: "Maya Sari",
    happy: 21,
    disgust: 24,
    angry: 31,
    fear: 19,
    neutral: 9,
    sad: 32,
    surprise: 8
  ),
];
