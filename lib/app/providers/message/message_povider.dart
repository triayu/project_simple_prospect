import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/utils/fetch/src/fetch.dart';

import '../../data/api/api.dart';
import '../../data/models/message_model.dart';

class MessageProvider extends StateNotifier<AsyncValue<List<MessageModel>>> with UseApi {
  final AutoDisposeStateNotifierProviderRef? ref;

  MessageProvider(this.ref) : super(const AsyncValue.loading()) {
    getMessage();
  }

  Future getMessage() async {
    try {
      state = const AsyncValue.loading();

      ResHandler res = await messageApi.getMessage();

      logg(res.status);

      if (res.status) {
        List data = res.data ?? [];

        state = AsyncValue.data(data.map((e) => MessageModel.fromJson(e)).toList());

        logg(state, color: LogColor.red);
      } else {
        LzToast.show(res.message);
      }
    } catch (e, s) {
      Errors.check(e, s);
      state = AsyncValue.data([]);
    }
  }

  // Variable For LzForm
  final formstart = LzForm.make(['date']);

  // Delete Message
  // =====================================
  Future delMessage(int id) async {
    try {
      state = const AsyncValue.loading();

      ResHandler res = await messageApi.deleteMessage(id);

      if (res.status) {
        LzToast.show(res.message);
        getMessage();
      } else {
        LzToast.show(res.message);
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}

final messageProvider =
    StateNotifierProvider.autoDispose<MessageProvider, AsyncValue<List<MessageModel>>>((ref) {
  return MessageProvider(ref);
});
