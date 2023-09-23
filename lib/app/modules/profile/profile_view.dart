import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/constants/color_constants.dart';
import 'package:simple_prospect/app/modules/home/event_view.dart';
import 'package:simple_prospect/app/modules/home/task_view.dart';
import 'package:simple_prospect/app/modules/profile/edit_profile_view.dart';

import '../../widgets/custom_appbar.dart';

class ProfileView extends ConsumerWidget {
  ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        children: [
          CustomAppBar(
            backgroundColor: ColorConstants.primaryColor,
            title: 'Profile',
            canBack: true,
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(Icons.notifications, color: ColorConstants.secondaryColor),
                onPressed: () {
                  // Tambahkan aksi
                },
              ),
            ],
          ),
          Positioned(
            top: 80,
            left: 0,
            right: 0,
            bottom: 0,
            child: SingleChildScrollView(
              child: Col(
                children: [
                  Column(
                    children: [
                      Container(
                        margin: Ei.only(t: 20),
                        child: Column(
                          children: [
                            LzImage(
                              "poto.jpg",
                              size: 150,
                              radius: 100,
                            ),
                            SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfileView()));
                              },
                              child: Text(
                                'Edit Profile',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Informasi profil
                      Container(
                        margin: Ei.only(t: 30),
                        padding: Ei.only(t: 20),
                        decoration: BoxDecoration(
                          color: ColorConstants.secondaryColor,
                          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        width: double.infinity,
                        height: 500,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Tri Ayu Novitasari',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              padding: Ei.sym(h: 10, v: 10),
                              child: Text(
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. ',
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Container(
                              margin: Ei.only(t: 10),
                              height: 40,
                              width: double.infinity,
                              color: ColorConstants.textSecondaryColor.withOpacity(0.5),
                            ),
                            SizedBox(height: 8),
                            InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => TaskView()));
                              },
                              child: Row(
                                children: [
                                  Container(
                                    padding: Ei.only(t: 10, l: 10),
                                    child: Text(
                                      'My Task',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(Icons.chevron_right,
                                      size: 20), // Ganti "Ti.chevronRight" dengan "Icons.chevron_right"
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => EventView()));
                              },
                              child: Row(
                                children: [
                                  Container(
                                    padding: Ei.only(t: 10, l: 10),
                                    child: Text(
                                      'Event',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(Ti.chevronRight, size: 20),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Container(
                                  padding: Ei.only(t: 10, l: 10),
                                  child: Text(
                                    'Code Referal',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                Spacer(),
                                Icon(Ti.chevronRight, size: 20),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
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
