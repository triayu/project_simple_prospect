import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

import 'package:simple_prospect/app/modules/isi_drawer/tutorial/tutorial_view.dart';

class ListTutorialView extends ConsumerWidget {
  const ListTutorialView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tutorial'),
        centerTitle: true,
      ),
      // Tutorial
      body: ListView(
        children: List.generate(10, (index) {
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
            child: Card(
              elevation: 1,
              margin: EdgeInsets.all(10),
              child: ListTile(
                contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                dense: true,
                tileColor: Colors.white,
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
                      style: TextStyle(fontSize: 16),
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
        }),
      ),
    );
  }
}
