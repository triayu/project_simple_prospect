import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/constants/color_constants.dart';

import '../../widgets/custom_appbar.dart';

class EditProfileView extends ConsumerWidget {
  EditProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        children: [
          CustomAppBar(
            backgroundColor: ColorConstants.primaryColor,
            title: 'Edit Profile',
            canBack: true,
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(Ti.bellFilled, color: ColorConstants.secondaryColor),
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
              child: Column(
                children: [
                  Column(
                    children: [
                      Container(
                        margin: Ei.only(t: 10),
                        child: Column(
                          children: [
                            LzImage(
                              "poto.jpg",
                              size: 150,
                              radius: 100,
                            ),
                            SizedBox(height: 10),
                            InkWell(
                              onTap: () {
                                // Tambahkan aksi
                              },
                              child: Container(
                                padding: Ei.sym(v: 10, h: 20),
                                child: Text(
                                  'Change Picture',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                      // Informasi profil
                      Container(
                          margin: Ei.only(t: 10),
                          padding: Ei.only(t: 10),
                          decoration: BoxDecoration(
                            color: ColorConstants.secondaryColor,
                            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                          ),
                          width: double.infinity,
                          height: 500,
                          child: Container(
                            margin: Ei.sym(h: 10),
                            child: LzFormList(
                              children: [
                                Flexible(
                                  child: LzForm.input(
                                    label: 'Username',
                                    hint: 'Enter username',
                                    labelStyle: LzFormLabelStyle(),
                                  ),
                                ),
                                Flexible(
                                  child: LzForm.input(
                                    label: 'Email',
                                    hint: 'email@gmail.com',
                                    labelStyle: LzFormLabelStyle(),
                                  ),
                                ),
                                Flexible(
                                  child: LzForm.input(
                                    label: 'Description',
                                    hint: 'Enter description',
                                    labelStyle: LzFormLabelStyle(),
                                  ),
                                ),
                                Flexible(
                                  child: LzForm.input(
                                    label: 'Phone Number',
                                    hint: '+62 ... ... ...',
                                    labelStyle: LzFormLabelStyle(),
                                  ),
                                ),
                                Flexible(
                                  child: LzForm.input(
                                    label: 'Instagram',
                                    hint: '@nama_instagram',
                                    labelStyle: LzFormLabelStyle(),
                                  ),
                                ),
                                Flexible(
                                  child: LzForm.input(
                                    label: 'Password',
                                    hint: 'Type your password',
                                    obsecureToggle: true,
                                  ),
                                ),
                                Flexible(
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: ColorConstants.primaryColor,
                                    ),
                                    onPressed: () {
                                      // ...
                                    },
                                    child: const Text('Submit'),
                                  ),
                                ),
                              ],
                            ),
                          ))
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
