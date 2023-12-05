import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/constants/color_constants.dart';

import '../../../providers/feedback/feedback_provider.dart';

class FeedbackView extends ConsumerWidget {
  const FeedbackView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(feedbackProvider.notifier);

    double rating = 3;
    provider.forms['rating']?.controller.text = rating.toStringAsFixed(0);
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: Ei.only(t: 10, l: 40),
              child: LzImage(
                'feedback.png',
                height: 200,
                fit: BoxFit.fitHeight,
              ),
            ),
            Center(
              child: Container(
                height: 350,
                width: 300,
                padding: Ei.sym(v: 20, h: 10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: ColorConstants.primaryColor,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RatingBar.builder(
                      initialRating: rating,
                      minRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: false,
                      itemCount: 5,
                      itemSize: 30,
                      itemPadding: Ei.sym(h: 4),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (newRating) {
                        rating = newRating;
                        provider.forms['rating']?.controller.text = rating.toStringAsFixed(0);
                      },
                    ),
                    SizedBox(height: 10),
                    LzForm.input(
                      label: 'Title',
                      hint: 'Enter your title',
                      model: provider.forms['title'],
                    ),
                    LzForm.input(
                      label: 'Feedback Message',
                      hint: 'Enter your message',
                      model: provider.forms['feedback_message'],
                    ),
                    // SizedBox(height: 25),
                    ElevatedButton(
                      onPressed: () {
                        if (rating < 1 || rating > 5) {
                          print('Error: Rating must be between 1 and 5');
                        } else {
                          provider.postFeedback(context);
                        }
                      },
                      child: Text('Submit'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConstants.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
