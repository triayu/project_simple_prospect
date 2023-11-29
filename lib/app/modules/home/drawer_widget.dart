import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/data/models/model.dart';
import 'package:simple_prospect/app/modules/drawer/contact/contact_view.dart';
import 'package:simple_prospect/app/modules/drawer/prospect/prospect_view.dart';
import 'package:simple_prospect/app/modules/drawer/provide_feedback/list_feedback_view.dart';
import 'package:simple_prospect/app/modules/home/broadcast/message/message_template_view.dart';
import 'package:simple_prospect/app/modules/drawer/contact/phonebook_view.dart';
import 'package:simple_prospect/app/providers/auth/auth_provider.dart';

import '../../constants/color_constants.dart';
import '../../data/local/auth_storage.dart';
import '../drawer/tutorial/list_tutorial.dart';

class WiDrawer extends ConsumerWidget {
  const WiDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(authProvider.notifier);

    User userData = AuthStorage.user();
    return SafeArea(
      child: Drawer(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(color: ColorConstants.secondaryColor),
          child: Column(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(
                  '${userData.fullName!.ucwords}',
                  style: TextStyle(fontSize: 18, color: ColorConstants.secondaryColor, fontWeight: FontWeight.bold),
                ),
                accountEmail: Text(
                  '${userData.email}',
                  style: TextStyle(color: ColorConstants.secondaryColor, fontSize: 16),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/poto.jpg'),
                ),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [ColorConstants.primaryColor, ColorConstants.secondaryColor],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      List<String> titles = ['Contact', 'Prospect', 'Tutorial', 'Provide Feedback', 'Message Template'];
                      List<IconData> icons = [
                        Ti.addressBook,
                        Ti.user,
                        Ti.brandYoutube,
                        Icons.feedback,
                        Ti.messageCircle
                      ];

                      return Card(
                        elevation: 0.3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          contentPadding: Ei.sym(v: 2, h: 16),
                          leading: Icon(
                            icons[index],
                            color: ColorConstants.primaryColor,
                          ),
                          title: Text(
                            titles[index],
                            style: TextStyle(fontSize: 16, color: ColorConstants.primaryColor),
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
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ListFeedbackView()));
                                break;
                              case 4:
                                Navigator.push(context, MaterialPageRoute(builder: (context) => MessageTemplate()));
                                break;
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
              Container(
                height: 80,
                child: InkTouch(
                  onTap: () {
                    notifier.logOut(context);
                  },
                  margin: Ei.all(20),
                  padding: Ei.only(l: 20),
                  radius: BorderRadius.circular(10),
                  color: ColorConstants.primaryColor,
                  child: Row(
                    children: [
                      Icon(
                        Icons.exit_to_app,
                        color: ColorConstants.secondaryColor,
                      ),
                      SizedBox(width: 10),
                      Text(
                        "LogOut",
                        style: TextStyle(
                          color: ColorConstants.secondaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
