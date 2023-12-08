// WIDGET IMAGE PREVIEW ==============================================================
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lazyui/lazyui.dart';

class WidImagePreview extends StatelessWidget {
  final File file;
  WidImagePreview({required this.file});

  @override
  Widget build(BuildContext context) {
    double size = context.width * .5;

    return CenterDialog(
      child: ClipRRect(
        borderRadius: Br.radius(2),
        child: Container(
          width: context.width,
          decoration: BoxDecoration(color: Colors.white),
          child: Column(
            children: [
              Container(
                  padding: Ei.sym(v: 35),
                  child: Container(
                      width: size,
                      height: size,
                      decoration: BoxDecoration(
                          borderRadius: Br.circle, image: DecorationImage(image: FileImage(file), fit: BoxFit.cover)))),
              Container(
                width: context.width,
                decoration: BoxDecoration(border: Br.only(['t'])),
                child: Intrinsic(
                  children: List.generate(
                    2,
                    (i) {
                      return Expanded(
                        child: Container(
                          decoration: BoxDecoration(border: Br.only([i == 0 ? '' : 'l'])),
                          child: InkTouch(
                            onTap: () {
                              Navigator.pop(context, i == 0 ? null : true);
                            },
                            padding: Ei.sym(v: 15, h: 25),
                            color: Colors.white,
                            child: Text(i == 0 ? 'Batal' : 'Simpan', textAlign: Ta.center),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
