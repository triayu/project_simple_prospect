import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/data/models/event_model.dart';
import 'package:simple_prospect/app/data/models/task_model.dart';
import 'package:simple_prospect/app/providers/task/task_provider.dart';

import 'package:simple_prospect/app/utils/fetch/fetch.dart';
import '../../data/api/api.dart';

class TaskProvider extends StateNotifier<AsyncValue<List<TaskModel>>> with UseApi {
  final AutoDisposeStateNotifierProviderRef? ref; // if you want to use ref inside this provider

  TaskProvider(this.ref) : super(const AsyncValue.loading()) {
    getTask();
  }

  Future getTask() async {
    try {
      state = const AsyncValue.loading();

      ResHandler res = await taskApi.getTask();

      if (res.status) {
        List data = res.data ?? [];

        state = AsyncValue.data(data.map((e) => TaskModel.fromJson(e)).toList());
      } else {
        LzToast.show(res.message);
      }
    } catch (e, s) {
      Errors.check(e, s);
      state = AsyncValue.data([]);
    }
  }
}

final taskProvider = StateNotifierProvider.autoDispose<TaskProvider, AsyncValue<List<TaskModel>>>((ref) {
  return TaskProvider(
    ref,
  );
});
