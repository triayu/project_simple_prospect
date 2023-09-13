import 'package:flutter/material.dart';

class WiDrawer extends StatelessWidget {
  const WiDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: SingleChildScrollView(
          child: Column(children: [
            Text(
              'Prospects',
              style: TextStyle(fontSize: 24),
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 4,
                itemBuilder: (context, index) {
                  List<String> tittles = ['Home', 'Prospect Group', 'Rating', 'Suppoort/Feedbacks'];

                  return ListTile(
                    title: Text(tittles[index]),
                  );
                })
          ]),
        ),
      ),
    );
  }
}
