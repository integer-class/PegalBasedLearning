class EmotionResponse {
  final String emotion;
  final double confidence;
  final Map<String, int>? sessionCounts;

  EmotionResponse({
    required this.emotion,
    required this.confidence,
    this.sessionCounts,
  });

  factory EmotionResponse.fromJson(Map<String, dynamic> json) {
    return EmotionResponse(
      emotion: json['emotion'] as String,
      confidence: (json['confidence'] as num).toDouble(),
      sessionCounts: json['current_session_counts'] != null 
          ? Map<String, int>.from(json['current_session_counts'])
          : null,
    );
  }
}