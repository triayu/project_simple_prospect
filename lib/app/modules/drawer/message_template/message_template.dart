import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

import '../../../constants/color_constants.dart';
import 'isi_pesan_view.dart';

class MessageView extends ConsumerWidget {
  const MessageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Message Template', textAlign: Ta.center),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 60,
                  width: 200,
                  margin: Ei.only(t: 30, l: 140),
                  padding: Ei.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(
                    'Terimakasih banyak',
                    textAlign: Ta.right,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: 90,
                  width: 250,
                  margin: Ei.only(t: 30, r: 80),
                  padding: Ei.all(20),
                  decoration: BoxDecoration(
                    color: ColorConstants.event3.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(
                    'Meeting selanjutnya akan kami jadwalkan',
                    textAlign: Ta.left,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: 150,
                  width: 350,
                  margin: Ei.only(t: 30, h: 15),
                  padding: Ei.all(20),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(
                    'Meeting selanjutnya akan kami jadwalkan, meeting selanjutnya akan kami jadwalkan, meeting selanjutnya akan kami jadwalkan, meeting selanjutnya akan kami jadwalkan. ',
                    textAlign: Ta.justify,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  height: 110,
                  width: 350,
                  margin: Ei.only(t: 30, h: 15),
                  padding: Ei.all(20),
                  decoration: BoxDecoration(
                    color: ColorConstants.event2.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Text(
                    'Meeting selanjutnya akan kami jadwalkan, meeting selanjutnya akan kami jadwalkan. ',
                    textAlign: Ta.justify,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Poslign(
              alignment: Alignment.bottomRight,
              child: Container(
                width: 60,
                height: 60,
                margin: Ei.only(b: 10, r: 20, t: 30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: ColorConstants.primaryColor,
                ),
                child: IconButton(
                  icon: Icon(
                    Ti.brandTwitch,
                    color: Colors.white,
                    size: 35,
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => IsiPesanView()));
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
