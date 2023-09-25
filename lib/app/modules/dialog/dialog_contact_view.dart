import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/constants/color_constants.dart';

class DialogContactView extends StatelessWidget {
  final String? title;


  const DialogContactView({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      insetPadding: Ei.zero,
      backgroundColor: Colors.transparent,
      
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 2.0,
          child: Column(
            children: [
              Container(
                color: ColorConstants.primaryColor,
                padding: Ei.all(16),
                width: double.infinity,
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Ti.arrowLeft, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(
                      width: 50,
                    ),
                    Text(
                      "Filter",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                child: Column(
                  children: [
                    ListTile(
                      title: Text("Form Input"),
                      onTap: () {},
                    ),
                    Divider(),
                    ListTile(
                      title: Text("Team"),
                      onTap: () {
                        // Aksi
                      },
                    ),
                    Divider(),
                    ListTile(
                      title: Text("Client"),
                      onTap: () {
                        // Aksi
                      },
                    ),
                    Divider(),
                    ListTile(
                      title: Text("Acquaintance"),
                      onTap: () {
                        // Aksi
                      },
                    ),
                    Divider(),
                    ListTile(
                      title: Text("Friends & Family"),
                      onTap: () {
                        // Aksi
                      },
                    ),
                    Divider(),
                    ListTile(
                      title: Text("Later Prospect"),
                      onTap: () {
                        // Aksi
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
