import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../constants/color_constants.dart';
import '../../../data/models/model.dart';

class TutorialView extends ConsumerWidget {
  final TutorialModel tutorial;

  const TutorialView({Key? key, required this.tutorial}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tutorial'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: Ei.sym(v: 5),
          ),
          Container(
            width: 340,
            height: 150,
            // margin: Ei.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: WebView(
              initialUrl: tutorial.videoUrl,
              javascriptMode: JavascriptMode.unrestricted,
            ),
          ),
          Container(
            width: double.infinity,
            height: 220,
            padding: Ei.only(t: 5),
            margin: Ei.sym(h: 10),
            decoration: BoxDecoration(
              color: ColorConstants.secondaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 1,
                  blurRadius: 1,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Container(
              padding: Ei.only(b: 10),
              margin: Ei.only(l: 20, r: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    ' ${tutorial.title}',
                    style: TextStyle(

                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                 
                      color: ColorConstants.textPrimaryColor,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    ' ${tutorial.description}',
                    style: TextStyle(
                      fontSize: 14,
                      color: ColorConstants.textPrimaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
