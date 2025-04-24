class ReportPost {
  final String uniqueId;
  final String userId;
  final String reason;
  final String reportId;
  ReportPost({
    required this.uniqueId,
    required this.reportId,
    required this.userId,
    required this.reason,
  });
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'uniqueId': uniqueId,
      'reson': reason,
      'reportId': reportId
    };
  }

  factory ReportPost.fromJson(Map<String, dynamic> json) {
    return ReportPost(
        uniqueId: json['uniqueId'],
        userId: json['userId'],
        reason: json['reason'],
        reportId: json['reportId']);
  }
}
