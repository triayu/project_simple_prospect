import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

class ProspectView extends ConsumerWidget {
  const ProspectView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PROSPECT'),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Col(
                  children: [
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
