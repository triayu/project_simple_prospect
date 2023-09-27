import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

import 'isi_contact.dart';

class ContactView extends ConsumerWidget {
  const ContactView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Col(
              children: [
                InkWell(
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => FormContactView()));
                  },
                  child: Container(
                    height: 160,
                    margin: Ei.only(l: 10, r: 10, t: 20),
                    padding: Ei.only(h: 20, v: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Tri Ayu Novitasari',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Spacer(),
                            LzImage(
                              'poto.jpg',
                              radius: 50,
                              size: 80,
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text('Status', style: TextStyle(fontSize: 12)),
                        Text(
                          'Status Aktif',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                //
                // Beli Broadcast Whatsapp
                InkWell(
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => FormContactView()));
                  },
                  child: Container(
                    height: 130,
                    margin: Ei.only(l: 10, r: 10, t: 20),
                    padding: Ei.only(h: 20, v: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.purple.shade900,
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Ti.messageDots,
                              size: 30,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Beli Broadcast Whatsapp',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Beli broadcast Whatsapp untuk membantu anda mengirim pesan kepada banyak orang.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                // Broadcast //  MasMessage
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => IsiContactView()));
                  },
                  child: Container(
                    height: 120,
                    margin: Ei.only(l: 10, r: 10, t: 20),
                    padding: Ei.only(h: 20, v: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.tealAccent.shade700,
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Ti.users,
                              size: 30,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Kontak Whatsapp',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Temukan daftar nomor penting dalam kontak yang tersimpan dengan fitur ini.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                // Kontak Whatsapp
                InkWell(
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => FormContactView()));
                  },
                  child: Container(
                    height: 130,
                    margin: Ei.only(l: 10, r: 10, t: 20),
                    padding: Ei.only(h: 20, v: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.shade900,
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Ti.brandWhatsapp,
                              size: 30,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Broadcast Pesan Whatsapp',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Kirim pesan sekaligus kepada banyak orang dengan fitur broadcast whatsapp.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
