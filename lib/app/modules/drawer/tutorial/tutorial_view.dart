import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/constants/color_constants.dart';
import 'package:simple_prospect/app/data/models/model.dart';
import 'package:simple_prospect/app/providers/tutorial/tutorial_provider.dart';

class TutorialView extends ConsumerWidget {
  const TutorialView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tutorial'),
        centerTitle: true,
      ),
      body: Consumer(builder: (context, ref, _) {
        final asyncData = ref.watch(tutorialProvider);

        return asyncData.when(
          data: (data) {
            if (data.isEmpty) {
              return LzNoData(
                  message: 'Oops! No data found', onTap: () => ref.read(tutorialProvider.notifier).getTutorial());
            }

            return ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: data.length,
              itemBuilder: (context, index) {
                final TutorialModel tutorial = data[index];
                String? video = tutorial.videoUrl ?? '';
                String description = data[index].description ?? '';
                String title = data[index].title ?? '';

                return Column(
                  children: [
                    Padding(
                      padding: Ei.sym(h: 10, v: 5),
                    ),
                    Container(
                      width: double.infinity,
                      height: 200,
                      margin: Ei.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: LzImage(
                        video,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 220,
                      padding: Ei.only(t: 5),
                      margin: Ei.sym(h: 10),
                      decoration: BoxDecoration(
                        color: ColorConstants.secondaryColor,
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Container(
                        padding: Ei.only(b: 10),
                        margin: Ei.only(l: 20, r: 20),
                        child: Text(
                          description,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
            );
          },
          error: (error, _) {
            return LzNoData(message: 'Oops! $error');
          },
          loading: () {
            return SizedBox(
              height: 90,
              child: ListView.builder(
                itemCount: 1,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Skeleton(radius: 10, margin: EdgeInsets.all(10), size: [100, 50]);
                },
              ),
            );
          },
        );
      }),
    );
  }
}
