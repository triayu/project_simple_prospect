import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/constants/color_constants.dart';
import 'package:simple_prospect/app/data/models/feedback_model.dart';
import 'package:simple_prospect/app/modules/drawer/provide_feedback/form_feedback_view.dart';
import 'package:simple_prospect/app/providers/feedback/feedback_provider.dart';

class ListFeedbackView extends ConsumerWidget {
  const ListFeedbackView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback'),
        centerTitle: true,
      ),
      body: Consumer(builder: (context, ref, _) {
        final asyncData = ref.watch(feedbackProvider);

        return asyncData.when(
          data: (data) {
            if (data.isEmpty) {
              return LzNoData(
                  message: 'Opps! No data found', onTap: () => ref.read(feedbackProvider.notifier).getFeedback());
            }

            return ListView.separated(
              padding: Ei.sym(h: 10, v: 20),
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                FeedbackModel datas = data[index];

                int id = datas.id ?? 0;
                String title = datas.title ?? '';
                String feedbackMessage = datas.feedbackMessage ?? '';

                return Container(
                  padding: Ei.only(v: 10),
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: ListTile(
                    dense: true,
                    tileColor: Colors.white,
                    style: ListTileStyle.list,
                    title: Text(
                      title,
                      style: TextStyle(
                        color: ColorConstants.textPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    subtitle: Text(
                      feedbackMessage,
                      style: TextStyle(
                        color: ColorConstants.textSecondaryColor,
                        fontSize: 12,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          child: IconButton(
                            icon: Icon(
                              Ti.trash,
                              color: ColorConstants.errorColor,
                              size: 20,
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return LzConfirm(
                                      title: "Apakah Anda Yakin Untuk Menghapus Data Ini?",
                                      titleSize: 15,
                                      onConfirm: () {
                                        logg(id);
                                        ref.read(feedbackProvider.notifier).delFeedback(id);
                                      },
                                    );
                                  });
                            },
                          ),
                        ),
                    
                      ],
                    ),
                  ),
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
      floatingActionButton: Poslign(
        alignment: Alignment.bottomRight,
        child: InkTouch(
          padding: Ei.all(10),
          margin: Ei.all(10),
          radius: Br.circle,
          color: ColorConstants.primaryColor,
          child: Icon(
            Ti.plus,
            color: Colors.white,
            size: 40,
          ),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => FeedbackView(),
            ));
          },
        ),
      ),
    );
  }
}
