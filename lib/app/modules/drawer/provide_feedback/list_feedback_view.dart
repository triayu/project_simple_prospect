import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/constants/color_constants.dart';
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

            return ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                FeedbackModel datas = data[index];

                int id = datas.id ?? 0;
                String title = datas.title ?? '';
                String feedbackMessage = datas.feedbackMessage ?? '';
                dynamic rating = datas.rating;

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
                    title: Text(
                      title,
                      style: TextStyle(
                        color: ColorConstants.textPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    subtitle: Row(
                      children: [
                        Text(
                          'Rating: ',
                          style: TextStyle(
                            color: ColorConstants.textSecondaryColor,
                            fontSize: 12,
                          ),
                        ),
                        // Display the rating as text
                        Text(
                          rating.toString(),
                          style: TextStyle(
                            color: ColorConstants.textSecondaryColor,
                            fontSize: 12,
                          ),
                        ),
                        // Alternatively, you can use a widget to display the rating as stars
                        RatingBarIndicator(
                          rating: rating is double ? rating : 0.0,
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 12.0,
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: ColorConstants.errorColor,
                      ),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Are you sure you want to delete this feedback?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Cancel"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    ref.read(feedbackProvider.notifier).delFeedback(id);
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Delete"),
                                ),
                              ],
                            );
                          },
                        );
                      },
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
            return LzNoData(message: 'Oops! $error');
          },
          loading: () {
            return SizedBox(
              height: 90,
              child: ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.horizontal,
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
