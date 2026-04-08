class LoginResponse {
  const LoginResponse({
    required this.success,
    required this.statusCode,
    required this.message,
    required this.data,
  });

  final bool success;
  final int statusCode;
  final String message;
  final LoginData data;

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      success: json['success'] == true,
      statusCode: (json['status_code'] as num?)?.toInt() ?? 0,
      message: json['message']?.toString() ?? '',
      data: LoginData.fromJson(
        (json['data'] as Map?)?.cast<String, dynamic>() ??
            <String, dynamic>{},
      ),
    );
  }
}

class LoginData {
  const LoginData({
    required this.user,
    required this.accessToken,
    required this.beaches,
  });

  final AuthUser user;
  final String accessToken;
  final List<Beach> beaches;

  factory LoginData.fromJson(Map<String, dynamic> json) {
    return LoginData(
      user: AuthUser.fromJson(
        (json['user'] as Map?)?.cast<String, dynamic>() ??
            <String, dynamic>{},
      ),
      accessToken: json['accessToken']?.toString() ?? '',
      beaches: (json['beaches'] as List?)
              ?.map((item) =>
                  Beach.fromJson((item as Map).cast<String, dynamic>()))
              .toList() ??
          <Beach>[],
    );
  }
}

class AuthUser {
  const AuthUser({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.avatarUrl,
    required this.walletBalance,
    required this.status,
  });

  final String id;
  final String name;
  final String email;
  final String role;
  final String avatarUrl;
  final String walletBalance;
  final String status;

  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return AuthUser(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      role: json['role']?.toString() ?? '',
      avatarUrl: json['avatarUrl']?.toString() ?? '',
      walletBalance: json['walletBalance']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
    );
  }
}

class Beach {
  const Beach({
    required this.id,
    required this.name,
    required this.slug,
    required this.description,
    required this.address,
    required this.status,
  });

  final String id;
  final String name;
  final String slug;
  final String description;
  final String address;
  final String status;

  factory Beach.fromJson(Map<String, dynamic> json) {
    return Beach(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      slug: json['slug']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
    );
  }
}
