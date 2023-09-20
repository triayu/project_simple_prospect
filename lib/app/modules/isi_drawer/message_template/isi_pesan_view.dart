import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';

import '../../../widgets/custom_appbar.dart';

class IsiPesanView extends ConsumerWidget {
  const IsiPesanView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Message",
      ),
      body: Col(
        children: [
          Col(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 40,
                width: double.maxFinite,
                decoration: BoxDecoration(border: Border.all(color: Colors.black12)),
                child: Row(
                  children: [
                    Container(
                      padding: Ei.all(10),
                      child: Text(
                        'Kepada :',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      margin: Ei.only(r: 10),
                      child: Icon(Ti.circlePlus),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
