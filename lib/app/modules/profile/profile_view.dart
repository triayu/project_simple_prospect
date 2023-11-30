import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/providers/profile/profile_user_providers.dart';

import 'edit_profile_view.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({Key? key}) : super(key: key);

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

            return ListView(
              padding: Ei.sym(h: 10, v: 20),
              physics: BouncingScrollPhysics(),
              children: [
                Column(
                  children: [
                    // PHOTO
                    Container(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              LzImage(
                                image,
                                radius: 70,
                                size: 130,
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
                          SizedBox(height: 20),
                          Text(
                            fullName.ucwords,
                            textAlign: Ta.center,
                            style: Gfont.black.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 20),
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
                            subtitle: Text(id.toString(), style: Gfont.black),
                            onTap: () {},
                          ),
                          Divider(),
                          ListTile(
                            title: Text('Nama Lengkap', style: gfont.copyWith(color: LzColors.grey)),
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
                              Utils.copy(referralCode).then((value) => LzToast.show('Kode Referral berhasil di copy!'));
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                )
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
