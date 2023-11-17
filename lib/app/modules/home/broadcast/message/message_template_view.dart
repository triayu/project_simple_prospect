import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/constants/color_constants.dart';
import 'package:simple_prospect/app/modules/home/broadcast/message/add_template_message_view.dart';

import 'edit_message_view.dart';
import 'send_message_view.dart';

class MessageTemplate extends ConsumerWidget {
  const MessageTemplate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottomKey = GlobalKey();
    return Scaffold(
      appBar: AppBar(
        title: Text('Pesan Whatasapp'),
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
                    // Template Pesan

                    InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SendMessage()));
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
                                  'Leaf Bobby Pins',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Spacer(),
                                Icon(
                                  Ti.menu2,
                                  key: bottomKey,
                                ).onPressed(() {
                                  final options = ['Kirim Pesan', 'Edit', 'Hapus'].options();
                                  DropX.show(bottomKey.context, options: options, onSelect: (p0) {
                                    if (p0.option == 'Kirim Pesan') {
                                      Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => SendMessage(),
                                      ));
                                    }
                                    logg(p0.option);
                                    if (p0.option == 'Edit') {
                                      Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => EditMessage(),
                                      ));
                                    } else if (p0 == 'Hapus') {
                                      // ---
                                    }
                                  });
                                })
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ',
                              textAlign: Ta.justify,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            )
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
          child: Icon(Ti.plus),
          backgroundColor: ColorConstants.primaryColor,
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddTemplateMessage(),
              ),
            );
          }),
    );
  }
}
