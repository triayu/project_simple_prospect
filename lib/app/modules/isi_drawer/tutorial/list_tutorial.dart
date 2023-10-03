import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

import 'package:simple_prospect/app/modules/isi_drawer/tutorial/tutorial_view.dart';
import 'package:simple_prospect/app/widgets/custom_appbar.dart';

class ListTutorialView extends ConsumerWidget {
  const ListTutorialView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                CustomAppBar(
                  title: Text('Kontak Anda'),
                  centerTitle: true,
                ),

                // Tutorial
                Column(
                  children: [
                    Padding(
                      padding: Ei.all(10),
                    ),
                    ListView.separated(
                      padding: Ei.sym(h: 10),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final String imagePath = 'tutorial.png';

                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TutorialView(),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
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
                              contentPadding: Ei.sym(h: 10, v: 5),
                              dense: true,
                              tileColor: Colors.white,
                              style: ListTileStyle.list,
                              leading: LzImage(
                                imagePath,
                                radius: 5,
                                width: 80,
                                height: 80,
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Prospect $index',
                                    style: Gfont.fs(16),
                                  ),
                                  Text(
                                    'Video tutorial penggunaan aplikasi',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
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
        ],
      ),
    );
  }
}
