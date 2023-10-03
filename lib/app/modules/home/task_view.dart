import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/constants/color_constants.dart';
import 'package:simple_prospect/app/modules/form/form_task/form_task_view.dart';

class TaskView extends ConsumerWidget {
  const TaskView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        // All Contact
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: Ei.all(10),
              child: Text(
                'Task Terupdate',
                textAlign: Ta.left,
                style: Gfont.fs(16).copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            ListView.separated(
              padding: Ei.sym(h: 10),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 1,
                        blurRadius: 1,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: Ei.only(b: 15, h: 10, t: 10),
                    dense: true,
                    tileColor: Colors.white,
                    style: ListTileStyle.list,
                    title: Row(
                      children: [
                        Text(
                          'Desc Task $index',
                          style: TextStyle(
                            color: ColorConstants.textPrimaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Spacer(),
                        Container(
                          width: 70,
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                            color: ColorConstants.textMediumColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            'Medium',
                            textAlign: Ta.center,
                            style: TextStyle(
                              fontSize: 10,
                              color: ColorConstants.secondaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    subtitle: Row(
                      children: [
                        Icon(
                          Ti.calendarCheck,
                          color: ColorConstants.textSecondaryColor,
                          size: 16,
                        ),
                        Text(
                          '23 Mei 2023',
                          style: TextStyle(
                            fontSize: 12,
                            color: ColorConstants.textSecondaryColor,
                          ),
                        ),
                        SizedBox(width: 5),
                        Icon(
                          Ti.clockCheck,
                          color: ColorConstants.textSecondaryColor,
                          size: 16,
                        ),
                        Text(
                          '23 Mei 2023',
                          style: TextStyle(
                            fontSize: 12,
                            color: ColorConstants.textSecondaryColor,
                          ),
                        ),
                        Spacer(),
                        Container(
                          child: IconButton(
                            icon: Icon(
                              Ti.trash,
                              color: ColorConstants.errorColor,
                              size: 20,
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  String editContact = 'Name $index';
                                  return AlertDialog(
                                    title: Text('Apakah anda yakin untuk hapus?'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [],
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: ColorConstants.primaryColor,
                                        ),
                                        child: Text('Hapus'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: ColorConstants.primaryColor,
                                        ),
                                        child: Text('Batal'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        Container(
                          child: IconButton(
                              icon: Icon(
                                Ti.edit,
                                color: ColorConstants.successColor,
                                size: 20,
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    String editContact = 'Name $index';
                                    return AlertDialog(
                                      title: Text('Edit Contact'),
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          TextField(
                                            decoration: InputDecoration(labelText: 'Name'),
                                            onChanged: (value) {
                                              editContact = value;
                                            },
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: ColorConstants.primaryColor,
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Save'),
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: ColorConstants.primaryColor,
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Cancel'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return SizedBox(height: 10);
              },
              itemCount: 4,
            ),
          ],
        ),
        Poslign(
          alignment: Alignment.bottomRight,
          child: Container(
            width: 50,
            height: 50,
            margin: Ei.only(b: 10, r: 10, t: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: ColorConstants.primaryColor,
            ),
            child: IconButton(
              icon: Icon(
                Ti.plus,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => FormTask(),
                ));
              },
            ),
          ),
        )
      ],
    );
  }
}
