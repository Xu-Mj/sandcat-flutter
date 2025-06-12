// 用户信息模型
class UserInfo {
  final String id;
  final String name;
  final String? avatar;
  final String? signature;
  final String? account;
  final String? region;
  final String? email;
  final String? gender;
  final int? age;

  UserInfo({
    required this.id,
    required this.name,
    this.avatar,
    this.signature,
    this.account,
    this.region,
    this.email,
    this.gender,
    this.age,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['id'] as String,
      name: json['name'] as String,
      avatar: json['avatar'] as String?,
      signature: json['signature'] as String?,
      account: json['account'] as String?,
      region: json['region'] as String?,
      email: json['email'] as String?,
      gender: json['gender'] as String?,
      age: json['age'] as int?,
    );
  }
}
