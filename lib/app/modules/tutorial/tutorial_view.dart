import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/config/font.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/constants/color_constants.dart';

class TutorialView extends ConsumerWidget {
  const TutorialView({Key? key}) : super(key: key);

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
                Container(
                  height: 30,
                  width: 70,
                  margin: Ei.only(b: 10, r: 10, t: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: ColorConstants.primaryColor,
                  ),
                  child: Row(
                    children: [
                      InkResponse(
                        onTap: () {
                          // Nav
                        },
                        child: Container(
                          padding: Ei.only(l: 3),
                          child: Icon(
                            Ti.plus,
                            size: 15,
                            color: ColorConstants.secondaryColor,
                          ),
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
                    dense: true,
                    tileColor: Colors.white,
                    style: ListTileStyle.list,
                    title: Text(
                      'Desc Task $index',
                      style: TextStyle(
                        color: ColorConstants.primaryColor,
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
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.red,
                          ),
                          child: IconButton(
                            icon: Icon(
                              Ti.trash,
                              color: Colors.white,
                              size: 15,
                            ),
                            onPressed: () {},
                          ),
                        ),
                        SizedBox(width: 10),
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.green,
                          ),
                          child: IconButton(
                            icon: Icon(
                              Ti.edit,
                              color: Colors.white,
                              size: 15,
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
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Save'),
                                      ),
                                      ElevatedButton(
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
