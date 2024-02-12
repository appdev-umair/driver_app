class Lead {
  final String id;
  final String name;
  final List<dynamic> driver; // You might want to define a Driver class if it's structured
  final int items;
  final String pickupLocation;
  final String dropoffLocation;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Lead({
    required this.id,
    required this.name,
    required this.driver,
    required this.items,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Lead.fromJson(Map<String, dynamic> json) {
    return Lead(
      id: json['_id'],
      name: json['name'],
      driver: json['driver'],
      items: json['items'],
      pickupLocation: json['pickupLocation'],
      dropoffLocation: json['dropoffLocation'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }
}
