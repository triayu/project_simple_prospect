import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/constants/color_constants.dart';
import 'package:simple_prospect/app/data/models/message_template_model.dart';
import 'package:simple_prospect/app/modules/home/broadcast/message/add_template_message_view.dart';
import 'package:simple_prospect/app/providers/message_template/message_template_provider.dart';
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
      body: Consumer(builder: (context, ref, _) {
        final asyncData = ref.watch(messageTemplateProvider);

        return asyncData.when(
          data: (data) {
            logg(data.length, color: LogColor.red);

            if (data.isEmpty) {
              return LzNoData(
                  message: 'Opps! No data found',
                  onTap: () => ref.read(messageTemplateProvider.notifier).getMessageTemplate());
            }

            return ListView.separated(
              padding: Ei.sym(h: 20, v: 20),
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                logg(index);

                MessageTemplateModel datas = data[index];
                final gkey = GlobalKey();
                int id = datas.id ?? 0;
                String title = datas.title ?? '';
                // String userFirstName = datas[index].userFirstName ?? '';
                String message = datas.message ?? '';

                return Column(
                  children: [
                    // Template Pesan

                    Container(
                      padding: Ei.only(h: 20, b: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                title,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Spacer(),
                              Icon(
                                Ti.menu2,
                                key: gkey,
                              ).onPressed(() {
                                final options = ['Kirim Pesan', 'Edit', 'Hapus'].options();
                                DropX.show(gkey.context, options: options, onSelect: (p0) {
                                  if (p0.option == 'Kirim Pesan') {
                                    Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => SendMessage(),
                                    ));
                                  }
                                  logg(p0.option);
                                  if (p0.option == 'Edit') {
                                    Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => AddTemplateMessage(
                                        data: datas,
                                      ),
                                    ));
                                  } else if (p0.option == 'Hapus') {
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
                              })
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(
                            message,
                            textAlign: Ta.justify,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 10);
              },
              itemCount: data.length,
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
      }),
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
