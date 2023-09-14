import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';

import '../../../../constants/color_constants.dart';

class WiDrawer extends StatelessWidget {
  const WiDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        width: context.width * 0.8,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 30),
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
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  List<String> titles = [
                    'Tutorial',
                    'Subscription',
                    'Refferals',
                    'Provide Feedback',
                    'Message Template'
                  ];
                  List<IconData> icons = [
                    Icons.video_label,
                    Icons.follow_the_signs,
                    Icons.code,
                    Icons.feedback,
                    Icons.message
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
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => DashBoardView()));
                          break;
                        case 1:
                          // Navigasi ke halaman Prospect Group
                          break;
                        case 2:
                          // Navigasi ke halaman Rating
                          break;
                        case 3:
                          // Navigasi ke halaman Support/Feedbacks
                          break;
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
