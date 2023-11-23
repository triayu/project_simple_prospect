import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/constants/color_constants.dart';
import 'package:simple_prospect/app/data/models/profile_model.dart';
import 'package:simple_prospect/app/providers/profile/profile_user_providers.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: Ei.sym(v: 15),
        physics: BouncingScrollPhysics(),
        child: Consumer(builder: (context, ref, _) {
          final profileData = ref.watch(profileProvider);

          return profileData.when(
            data: (data) {
              if (data.isEmpty) {
                return LzNoData(
                    message: 'Opps! No data found', onTap: () => ref.read(profileProvider.notifier).getProfile());
              }

              return ListView.separated(
                padding: Ei.sym(h: 10, v: 20),
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  List<ProfileModel> datas = data;

                  int id = datas[index].id ?? 0;
                  String firstName = datas[index].firstName ?? '';
                  String email = datas[index].email ?? '';
                  String referralCode = datas[index].referralCode ?? '';

                  return Column(
                    children: [
                      // PHOTO
                      Container(
                        padding: Ei.only(t: 20, b: 10),
                        child: Column(
                          children: [
                            SizedBox(
                              child: LzImage(
                                'poto.jpg',
                                radius: 70,
                                size: 130,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                // Navigator.push(context, MaterialPageRoute(builder: (context) => halamanedit()));
                              },
                              child: Text('Edit foto',
                                  style: Gfont.black.copyWith(
                                      fontSize: 14,
                                      decoration: TextDecoration.underline,
                                      color: ColorConstants.textPrimaryColor)),
                            ),
                            SizedBox(height: 10),
                            Textr(
                              firstName,
                              textAlign: Ta.center,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                              margin: Ei.only(b: 5),
                            ),
                            Textr(
                              referralCode,
                              textAlign: Ta.center,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                              margin: Ei.only(b: 10),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: Ei.sym(h: 10),
                        margin: Ei.sym(h: 10),
                        width: context.width,
                        decoration:
                            BoxDecoration(color: Colors.white, border: Br.all(color: Colors.black.withOpacity(0.1))),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text("ID Anda", style: gfont.copyWith(color: LzColors.grey)),
                              subtitle: Text(email, style: Gfont.black),
                              onTap: () {},
                            ),
                            Divider(),
                            ListTile(
                              title: Text(firstName, style: gfont.copyWith(color: LzColors.grey)),
                              subtitle: Text('Tri Ayu Novitasari', style: Gfont.black),
                              onTap: () {
                                // Aksi
                              },
                            ),
                            Divider(),
                            ListTile(
                              title: Text("Alamat", style: gfont.copyWith(color: LzColors.grey)),
                              subtitle: Text(email, style: Gfont.black),
                              onTap: () {
                                // Aksi
                              },
                            ),
                            // Divider(),
                            // ListTile(
                            //   title: Text("No. Telepon", style: gfont.copyWith(color: LzColors.grey)),
                            //   subtitle: Text('08123456789', style: Gfont.black),
                            //   onTap: () {
                            //     // Aksi
                            //   },
                            // )
                          ],
                        ),
                      ),
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 10);
                },
                itemCount: data.length,
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
        }),
      ),
    );
  }
}
