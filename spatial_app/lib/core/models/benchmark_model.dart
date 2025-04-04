class BenchmarkResult {
  final double speed;         // Mbps
  final int latency;          // ms
  final int difficulty;       // 1-5 scale
  final int security;         // 1-5 scale
  final String reason;        // Explanation for the result

  BenchmarkResult({
    required this.speed,
    required this.latency,
    required this.difficulty,
    required this.security,
    required this.reason,
  });

  // Convert to JSON for storage
  Map<String, dynamic> toJson() => {
    'speed': speed,
    'latency': latency,
    'difficulty': difficulty,
    'security': security,
    'reason': reason,
  };

  // Convert from JSON
  factory BenchmarkResult.fromJson(Map<String, dynamic> json) {
    return BenchmarkResult(
      speed: json['speed'],
      latency: json['latency'],
      difficulty: json['difficulty'],
      security: json['security'],
      reason: json['reason'],
    );
  }
}
