class Result {
  final String name;
  final int sad;
  final int disgust;
  final int surprise;
  final int angry;
  final int fear;
  final int happy;
  final int neutral;
  final String date;

  Result({
    required this.name,
    required this.sad,
    required this.disgust,
    required this.surprise,
    required this.angry,
    required this.fear,
    required this.happy,
    required this.neutral,
    required this.date,
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      name: json['name'],
      sad: json['sad'],
      disgust: json['disgust'],
      surprise: json['surprise'],
      angry: json['angry'],
      fear: json['fear'],
      happy: json['happy'],
      neutral: json['neutral'],
      date: json['date'],
    );
  }
}
