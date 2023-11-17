import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/constants/color_constants.dart';

class ProfileView extends ConsumerWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: Ei.sym(v: 20),
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              padding: Ei.only(t: 20, b: 20),
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
                  SizedBox(height: 20),
                  Textr(
                    'Tri Ayu Novitasari',
                    textAlign: Ta.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    margin: Ei.only(b: 5),
                  ),
                  Textr(
                    '12340987',
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
              padding: Ei.sym(h: 20),
              margin: Ei.sym(h: 20),
              width: context.width,
              decoration: BoxDecoration(color: Colors.white, border: Br.all(color: Colors.black.withOpacity(0.1))),
              child: Column(
                children: [
                  // Foto

                  Column(
                    children: [
                      ListTile(
                        title: Text("ID Anda", style: gfont.copyWith(color: LzColors.grey)),
                        subtitle: Text('1234987', style: Gfont.black),
                        onTap: () {},
                      ),
                      Divider(),
                      ListTile(
                        title: Text("Nama Lengkap", style: gfont.copyWith(color: LzColors.grey)),
                        subtitle: Text('Tri Ayu Novitasari', style: Gfont.black),
                        onTap: () {
                          // Aksi
                        },
                      ),
                      Divider(),
                      ListTile(
                        title: Text("Alamat", style: gfont.copyWith(color: LzColors.grey)),
                        subtitle: Text('Jl. Lijen, Glagah, Kp. Baru', style: Gfont.black),
                        onTap: () {
                          // Aksi
                        },
                      ),
                      Divider(),
                      ListTile(
                        title: Text("No. Telepon", style: gfont.copyWith(color: LzColors.grey)),
                        subtitle: Text('08123456789', style: Gfont.black),
                        onTap: () {
                          // Aksi
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
