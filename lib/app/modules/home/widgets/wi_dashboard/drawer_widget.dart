import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/data/models/model.dart';
import 'package:simple_prospect/app/modules/drawer/contact/contact_view.dart';
import 'package:simple_prospect/app/modules/drawer/prospect/prospect_view.dart';
import 'package:simple_prospect/app/modules/drawer/provide_feedback/feedback_view.dart';
import 'package:simple_prospect/app/providers/auth/auth_provider.dart';

import '../../../../constants/color_constants.dart';
import '../../../../data/local/auth_storage.dart';
import '../../../drawer/message_template/message_template.dart';
import '../../../drawer/tutorial/list_tutorial.dart';

class WiDrawer extends ConsumerWidget {
  const WiDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(authProvider.notifier);

    User userData = AuthStorage.user();
    return SafeArea(
      child: Drawer(
        width: context.width * 0.5,
        child: Column(
          children: [
            //
            Container(
              margin: Ei.only(t: 30, l: 10),
              width: 250,
              height: 60,
              decoration: BoxDecoration(
                color: ColorConstants.primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LzImage(
                    'poto.jpg',
                    radius: 50,
                    size: 40,
                  ),
                  SizedBox(width: 10),
                  Container(
                    padding: EdgeInsets.only(right: 30),
                    child: Text(
                      '${userData.fullName!.ucwords}',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  List<String> titles = ['Contact', 'Prospect', 'Tutorial', 'Provide Feedback', 'Message Template'];
                  List<IconData> icons = [Ti.addressBook, Ti.user, Ti.brandYoutube, Icons.feedback, Ti.messageCircle];

                  return ListTile(
                    leading: Icon(
                      icons[index],
                      color: ColorConstants.primaryColor,
                    ),
                    title: Text(
                      titles[index],
                      style: TextStyle(fontSize: 16),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      switch (index) {
                        case 0:
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ContactView()));
                          break;
                        case 1:
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ProspectView()));
                          break;
                        case 2:
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ListTutorialView()));
                          break;

                        case 3:
                          Navigator.push(context, MaterialPageRoute(builder: (context) => FeedbackView()));
                          break;
                        case 4:
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MessageView()));
                          break;
                      }
                    },
                  );
                },
              ),
            ),
            InkTouch(
              onTap: () {
                notifier.logOut(context);
              },
              margin: Ei.all(20),
              padding: Ei.only(l: 20),
              radius: BorderRadius.circular(10),
              color: ColorConstants.textSecondaryColor.withOpacity(0.3),
              child: Padding(
                padding: Ei.all(10),
                child: Row(
                  children: [
                    Icon(
                      Icons.exit_to_app,
                      color: ColorConstants.primaryColor,
                    ),
                    SizedBox(width: 10),
                    Text(
                      "LogOut",
                      style: TextStyle(
                        color: ColorConstants.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
