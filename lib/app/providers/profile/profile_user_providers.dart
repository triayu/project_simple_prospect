import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProfile {
  final String name;
  final String imageUrl;

  UserProfile(this.name, this.imageUrl);
}

final userProfileProvider = Provider<UserProfile>((ref) {
  return UserProfile("Nama Pengguna", "URL_GAMBAR_PROFIL");
});
