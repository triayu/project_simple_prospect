import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/constants/color_constants.dart';

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
                      Positioned(
                          top: -70,
                          left: 30,
                          right: 20,
                          bottom: 50,
                          child: Container(
                            margin: Ei.only(v: 30),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(color: ColorConstants.secondaryColor, width: 2)),
                            child: LzImage(
                              "poto.jpg",
                              radius: 50,
                            ),
                          )),

                      // Informasi profil
                      Container(
                        padding: Ei.only(t: 10),
                        color: ColorConstants.secondaryColor,
                        width: double.infinity,
                        height: 600,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                // Tambahkan aksi
                              },
                              child: Text('Edit Profile'),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 40,
                              width: double.infinity,
                              color: Color.fromARGB(108, 235, 235, 235),
                            ),
                            Text(
                              'Nama Pengguna',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            Row(
                              children: [
                                Text(
                                  'Email: user@example.com',
                                  style: TextStyle(fontSize: 16),
                                ),
                                // Icon(Ti.arrowNarrowRight)
                              ],
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Nomor Telepon: +1234567890',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
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
