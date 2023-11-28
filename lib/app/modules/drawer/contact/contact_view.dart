import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/constants/color_constants.dart';

import 'package:simple_prospect/app/modules/form/form_contact/form_contact_view.dart';
import 'package:simple_prospect/app/providers/contact/contact_provider.dart';
import 'package:simple_prospect/app/widgets/custom_appbar.dart';

import '../../../data/models/model.dart';

class ContactView extends ConsumerWidget {
  const ContactView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Contact',
        centerTitle: true,
      ),

      // ============
      // LIST CONTACT
      body: Consumer(builder: (context, ref, _) {
        final asyncData = ref.watch(contactProvider);

        return asyncData.when(
          data: (data) {
            if (data.isEmpty) {
              return LzNoData(
                  message: 'Opps! No data found', onTap: () => ref.read(contactProvider.notifier).getContact());
            }

            return Refreshtor(
              onRefresh: ()  async{
                await ref.read(contactProvider.notifier).getContact();
              },
              child: ListView.separated(
                padding: Ei.sym(h: 10),
                physics: BounceScroll(),
                itemBuilder: (context, index) {
                  ContactModel datas = data[index];
            
                  int id = datas.id ?? 0;
                  String firstName = datas.firstName ?? '';
                  String phoneNumber = datas.phoneNumber ?? '';
            
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
                      contentPadding: Ei.sym(h: 10, v: 10),
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
                            firstName,
                            style: Gfont.fs(16),
                          ),
                          Text(
                            phoneNumber,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            child: IconButton(
                              icon: Icon(
                                Ti.trash,
                                color: ColorConstants.errorColor,
                                size: 20,
                              ),
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return LzConfirm(
                                        title: "Apakah Anda Yakin Untuk Menghapus Data Ini",
                                        onConfirm: () {
                                          // logg(id);
                                          logg('Tekan Hapus');
                                          ref.read(contactProvider.notifier).delContact(id);
                                        },
                                      );
                                    });
                              },
                            ),
                          ),
                          Container(
                            child: IconButton(
                              icon: Icon(
                                Ti.edit,
                                color: ColorConstants.successColor,
                                size: 20,
                              ),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => FormContactView(
                                      data: datas,
                                    ),
                                  ),
                                );
                              },
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
      }),

      floatingActionButton: Poslign(
        alignment: Alignment.bottomRight,
        child: InkTouch(
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
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => FormContactView(),
            ));
          },
        ),
      ),
    );
  }
}
