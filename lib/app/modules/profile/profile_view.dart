import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/constants/color_constants.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: SizedBox(
          child: Stack(
            children: [
              Col(
                children: [
                  // Foto
                  Container(
                    alignment: Alignment.bottomCenter,
                    padding: Ei.only(b: 20, t: 40),
                    child: LzImage(
                      'poto.jpg',
                      radius: 70,
                      size: 130,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Tri Ayu Novitasari',
                      textAlign: Ta.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Container(
                    padding: Ei.only(b: 20),
                    alignment: Alignment.center,
                    child: Text(
                      '12340987',
                      textAlign: Ta.center,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),

                  Container(
                    width: double.infinity,
                    height: 100,
                    padding: Ei.only(v: 10),
                    margin: Ei.only(l: 20, r: 20),
                    decoration: BoxDecoration(
                      color: ColorConstants.secondaryColor,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.yellow.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.verified_user,
                                color: Colors.black,
                                size: 20,
                              ),
                              SizedBox(width: 10),
                              Text(
                                'Verifikasi Data',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                '1 dari 5 data belum terverifikasi ',
                                style: TextStyle(color: const Color.fromARGB(255, 216, 198, 31), fontSize: 12),
                              ),
                              Spacer(),
                              Icon(
                                Ti.alertCircle,
                                color: const Color.fromARGB(255, 216, 198, 31),
                                size: 20,
                              ),
                            ],
                          ),
                          Text(
                            'Tap untuk verifikasi ',
                            style: TextStyle(color: Color.fromARGB(255, 216, 198, 31), fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: Ei.only(h: 20),
                    color: Colors.white,
                    child: Column(
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
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
