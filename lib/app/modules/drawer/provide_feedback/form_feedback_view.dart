import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/constants/color_constants.dart';
import 'package:simple_prospect/app/providers/feedback/feedback_post_provider.dart';

class FeedbackView extends ConsumerWidget {
  const FeedbackView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(FeedbackPostProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: Ei.only(t: 20, l: 40),
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
                padding: Ei.sym(h: 20),
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
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          return Container(
                            padding: Ei.only(b: 5, r: 3, t: 10),
                            child: Icon(
                              Ti.starFilled,
                              color: Colors.yellow,
                              size: 25,
                            ),
                          );
                        }),
                      ),
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
                    SizedBox(height: 25),
                    ElevatedButton(
                      onPressed: () {
                        provider.postFeedback(context);
                      },
                      child: Text('Submit'),
                      style: ElevatedButton.styleFrom(backgroundColor: ColorConstants.primaryColor),
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
