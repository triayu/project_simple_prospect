import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

class FeedbackView extends ConsumerWidget {
  const FeedbackView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Col(
      children: [
        Col(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: Ei.only(t: 80, l: 40),
              child: LzImage(
                'feedback.png',
                height: 300,
                fit: BoxFit.fitHeight,
              ),
            ),
            Center(
              child: Container(
                height: 200,
                width: 300,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(15)),
                child: Text(
                  'Konten dalam kotak ini',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
