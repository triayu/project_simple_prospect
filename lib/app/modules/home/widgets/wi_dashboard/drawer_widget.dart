import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/modules/isi_drawer/prospect/prospect.dart';
import 'package:simple_prospect/app/modules/isi_drawer/provide_feedback/feedback_view.dart';

import '../../../../constants/color_constants.dart';
import '../../../isi_drawer/tutorial/tutorial_view.dart';

class WiDrawer extends StatelessWidget {
  const WiDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        width: context.width * 0.8,
        child: Col(
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
                      'Tri Ayu Novitasari',
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
                itemCount: 6,
                itemBuilder: (context, index) {
                  List<String> titles = [
                    'Prospect',
                    'Tutorial',
                    'Subscription',
                    'Refferals',
                    'Provide Feedback',
                    'Message Template'
                  ];
                  List<IconData> icons = [
                    Ti.usersGroup,
                    Ti.brandYoutube,
                    Icons.follow_the_signs,
                    Icons.code,
                    Icons.feedback,
                    Ti.messageCircle
                  ];

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
                      switch (index) {
                        case 0:
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ProspectView()));
                          break;
                        case 1:
                          Navigator.push(context, MaterialPageRoute(builder: (context) => TutorialView()));
                          break;
                        case 2:
                          // Navigasi ke subscription
                          break;
                        case 3:
                          // Navigasi ke refferals
                          break;
                        case 4:
                          Navigator.push(context, MaterialPageRoute(builder: (context) => FeedbackView()));
                          break;
                        case 5:
                          // Navigasi ke message
                          break;
                      }
                    },
                  );
                },
              ),
            ),
            Container(
              height: 70,
              width: 170,
              child: InkTouch(
                margin: Ei.all(20),
                padding: Ei.only(l: 20),
                radius: BorderRadius.circular(10),
                color: ColorConstants.textSecondaryColor,

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
                // onPressed: () {

                // },
              ),
            )
          ],
        ),
      ),
    );
  }
}
