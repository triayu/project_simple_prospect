import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

import 'package:simple_prospect/app/modules/drawer/tutorial/tutorial_view.dart';
import 'package:simple_prospect/app/providers/tutorial/tutorial_provider.dart';

import '../../../data/models/model.dart';

class ListTutorialView extends ConsumerWidget {
  const ListTutorialView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tutorial'),
        centerTitle: true,
      ),
      body: Consumer(
        builder: (context, ref, _) {
          final asyncData = ref.watch(tutorialProvider);

          return asyncData.when(
            data: (data) {
              if (data.isEmpty) {
                return LzNoData(
                    message: 'Opps! No data found', onTap: () => ref.read(tutorialProvider.notifier).getTutorial());
              }

              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final TutorialModel tutorial = data[index];
                  String? image = tutorial.thumbnailUrl ?? '';

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
                      margin: Ei.all(10),
                      child: ListTile(
                        contentPadding: Ei.sym(h: 10),
                        dense: true,
                        tileColor: Colors.white,
                        leading: LzImage(
                          image,
                          radius: 5,
                          width: 80,
                          height: 80,
                        ),
                        title: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Prospect ${tutorial.id}',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              tutorial.description ?? 'No description available',
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
              );
           
           
            },
            error: (error, _) {
              return LzNoData(message: 'Opps! $error');
            },
            loading: () {
              return SizedBox(
                height: 90,
                child: ListView.builder(
                  itemCount: 10,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Skeleton(radius: 10, margin: Ei.all(10), size: [100, 50]);
                  },
                ),
              );
            },
          );
       
       
        },
      ),
    );
  }
}
