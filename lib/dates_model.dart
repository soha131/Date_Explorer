
class DatePrediction {
  final String? dateVariety;
  final String? cultivationLocation;
  final String? description;

  DatePrediction({
    required this.dateVariety,
    required this.cultivationLocation,
    required this.description,
  });

  factory DatePrediction.fromJson(Map<String, dynamic> json) {
    return DatePrediction(
      dateVariety: json['date_variety'] ?? 'Unknown',
      cultivationLocation: json['cultivation_location'] ?? 'Location not found',
      description: json['description'] ?? 'No description available',
    );
  }
}
