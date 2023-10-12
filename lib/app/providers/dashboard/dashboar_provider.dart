import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/data/local/auth_storage.dart';
import 'package:simple_prospect/app/data/models/model.dart';
import 'package:simple_prospect/app/providers/auth/auth_provider.dart';

final dashboardNotifier = ChangeNotifierProvider((ref) => Dashboard());

class Dashboard with ChangeNotifier {
   User user = User();
  void addEvent(String event) {}

  void getUser() async {
    user = await AuthStorage.user();
    logg(user);
  }
}
