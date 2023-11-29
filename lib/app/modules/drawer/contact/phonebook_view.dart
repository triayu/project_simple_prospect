import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/constants/color_constants.dart';
import 'package:simple_prospect/app/modules/drawer/contact/contact_view.dart';
import 'package:simple_prospect/app/modules/home/broadcast/phone_book/manage_contact_view.dart';
import 'package:simple_prospect/app/modules/drawer/contact/add_phone_book_view.dart';

class PhonebookView extends StatelessWidget {
  const PhonebookView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey(), bottomKey = GlobalKey();
    return Scaffold(
        appBar: AppBar(
          title: Text('Category Contact'),
          centerTitle: true,
        ),
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Column(
                    children: [
                      // ==================
                      // PHONE BOOK
                      InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ContactView()));
                        },
                        child: Container(
                          margin: Ei.only(h: 10, t: 20, b: 10),
                          padding: Ei.sym(h: 20, v: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Client',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Ti.dotsVertical,
                                    key: bottomKey,
                                  ).onPressed(() {
                                    final options = ['Kelola', 'Edit', 'Hapus'].options();
                                    DropX.show(bottomKey, options: options, onSelect: (p0) {
                                      logg(p0.option);
                                      if (p0.option == 'Kelola') {
                                        Navigator.of(context).push(MaterialPageRoute(
                                          builder: (context) => ManageContact(),
                                        ));
                                      }
                                      logg(p0.option);
                                      if (p0.option == 'Edit') {
                                        // Navigator.of(context).push(MaterialPageRoute(
                                        //   builder: (context) => EditPhonebook(),
                                        // ));
                                      } else if (p0 == 'Hapus') {
                                        // ---
                                      }
                                    });
                                  })
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => AddPhoneBook(),
            ));
          },
          child: Icon(Ti.plus),
          backgroundColor: ColorConstants.primaryColor,
        ));
  }
}
