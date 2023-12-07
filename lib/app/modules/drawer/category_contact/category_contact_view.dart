import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart' hide Gfont, gfont;
import 'package:simple_prospect/app/constants/color_constants.dart';
import 'package:simple_prospect/app/core/text_theme.dart';
import 'package:simple_prospect/app/data/models/model.dart';
import 'package:simple_prospect/app/modules/drawer/category_contact/form_category_contact_view.dart';
import 'package:simple_prospect/app/modules/drawer/contact/contact_view.dart';
import 'package:simple_prospect/app/providers/contact/category_contact_provider.dart';
import 'package:simple_prospect/app/providers/contact/category_contacts_provider.dart';
import 'package:simple_prospect/app/widgets/custom_appbar.dart';

class CategoryContactView extends ConsumerWidget {
  const CategoryContactView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(categoryContactsProvider);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Category Contact',
      ),
      body: asyncData.when(
        data: (data) {
          if (data.isEmpty) {
            return LzNoData(
                message: 'Opps! No data found',
                onTap: () => ref.read(categoryContactsProvider.notifier).getCategoryContact());
          }

          return NotificationListener<ScrollNotification>(
            onNotification: (notification) {
              if (notification is ScrollEndNotification) {
                final metrics = notification.metrics;
                final maxScroll = metrics.maxScrollExtent;
                final pixel = metrics.pixels;

                if (maxScroll == pixel) {
                  // logg('to bottom');
                  ref.read(categoryContactsProvider.notifier).getCategoryContactPaginate();
                }
              }
              return false;
            },
            child: Refreshtor(
              onRefresh: () async {
                ref.read(categoryContactsProvider.notifier).getCategoryContact();
              },
              child: ListView.separated(
                padding: Ei.only(t: 10, h: 10, b: 50),
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  final key = GlobalKey();

                  CategoryContactModel datas = data[index];
                  int id = datas.id ?? 0;
                  String catName = datas.categoryName ?? '';

                  return InkTouch(
                    elevation: 1,
                    key: key,
                    color: Colors.white,
                    onTap: () {
                      final options =
                          ['Lihat Kontak', 'Edit', 'Hapus'].options(icons: [Ti.infoCircle, Ti.edit, Ti.trash]);
                      DropX.show(key.currentContext, options: options, onSelect: (val) {
                        if (val.index == 0) {
                          ref.read(categoryContactProvider.notifier).setCategoryContact(datas);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => ContactView(
                                      categoryContact: datas,
                                    )),
                          );
                        }

                        if (val.index == 1) {
                          showDialog(
                              context: context,
                              builder: (value) {
                                return FormCategoryContact(
                                  data: datas,
                                );
                              });
                        }

                        if (val.index == 2) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return LzConfirm(
                                  title: "Apakah Anda Yakin Untuk Menghapus Data Ini?",
                                  titleSize: 15,
                                  onConfirm: () {
                                    ref.read(categoryContactsProvider.notifier).delCategoryContact(id);
                                  },
                                );
                              });
                        }
                      });
                    },
                    padding: Ei.all(5),
                    child: ListTile(
                      dense: true,
                      minLeadingWidth: 0,
                      leading: Icon(
                        Ti.bookmark,
                        color: ColorConstants.primaryColor,
                        size: 30,
                      ),
                      title: Text(
                        catName.ucwords,
                        style: Gfont.autoSizeText(context, FontSizeManager.getBodyFontSize()),
                        maxLines: 3,
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
            itemBuilder: (context, index) {
              return Skeleton(radius: 10, margin: Ei.all(10), size: [100, 50]);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: ColorConstants.primaryColor,
          onPressed: () {
            showDialog(
                context: context,
                builder: (value) {
                  return FormCategoryContact();
                });
          },
          child: Icon(Icons.add)),
    );
  }
}
