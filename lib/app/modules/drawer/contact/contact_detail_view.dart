import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

import '../../../constants/color_constants.dart';
import '../../../data/models/model.dart';

class ContactDetailView extends ConsumerWidget {
  final ContactModel contact;

  const ContactDetailView({Key? key, required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget buildCardWithIcon(IconData icon, String title, String content) {
      return Card(
        elevation: 4,
        color: ColorConstants.card,
        child: Padding(
          padding: Ei.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon),
                  SizedBox(width: 8),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      color: ColorConstants.textPrimaryColor,
                    ),
                  ),
                ],
              ),
              Text(
                ' $content',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contact Detail',
          textAlign: TextAlign.center,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            buildCardWithIcon(Ti.deviceMobile, 'Name', '${contact.firstName}'),
            SizedBox(height: 30),
            buildCardWithIcon(Ti.phone, 'Phone Number', '${contact.phoneNumber}'),
            buildCardWithIcon(Ti.deviceLandlinePhone, 'Home Phone Number', '${contact.homeNumber}'),
            buildCardWithIcon(Ti.phoneCall, 'Work Phone Number', '${contact.workNumber}'),
          ],
        ),
      ),
    );
  }
}
