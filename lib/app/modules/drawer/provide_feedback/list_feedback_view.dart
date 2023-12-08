import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart' hide Gfont, gfont;
import 'package:simple_prospect/app/constants/color_constants.dart';
import 'package:simple_prospect/app/core/text_theme.dart';
import 'package:simple_prospect/app/data/models/feedback_model.dart';
import 'package:simple_prospect/app/modules/drawer/provide_feedback/form_feedback_view.dart';
import 'package:simple_prospect/app/providers/feedback/feedback_provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

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
                message: 'Oops! No data found',
                onTap: () => ref.read(feedbackProvider.notifier).getFeedback(),
              );
            }

            return Refreshtor(
              onRefresh: () async {
                await ref.read(feedbackProvider.notifier).getFeedback();
              },
              child: ListView.separated(
                padding: Ei.sym(v: 20, h: 20),
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  FeedbackModel datas = data[index];

                  int id = datas.id ?? 0;
                  String title = datas.title ?? '';
                  String feedbackMessage = datas.feedbackMessage ?? '';
                  double rating = datas.rating != null ? datas.rating!.toDouble() : 0;

                  return Container(
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
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
                      minVerticalPadding: 10,
                      dense: true,
                      horizontalTitleGap: 10,
                      leading: Icon(
                        Icons.feedback,
                        color: ColorConstants.primaryColor,
                        size: 30,
                      ),
                      title: Text(title,
                          style: Gfont.autoSizeText(context, FontSizeManager.getSublineFontSize(),
                              fontWeight: FontWeight.bold)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text('Rating: ',
                                  style: Gfont.autoSizeText(context, FontSizeManager.getTittleFontSize(),
                                      color: Colors.grey)),
                              // Display the rating as text

                              // Alternatively, you can use a widget to display the rating as stars
                              RatingBarIndicator(
                                rating: rating,
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                itemCount: 5,
                                itemSize: 16,
                              ),
                            ],
                          ),
                          Text(
                            feedbackMessage,
                            style: Gfont.autoSizeText(context, FontSizeManager.getBodyFontSize()),
                          )
                        ],
                      ),
                      trailing: InkTouch(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return LzConfirm(
                                title: 'Konfirmasi Penghapusan Data',
                                message: 'Apakah anda yakin ingin menghapus feedback ini ?',
                                onConfirm: () {
                                  ref.read(feedbackProvider.notifier).delFeedback(id);
                                },
                              );
                            },
                          );
                        },
                        color: Colors.white,
                        radius: Br.circle,
                        elevation: 2,
                        padding: Ei.all(10),
                        child: Icon(
                          Icons.delete,
                          color: ColorConstants.errorColor,
                        ),
                      ),
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
            return LzNoData(message: 'Oops! $error');
          },
          loading: () {
            return ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Skeleton(radius: 10, margin: Ei.all(10), size: [100, 50]);
              },
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => FeedbackView(),
          ));
        },
        child: Icon(Icons.add),
        backgroundColor: ColorConstants.primaryColor,
      ),
    );
  }
}
