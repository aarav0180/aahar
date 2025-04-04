class NGOAgentModel {
  String uid;
  String name;
  String email;
  String phone;
  String assignedNGO;
  int successfulDeliveries;
  double latitude;
  double longitude;
  String profileImageUrl;
  String role;

  NGOAgentModel({
    required this.uid,
    required this.name,
    required this.email,
    this.phone = "Not Provided",
    this.assignedNGO = "Not Assigned",
    this.successfulDeliveries = 0,
    this.latitude = 0.0,
    this.longitude = 0.0,
    this.profileImageUrl = "https://example.com/default_profile_image.png",
    this.role = "NGO Agent",
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phone': phone,
      'assignedNGO': assignedNGO,
      'successfulDeliveries': successfulDeliveries,
      'latitude': latitude,
      'longitude': longitude,
      'profileImageUrl': profileImageUrl,
      'role': role,
    };
  }

  factory NGOAgentModel.fromMap(Map<String, dynamic> map) {
    return NGOAgentModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? 'Anonymous Agent',
      email: map['email'] ?? '',
      phone: map['phone'] ?? 'Not Provided',
      assignedNGO: map['assignedNGO'] ?? 'Not Assigned',
      successfulDeliveries: map['successfulDeliveries'] ?? 0,
      latitude: map['latitude']?.toDouble() ?? 0.0,
      longitude: map['longitude']?.toDouble() ?? 0.0,
      profileImageUrl: map['profileImageUrl'] ?? 'https://example.com/default_profile_image.png',
      role: map['role'] ?? 'NGO Agent',
    );
  }
}