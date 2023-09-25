import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/config/font.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/constants/color_constants.dart';
import 'package:simple_prospect/app/modules/form/form_task/form_task_view.dart';

class TaskView extends ConsumerWidget {
  const TaskView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Col(
      children: [
        // All Contact
        Col(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Padding(
                  padding: Ei.all(10),
                  child: Text(
                    'Task Terupdate',
                    style: Gfont.fs(16).copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FormTask(),
                      ),
                    );
                  },
                  child: Container(
                    height: 30,
                    width: 70,
                    margin: EdgeInsets.only(bottom: 10, right: 10, top: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorConstants.primaryColor,
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 3),
                          child: Icon(
                            Ti.plus,
                            size: 15,
                            color: ColorConstants.secondaryColor,
                          ),
                        ),
                        Text(
                          'Add Task',
                          style: TextStyle(
                            color: ColorConstants.secondaryColor,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            ListView.separated(
              padding: Ei.sym(h: 10),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Container(
                  height: 60,
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
                    contentPadding: Ei.only(b: 15, h: 10),
                    dense: true,
                    tileColor: Colors.white,
                    style: ListTileStyle.list,
                    title: Text(
                      'Desc Task $index',
                      style: TextStyle(
                        color: ColorConstants.textPrimaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
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
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
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
                            },
                          ),
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
      ],
    );
  }
}
