import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart' hide Gfont, gfont;

import '../../../constants/color_constants.dart';
import '../../../core/text_theme.dart';
import '../../form/form_contact/form_contact_view.dart';

import 'edit_pesan_view.dart';
import 'kirim_pesan_view.dart';

class IsiContactView extends StatelessWidget {
  const IsiContactView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey(), bottomKey = GlobalKey();
    return Scaffold(
      appBar: AppBar(
        title: Text('Kontak Anda'),
        centerTitle: true,
        actions: [
          Icon(
            Ti.menu2,
            key: bottomKey,
          ).onPressed(() {
            final options = ['Import to excel', 'Export contact', 'Import from phonebook'].options();
            DropX.show(bottomKey, options: options, onSelect: (p0) {
              logg(p0.option);
              if (p0.option == 'Import to excel') {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => KirimPesanView(),
                ));
              }
              logg(p0.option);
              if (p0.option == 'Export contact') {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => EditPesanView(),
                ));
              } else if (p0 == 'Import from phonebook') {
                // ---
              }
            });
          })
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListView.separated(
              padding: Ei.only(t: 10, b: 30, h: 10),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  padding: Ei.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorConstants.secondaryColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Flexible(
                    flex: 2,
                    child: Row(
                      children: [
                        LzImage(
                          'tutorial.png',
                          radius: 50,
                          size: 50,
                        ),
                        SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Nama Kontak $index',
                              style: Gfont.autoSizeText(
                                context,
                                FontSizeManager.getBodyFontSize(),
                                fontWeight: Fw.bold,
                                color: ColorConstants.textPrimaryColor,
                              ),
                            ),
                            Text(
                              'Company ---- $index',
                              style: Gfont.autoSizeText(
                                context,
                                FontSizeManager.getBodyFontSize(),
                                color: ColorConstants.textPrimaryColor,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 15);
              },
              itemCount: 6,
            ),
            Poslign(
              alignment: Alignment.bottomRight,
              child: InkTouch(
                padding: Ei.all(10),
                margin: Ei.all(10),
                radius: Br.circle,
                color: ColorConstants.primaryColor,
                child: Icon(
                  Ti.plus,
                  color: Colors.white,
                  size: 35,
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => FormContactView(),
                  ));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
