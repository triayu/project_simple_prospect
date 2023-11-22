import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:lazyui/lazyui.dart' hide Gfont, gfont;
import 'package:simple_prospect/app/constants/color_constants.dart';

import 'package:simple_prospect/app/data/models/task_model.dart';
import 'package:simple_prospect/app/modules/form/form_task/form_task_view.dart';
import 'package:simple_prospect/app/providers/task/task_provider.dart';

class TaskView extends ConsumerWidget {
  const TaskView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        // TASK
        Consumer(builder: (context, ref, _) {
          // nama asyn data ini cuma nama variable, kamu bisa ubah ubah dengan nama apapun
          final asyncData = ref.watch(taskProvider);

          return asyncData.when(
            data: (data) {
              if (data.isEmpty) {
                return LzNoData(message: 'Opps! No data found', onTap: () => ref.read(taskProvider.notifier).getTask());
              }

              return ListView.separated(
                padding: Ei.sym(h: 10, v: 20),
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  List<TaskModel> datas = data;

                  int id = datas[index].id ?? 0;
                  String title = datas[index].title ?? '';
                  String note = datas[index].note ?? '';
                  String priority = datas[index].priority ?? '';
                  DateTime reminder = datas[index].reminder ?? DateTime.now();
                  // DateTime reminder = datas[index].reminder ?? DateTime.now();

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
                              title,
                              style: TextStyle(
                                color: ColorConstants.textPrimaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
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
                                priority,
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
                            // Text(
                            //   note,
                            //   style: TextStyle(
                            //     color: ColorConstants.textSecondaryColor,
                            //     fontSize: 12,
                            //   ),
                            // ),
                            // Icon(
                            //   Ti.calendarCheck,
                            //   color: ColorConstants.textSecondaryColor,
                            //   size: 16,
                            // ),
                            Text(
                              reminder.toString(),
                              style: TextStyle(
                                fontSize: 12,
                                color: ColorConstants.textSecondaryColor,
                              ),
                            ),

                            SizedBox(width: 5),
                            // Icon(
                            //   Ti.clockCheck,
                            //   color: ColorConstants.textSecondaryColor,
                            //   size: 16,
                            // ),
                            // Text(
                            //   '12.30',
                            //   style: TextStyle(
                            //     fontSize: 12,
                            //     color: ColorConstants.textSecondaryColor,
                            //   ),
                            // ),
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
                                        return LzConfirm(
                                          title: "Apakah Anda Yakin Untuk Menghapus Data Ini",
                                          onConfirm: () {
                                            logg('Tekan Hapus');
                                            logg(id);
                                            ref.read(taskProvider.notifier).delTask(id);
                                          },
                                        );
                                      });
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
                                        String editTask = 'Name $index';
                                        return AlertDialog(
                                          title: Text('Edit Task'),
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              TextField(
                                                decoration: InputDecoration(labelText: 'Name'),
                                                onChanged: (value) {
                                                  editTask = value;
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
                      ));
                },
                separatorBuilder: (context, index) {
                  return SizedBox(height: 10);
                },
                itemCount: data.length,
              );
            },
            error: (error, _) {
              return LzNoData(message: 'Opps! $error');
            },
            loading: () {
              return SizedBox(
                height: 90,
                child: ListView.builder(
                  itemCount: 10,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Skeleton(radius: 10, margin: Ei.all(10), size: [100, 50]);
                  },
                ),
              );
            },
          );
        }),

        Poslign(
          alignment: Alignment.bottomRight,
          child: InkTouch(
            padding: Ei.all(10),
            margin: Ei.all(10),
            radius: Br.circle,
            color: ColorConstants.primaryColor,
            child: Icon(
              Ti.plus,
              color: Colors.white,
              size: 40,
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => FormTask(),
              ));
            },
          ),
        ),
      ],
    );
  }
}
