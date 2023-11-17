import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/constants/color_constants.dart';

class FeedbackView extends ConsumerWidget {
  const FeedbackView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  padding: Ei.only(t: 50, l: 40),
                  child: LzImage(
                    'feedback.png',
                    height: 300,
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Center(
                  child: Container(
                    height: 230,
                    width: 300,
                    padding: Ei.only(b: 20, h: 20),
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
                                padding: Ei.only(b: 5, h: 3, t: 20),
                                child: Icon(
                                  Ti.starFilled,
                                  color: Colors.yellow,
                                  size: 28,
                                ),
                              );
                            }),
                          ),
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          decoration: InputDecoration(
                            hintText: 'Description',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            //
                          },
                          child: Text('Submit'),
                          style: ElevatedButton.styleFrom(backgroundColor: ColorConstants.primaryColor),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
