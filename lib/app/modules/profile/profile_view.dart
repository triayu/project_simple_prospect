import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/modules/profile/edit_profile_view.dart';
import '../../constants/color_constants.dart';
import '../../providers/profile/profile_user_providers.dart';

class ProfileView extends ConsumerWidget {
  ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Consumer(builder: (context, ref, _) {
        final profileData = ref.watch(profileProvider);
        return profileData.when(
          data: (data) {
            String fullName = '${data?.firstName ?? ''} ${data?.lastName ?? ''}';
            String referralCode = data?.referralCode ?? '';
            String email = data?.email ?? '';
            int id = data?.id ?? 0;
            String image = data?.fotoProfile ?? 'poto.jpg';

            return Stack(
              children: [
                Container(
                  decoration: BoxDecoration(color: ColorConstants.primaryColor),
                  // backgroundColor: ColorConstants.primaryColor,
                ),
                Positioned(
                  top: 65,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          // FOTO
                          Container(
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    LzImage(
                                      image,
                                      radius: 60,
                                      size: 120,
                                    ),
                                    Poslign(
                                      alignment: Alignment.bottomRight,
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(builder: (context) => EditProfileView()),
                                          );
                                        },
                                        child: InkTouch(
                                          color: Colors.white,
                                          radius: Br.circle,
                                          elevation: 2,
                                          padding: Ei.all(10),
                                          child: Icon(
                                            Ti.edit,
                                            color: Colors.black,
                                            size: 25,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                Text(
                                  fullName.ucwords,
                                  textAlign: Ta.center,
                                  style: Gfont.white.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          ),

                          // Informasi profil
                          Container(
                            padding: Ei.only(t: 10),
                            decoration: BoxDecoration(
                              color: ColorConstants.secondaryColor,
                              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                            ),
                            width: double.infinity,
                            height: context.height,
                            child: LzFormList(
                              children: [
                                ListTile(
                                  title: Text("ID Anda", style: gfont.copyWith(color: LzColors.grey)),
                                  subtitle: Text(id.toString(), style: Gfont.black),
                                  onTap: () {},
                                ),
                                Divider(),
                                ListTile(
                                  title: Text(
                                    'Nama Lengkap',
                                    style: gfont.copyWith(color: LzColors.grey),
                                  ),
                                  subtitle: Text(fullName.ucwords, style: Gfont.black),
                                ),
                                Divider(),
                                ListTile(
                                  title: Text("Alamat", style: gfont.copyWith(color: LzColors.grey)),
                                  subtitle: Text(email, style: Gfont.black),
                                  onTap: () {
                                    // Aksi
                                  },
                                ),
                                Divider(),
                                ListTile(
                                  title: Text("Kode Referral", style: gfont.copyWith(color: LzColors.grey)),
                                  subtitle: Text(referralCode, style: Gfont.black),
                                  isThreeLine: true,
                                  trailing: Icon(Ti.copy),
                                  onTap: () {
                                    Utils.copy('referralCode')
                                        .then((value) => LzToast.show('Kode Referral berhasil di copy!'));
                                  },
                                ),
                                SizedBox(
                                  height: 40,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
          error: (error, _) {
            return LzNoData(message: 'Opps! $error');
          },
          loading: () {
            return LzLoader.bar(message: 'Loading...');
          },
        );
      }),
    );
  }
}
