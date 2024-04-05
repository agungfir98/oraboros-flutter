// ignore_for_file: non_constant_identifier_names

class CreateProfileMapKey {
  static String display_name = "display_name";
  static String email = "email";
  static String avatar = "avatar";
}

class ProfileDTO {
  late String id;
  late String email;
  late String display_name;
  late String avatar;

  ProfileDTO({
    required this.email,
    required this.display_name,
    required this.id,
    required this.avatar,
  });

  factory ProfileDTO.fromJson(Map<String, dynamic> jsonData) {
    return ProfileDTO(
      email: jsonData['email'],
      display_name: jsonData['display_name'],
      id: jsonData['id'],
      avatar: jsonData['avatar'],
    );
  }
}

class CreateProfileDTO {
  late String display_name;
  late String email;
  late String avatar;

  CreateProfileDTO({
    required this.email,
    required this.display_name,
    required this.avatar,
  });
}
