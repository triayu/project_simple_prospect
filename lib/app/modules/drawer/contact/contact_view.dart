import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart' hide Gfont, gfont;
import 'package:simple_prospect/app/constants/color_constants.dart';
import 'package:simple_prospect/app/modules/drawer/contact/contact_detail_view.dart';
import 'package:simple_prospect/app/modules/drawer/contact/form_contact_view.dart';
import 'package:simple_prospect/app/providers/contact/contact_provider.dart';
import 'package:simple_prospect/app/widgets/custom_appbar.dart';
import '../../../core/text_theme.dart';
import '../../../data/models/model.dart';

class ContactView extends ConsumerWidget {
  final CategoryContactModel categoryContact;
  const ContactView({super.key, required this.categoryContact});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      // ============
      // LIST CONTACT
      appBar: CustomAppBar(
        title: 'Contact',
        canBack: false,
      ),
      body: Consumer(
        builder: (context, ref, _) {
          final asyncData = ref.watch(contactProvider);

          return asyncData.when(
            data: (data) {
              if (data.isEmpty) {
                return LzNoData(
                    message: 'Opps! No data found',
                    onTap: () => ref.read(contactProvider.notifier).getContact(categoryContact.id ?? 0));
              }

              return Refreshtor(
                onRefresh: () => ref.read(contactProvider.notifier).getContact(categoryContact.id ?? 0),
                child: ListView.separated(
                  padding: Ei.only(t: 10, h: 10, b: 50),
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final key = GlobalKey();

                    ContactModel datas = data[index];
                    int id = datas.id ?? 0;
                    String firstName = datas.firstName ?? '';
                    String phoneNumber = datas.phoneNumber ?? '';

                    logg(firstName);

                    return InkTouch(
                      elevation: 1,
                      key: key,
                      color: Colors.white,
                      onTap: () {
                        final options =
                            ['Lihat Detail', 'Edit', 'Hapus'].options(icons: [Ti.infoCircle, Ti.edit, Ti.trash]);
                        DropX.show(key.currentContext, options: options, onSelect: (val) {
                          if (val.index == 0) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ContactDetailView(contact: datas),
                              ),
                            );
                          }

                          if (val.index == 1) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => FormContactView(
                                  data: datas,
                                ),
                              ),
                            );
                          }

                          if (val.index == 2) {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return LzConfirm(
                                    title: "Apakah Anda Yakin Untuk Menghapus Data Ini?",
                                    titleSize: 15,
                                    onConfirm: () {
                                      ref.read(contactProvider.notifier).delContact(id);
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
                          Ti.userCircle,
                          color: ColorConstants.primaryColor,
                          size: 30,
                        ),
                        title: Text(
                          firstName.ucwords,
                          style: Gfont.autoSizeText(context, FontSizeManager.getBodyFontSize()),
                          maxLines: 3,
                        ),
                        subtitle:
                            Text(phoneNumber, style: Gfont.autoSizeText(context, FontSizeManager.getCaptionFontSize())),
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
                itemBuilder: (context, index) {
                  return Skeleton(radius: 10, margin: Ei.all(10), size: [100, 50]);
                },
              );
            },
          );
        },
      ),
      bottomNavigationBar: Consumer(builder: (context, ref, _) {
        final asyncData = ref.watch(contactProvider);

        return asyncData.when(
          data: (data) {
            if (data.isEmpty) {
              return SizedBox();
            }

            return ref.watch(contactProvider.notifier).isLoadMore == true
                ? Container(
                    height: 50,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : None();
          },
          error: (error, _) {
            return SizedBox();
          },
          loading: () {
            return SizedBox();
          },
        );
      }),
      floatingActionButton: InkTouch(
        padding: Ei.all(10),
        margin: Ei.all(10),
        radius: Br.circle,
        color: ColorConstants.primaryColor,
        child: Icon(
          Ti.plus,
          color: Colors.white,
          size: 40,
        ),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => FormContactView(),
            ),
          );
        },
      ),
    );
  }
}
