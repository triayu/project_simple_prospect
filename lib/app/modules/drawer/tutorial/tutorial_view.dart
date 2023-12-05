import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
          Expanded(
            child: InAppWebView(
              initialUrlRequest: URLRequest(url: Uri.parse(tutorial.videoUrl)),
              initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(
                  mediaPlaybackRequiresUserGesture: false,
                  useOnDownloadStart: true,
                ),
              ),
              onWebViewCreated: (controller) {
                // Add your WebView controller logic here
              },
              onCreateWindow: (controller, createWindowRequest) async {
                // Add your logic for creating a new window (e.g., handling full-screen video)
                return true;
              },
            ),
          ),
          Container(
            width: double.infinity,
            height: 220,
            padding: EdgeInsets.only(top: 5),
            margin: EdgeInsets.symmetric(horizontal: 10),
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
        ],
      ),
    );
  }
}
