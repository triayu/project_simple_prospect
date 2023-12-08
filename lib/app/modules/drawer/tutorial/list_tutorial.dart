import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart' hide Gfont, gfont;
import 'package:simple_prospect/app/data/models/model.dart';
import 'package:simple_prospect/app/modules/drawer/tutorial/tutorial_view.dart';
import 'package:simple_prospect/app/widgets/custom_appbar.dart';
import '../../../constants/color_constants.dart';
import '../../../core/text_theme.dart';
import '../../../providers/tutorial/tutorial_provider.dart';

class ListTutorialView extends ConsumerWidget {
  const ListTutorialView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      key: ref.read(tutorialProvider.notifier).scaffoldKey.currentContext as GlobalKey<ScaffoldState>?,
      appBar: CustomAppBar(
        title: 'Tutrorial',
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

              return Refreshtor(
                onRefresh: () => ref.read(tutorialProvider.notifier).getTutorial(),
                child: ListView.separated(
                  padding: Ei.only(t: 10, h: 10, b: 50),
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final key = GlobalKey();

                    TutorialModel datas = data[index];
                    // int id = datas.id ?? 0;
                    String tittle = datas.title ?? 'Tidak Ada Tittle';
                    String description = datas.description ?? '';
                    String? image = datas.thumbnailUrl ?? '';

                    return InkTouch(
                      elevation: 1,
                      key: key,
                      color: Colors.white,
                      onTap: () {
                        final options = [
                          'Lihat Detail',
                        ].options(icons: [
                          Ti.infoCircle,
                        ]);
                        DropX.show(key.currentContext, options: options, onSelect: (val) {
                          if (val.index == 0) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => TutorialView(tutorial: datas),
                              ),
                            );
                          }

                          if (val.index == 1) {
                            // Navigator.of(context).push(
                            //   MaterialPageRoute(
                            //     builder: (context) => NAMACLASS(
                            //       data: datas,
                            //     ),
                            //   ),
                            // );
                          }

                          if (val.index == 2) {
                            // showDialog(
                            //     context: context,
                            //     builder: (BuildContext context) {
                            //       return LzConfirm(
                            //         title: "Apakah Anda Yakin Untuk Menghapus Data Ini?",
                            //         titleSize: 15,
                            //         onConfirm: () {
                            //           ref.read(tutorialProvider.notifier).delTutorial(id);
                            //         },
                            //       );
                            //     });
                          }
                        });
                      },
                      padding: Ei.all(5),
                      child: ListTile(
                        dense: true,
                        minVerticalPadding: 10,
                        minLeadingWidth: 0,
                        leading: LzImage(
                          image,
                          radius: 5,
                          width: 50,
                          size: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(
                          tittle.ucwords,
                          style: Gfont.autoSizeText(context, FontSizeManager.getTittleFontSize(), fontWeight: Fw.bold),
                          maxLines: 2,
                        ),
                        subtitle: Text(
                          description,
                          style: Gfont.autoSizeText(context, FontSizeManager.getCaptionFontSize(), color: Colors.grey),
                          maxLines: 2,
                        ),
                        trailing: Icon(Icons.more_vert, color: ColorConstants.primaryColor),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 10);
                  },
                  itemCount: data.length,
                ),
              );
            },
            error: (error, _) {
              return LzNoData(message: 'Opps! $error');
            },
            loading: () {
              return ListView.builder(
                itemCount: 10,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Skeleton(radius: 10, margin: Ei.all(10), size: [100, 50]);
                },
              );
            },
          );
        },
      ),
    );
  }
}
