class LoginModel {
  final bool? status;
  final String? message;
  final User? user;
  final String? token;

  LoginModel({
    this.status,
    this.message,
    this.user,
    this.token,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      token: json['token'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'user': user?.toJson(),
      'token': token,
    };
  }
}

class User {
  final int? id;
  final String? fullName;
  final String? email;
  final String? phone;
  final String? address;
  final String? fcmToken;
  final String? accessToken;
  final String? gender;
  final String? provider;
  final String? providerId;
  final String? avatar;
  final int? notificationsEnabled;
  final String? deletedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({
    this.id,
    this.fullName,
    this.email,
    this.phone,
    this.address,
    this.fcmToken,
    this.accessToken,
    this.gender,
    this.provider,
    this.providerId,
    this.avatar,
    this.notificationsEnabled,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int?,
      fullName: json['full_name'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      address: json['address'] as String?,
      fcmToken: json['fcm_token'] as String?,
      accessToken: json['access_token'] as String?,
      gender: json['gender'] as String?,
      provider: json['provider'] as String?,
      providerId: json['provider_id'] as String?,
      avatar: json['avatar'] as String?,
      notificationsEnabled: json['notifications_enabled'] as int?,
      deletedAt: json['deleted_at'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.tryParse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'full_name': fullName,
      'email': email,
      'phone': phone,
      'address': address,
      'fcm_token': fcmToken,
      'access_token': accessToken,
      'gender': gender,
      'provider': provider,
      'provider_id': providerId,
      'avatar': avatar,
      'notifications_enabled': notificationsEnabled,
      'deleted_at': deletedAt,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
