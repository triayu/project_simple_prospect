import 'package:flutter/material.dart';

class DialogView extends StatelessWidget {
  final String? title;

  const DialogView({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
        title: Text(title ?? ''),
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        children: [
          Row(
            children: List.generate(3, (index) {
              return Container(
                child: Icon(
                  Icons.eco,
                  color: Colors.white,
                  size: 70,
                ),
                margin: EdgeInsets.all(25),
                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black, boxShadow: [
                  BoxShadow(color: Colors.black),
                ]),
              );
            }),
          ),
          Row(
            children: List.generate(3, (index) {
              return Container(
                child: Icon(
                  Icons.earbuds,
                  color: Colors.white,
                  size: 70,
                ),
                margin: EdgeInsets.all(25),
                padding: EdgeInsets.only(top: 5),
                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.black, boxShadow: [
                  BoxShadow(color: Colors.black),
                ]),
              );
            }),
          )
        ]);
  }
}
