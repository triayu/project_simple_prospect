import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_prospect/app/data/models/model.dart';

class CategoryContactProvider extends StateNotifier<CategoryContactModel> {
  CategoryContactProvider() : super(CategoryContactModel());

  void setCategoryContact(CategoryContactModel data) {
    state = data;
  }
}

final categoryContactProvider = StateNotifierProvider<CategoryContactProvider, CategoryContactModel>((ref) {
  return CategoryContactProvider();
});
