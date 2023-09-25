import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/constants/color_constants.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height,
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
                      height: 50,
                      padding: Ei.only(t: 10),
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
                      child: Container(
                        padding: Ei.only(b: 10),
                        margin: Ei.only(l: 20, r: 20),
                        child: Text(
                          'Verifikasi Data',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
