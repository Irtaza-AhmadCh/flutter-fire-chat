class FireBaseUserModel {

  final String? userName;
  final String? userEmail;
  final String? status;
  final String? fireId;
  final String? profileImage;
  final String? userAppId;
  final String? role;

  // Constructor
  FireBaseUserModel(  {
    this.userEmail,
    required this.role,
    required this.fireId,
    required this.userAppId,
    required this.userName,
    required this.status,
    required this.profileImage,
  });

  // Factory method to create an instance from JSON
  factory FireBaseUserModel.fromJson(Map<String, dynamic> json) {
    return FireBaseUserModel(
      userName: json['userName'] as String,
      userEmail: json['userEmail'] as String,
      status: json['status'] as String,
      profileImage: json['profileImage'] as String,
      fireId: json['fireId'] as String,
      userAppId:json['userAppId'] as String,
      role: json['role'] as String,
    );
  }

  // Method to convert the instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'userEmail': userEmail,
      'userName': userName,
      'status': status,
      'profileImage': profileImage,
      'fireId' : fireId,
      'userAppId' : userAppId,
      'role' : role,
    };
  }

// Optional: Override toString for better debugging

}
