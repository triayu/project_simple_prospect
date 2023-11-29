import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/modules/home/broadcast/message/message_template_view.dart';
import 'package:simple_prospect/app/modules/drawer/contact/phonebook_view.dart';

class BroadcastView extends ConsumerWidget {
  const BroadcastView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
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
                
                
                //  ============
                //  MESSAGE
                Stack(
                  children: [
                    Positioned.fill(
                      top: -50,
                      bottom: -50,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: LzImage(
                          'banner_ornament.svg',
                          size: context.width,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    Container(
                      margin: Ei.only(h: 10, t: 20),
                      padding: Ei.all(10),
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
                      child: InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MessageTemplate()));
                        },
                        child: Center(
                          child: Column(
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
                                  Expanded(
                                    child: Text(
                                      'Message',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Kirim pesan sekaligus kepada banyak orang dengan fitur pesan.',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
