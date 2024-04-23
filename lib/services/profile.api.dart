// ignore_for_file: non_constant_identifier_names

import 'package:oraboros/DTO/profile.dto.dart';
import 'package:oraboros/main.dart';

class Selector {
  late Map<String, bool?> _map;

  Selector({required bool userId, bool? email, bool? display_name}) {
    _map = {
      'userId': userId,
      'email': email,
      'display_name': display_name,
    };
  }
}

Future<List<Map<String, dynamic>>> getProfiles(Selector selector) async {
  List<String> selected = [];
  selector._map.forEach(
    (key, value) {
      if (value != null) {
        selected.add(key);
      }
    },
  );

  return supabase
      .from('Profile')
      .select(selected.join(", "))
      .then((value) => value);
}

class GetProfileByEmailDTO {
  late String id;
  GetProfileByEmailDTO({required this.id});
}

Future<Map<String, dynamic>> getProfileById(
    GetProfileByEmailDTO getProfileDTO) async {
  return await supabase
      .from("profiles")
      .select()
      .eq(
        "id",
        getProfileDTO.id,
      )
      .single()
      .then(
    (value) {
      return value;
    },
  );
}

createProfile(CreateProfileDTO createProfileDTO) {
  Map<String, String> newProfile = {
    "email": createProfileDTO.email,
    "display_name": createProfileDTO.display_name,
    "avatar": createProfileDTO.avatar
  };

  return supabase.from('Profile').insert(newProfile);
}
