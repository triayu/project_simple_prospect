import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/constants/color_constants.dart';

import '../form_contact/form_contact_view.dart';

class ContactView extends ConsumerWidget {
  const ContactView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Col(
              children: [
                Container(
                  height: 70,
                  width: 400,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        hintText: 'Search Contact',
                        hintStyle: TextStyle(color: Colors.grey),
                        contentPadding: EdgeInsets.only(top: 5),
                      ),
                      onChanged: (value) {
                        // ref.read(searchQueryProvider).state = value;
                      },
                      style: TextStyle(color: Colors.black38),
                    ),
                  ),
                ),

                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => FormContactView()));
                  },
                  child: Container(
                    height: 50,
                    margin: Ei.only(l: 10, r: 10),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Ti.textCaption),
                        Text('Form Input'),
                        Icon(
                          Ti.chevronRight,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),

                // All Contact
                Col(
                  children: [
                    Padding(
                      padding: Ei.all(10),
                      child: Text(
                        'All Contact',
                        style: Gfont.fs(16).copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    ListView.separated(
                      padding: Ei.sym(h: 10),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final String imagePath = 'poto.jpg';

                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: Offset(0, 1),
                              ),
                            ],
                          ),
                          child: ListTile(
                            dense: true,
                            tileColor: Colors.white,
                            style: ListTileStyle.list,
                            leading: LzImage(
                              imagePath,
                              radius: 50,
                              width: 40,
                              height: 40,
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Name lengkap $index',
                                  style: Gfont.fs(16),
                                ),
                                Text(
                                  'Company - - -',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 10);
                      },
                      itemCount: 10,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Poslign(
            alignment: Alignment.bottomRight,
            child: Container(
              width: 60,
              height: 60,
              margin: EdgeInsets.only(bottom: 10, right: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: ColorConstants.primaryColor,
              ),
              child: IconButton(
                icon: Icon(
                  Icons.menu_open_rounded,
                  color: Colors.white,
                  size: 35,
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        backgroundColor: Colors.transparent,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Baris pertama
                              Container(
                                margin: Ei.only(t: 30, b: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        Icon(Ti.messageCheck, color: ColorConstants.primaryColor, size: 35),
                                        Text("Mass message",
                                            style: TextStyle(fontSize: 12, color: ColorConstants.primaryColor)),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Icon(Ti.fileSpreadsheet, color: ColorConstants.primaryColor, size: 35),
                                        Text("Import to excel",
                                            style: TextStyle(fontSize: 12, color: ColorConstants.primaryColor)),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Icon(Ti.deviceMobileCheck, color: ColorConstants.primaryColor, size: 35),
                                        Text("Export contact",
                                            style: TextStyle(fontSize: 12, color: ColorConstants.primaryColor)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              // Icon baris kedua
                              Container(
                                padding: Ei.only(t: 20, b: 30),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Column(
                                      children: [
                                        Icon(Ti.addressBook, color: ColorConstants.primaryColor, size: 35),
                                        Text("Import from phonebook",
                                            style: TextStyle(fontSize: 12, color: ColorConstants.primaryColor)),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Icon(Ti.barcode, color: ColorConstants.primaryColor, size: 35),
                                        Text("Scan business card",
                                            style: TextStyle(fontSize: 12, color: ColorConstants.primaryColor)),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              // SizedBox(height: 20),
                              // ElevatedButton(
                              //   onPressed: () {
                              //     Navigator.of(context).pop();
                              //   },
                              //   child: Text("Tutup"),
                              // ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
