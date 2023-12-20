import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import '../../../data/models/model.dart';

class TutorialView extends ConsumerWidget {
  final TutorialModel tutorial;

  const TutorialView({Key? key, required this.tutorial}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String title = tutorial.title;
    String description = tutorial.description ?? 'No description available';

    return Scaffold(
      appBar: AppBar(
        title: Text(title.ucwords),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: 200, // Set the desired height for the video
            child: InAppWebView(
              initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(
                  transparentBackground: true,
                  supportZoom: false,
                  preferredContentMode: UserPreferredContentMode.MOBILE,
                ),
              ),
              initialUrlRequest: URLRequest(
                url: Uri.parse(tutorial.videoUrl),
              ),
            ),
          ),
          Card(
            margin: const EdgeInsets.all(8.0),
            elevation: 2.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(fontSize: 16),
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
