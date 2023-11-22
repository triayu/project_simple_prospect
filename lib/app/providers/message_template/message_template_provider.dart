import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/data/models/message_template_model.dart';
import 'package:simple_prospect/app/utils/fetch/src/fetch.dart';

import '../../data/api/api.dart';

class MessageTemplateProvider extends StateNotifier<AsyncValue<List<MessageTemplateModel>>> with UseApi {
  final AutoDisposeStateNotifierProviderRef? ref;

  MessageTemplateProvider(this.ref) : super(const AsyncValue.loading()) {
    getMessageTemplate();
  }

  Future getMessageTemplate() async {
    try {
      state = const AsyncValue.loading();

      ResHandler res = await messageTemplateApi.getMessageTemplate();

      logg(res.status);

      if (res.status) {
        List data = res.data ?? [];

        state = AsyncValue.data(data.map((e) => MessageTemplateModel.fromJson(e)).toList());
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

      ResHandler res = await messageTemplateApi.deleteMessageTemplate(id);

      if (res.status) {
        LzToast.show(res.message);
        getMessageTemplate();
      } else {
        LzToast.show(res.message);
      }
    } catch (e, s) {
      Errors.check(e, s);
    }
  }
}

final messageTemplateProvider =
    StateNotifierProvider.autoDispose<MessageTemplateProvider, AsyncValue<List<MessageTemplateModel>>>((ref) {
  return MessageTemplateProvider(ref);
});
