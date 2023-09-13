import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/config/font.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/constants/color_constants.dart';

class ContactView extends ConsumerWidget {
  const ContactView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        Col(
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

            InkTouch(
              onTap: () {
                // Navigator.of(context).push(MaterialPageRoute(builder: (context) => FormContactView()));
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
                    Icon(Ti.aB),
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
                        title: Text(
                          'Name $index',
                          style: Gfont.fs(16),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 10);
                  },
                  itemCount: 4,
                ),
              ],
            ),
          ],
        ),
        Poslign(
          alignment: Alignment.bottomRight,
          child: Container(
            width: 60,
            height: 60,
            margin: Ei.only(b: 10, r: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: ColorConstants.primaryColor,
            ),
            child: Icon(Icons.menu_open_rounded, color: Colors.white, size: 35),
          ),
        )
      ],
    );
  }
}
