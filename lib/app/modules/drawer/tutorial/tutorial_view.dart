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
    String tittle = tutorial.title;
    return Scaffold(
      appBar: AppBar(
        title: Text(tittle.ucwords),
        centerTitle: true,
      ),
      body: InAppWebView(
        initialOptions: InAppWebViewGroupOptions(
            crossPlatform: InAppWebViewOptions(
                transparentBackground: true,
                supportZoom: false,
                preferredContentMode: UserPreferredContentMode.MOBILE)),
        initialUrlRequest: URLRequest(
          url: Uri.parse(tutorial.videoUrl),
        ),
      ),
    );
  }
}
