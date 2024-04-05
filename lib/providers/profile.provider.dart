// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:oraboros/DTO/profile.dto.dart';

class ProfileProvider extends ChangeNotifier {
  static const String id = 'id';
  static const String email = 'email';
  static const String display_name = 'display_name';
  static const String avatar = 'avatar';

  late Map<String, dynamic> _profile = {};

  Map<String, dynamic> get profile => _profile;

  void setProfile(ProfileDTO profileDTO) {
    _profile = {
      id: profileDTO.id,
      email: profileDTO.email,
      display_name: profileDTO.display_name,
      avatar: profileDTO.avatar,
    };

    notifyListeners();
  }
}
