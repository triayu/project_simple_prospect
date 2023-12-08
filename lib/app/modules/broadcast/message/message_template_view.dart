import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart' hide Gfont, gfont;
import '../../../constants/color_constants.dart';
import '../../../core/text_theme.dart';
import '../../../data/models/message_template_model.dart';
import '../../../providers/message_template/message_template_provider.dart';
import 'add_template_message_view.dart';
import 'send_message_view.dart';

class MessageTemplate extends ConsumerWidget {
  const MessageTemplate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesan Whatasapp'),
        centerTitle: true,
      ),
      body: Consumer(
        builder: (context, ref, _) {
          final asyncData = ref.watch(messageTemplateProvider);

          return asyncData.when(
            data: (data) {
              if (data.isEmpty) {
                return LzNoData(
                    message: 'Opps! No data found',
                    onTap: () => ref.read(messageTemplateProvider.notifier).getMessageTemplate());
              }

              return Refreshtor(
                onRefresh: () => ref.read(messageTemplateProvider.notifier).getMessageTemplate(),
                child: ListView.separated(
                  padding: Ei.only(t: 10, h: 10, b: 50),
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final key = GlobalKey();

                    MessageTemplateModel datas = data[index];
                    int id = datas.id ?? 0;
                    String tittle = datas.title ?? '';
                    String message = datas.message ?? '';

                    return InkTouch(
                      elevation: 1,
                      key: key,
                      color: Colors.white,
                      onTap: () {
                        final options = ['Kirim Pesan', 'Edit', 'Hapus'].options(icons: [Ti.send, Ti.edit, Ti.trash]);
                        DropX.show(key.currentContext, options: options, onSelect: (val) {
                          if (val.index == 0) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => SendMessage(message: datas),
                              ),
                            );
                          }

                          if (val.index == 1) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => AddTemplateMessage(
                                  data: datas,
                                ),
                              ),
                            );
                          }

                          if (val.index == 2) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return LzConfirm(
                                    title: "Apakah Anda Yakin Untuk Menghapus Data Ini?",
                                    titleSize: 15,
                                    onConfirm: () {
                                      ref.read(messageTemplateProvider.notifier).delMessage(id);
                                    },
                                  );
                                });
                          }
                        });
                      },
                      padding: Ei.all(5),
                      child: ListTile(
                        dense: true,
                        minLeadingWidth: 0,
                        title: Text(
                          tittle.ucwords,
                          style: Gfont.autoSizeText(context, FontSizeManager.getBodyFontSize()),
                          maxLines: 3,
                        ),
                        subtitle:
                            Text(message, style: Gfont.autoSizeText(context, FontSizeManager.getCaptionFontSize())),
                        trailing: Icon(Icons.more_vert, color: ColorConstants.primaryColor),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 10);
                  },
                  itemCount: data.length,
                ),
              );
            },
            error: (error, _) {
              return LzNoData(message: 'Opps! $error');
            },
            loading: () {
              return SizedBox(
                height: 90,
                child: ListView.builder(
                  itemCount: 10,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Skeleton(radius: 10, margin: Ei.all(10), size: [100, 50]);
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Ti.plus),
          backgroundColor: ColorConstants.primaryColor,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddTemplateMessage(),
              ),
            );
          }),
    );
  }
}
