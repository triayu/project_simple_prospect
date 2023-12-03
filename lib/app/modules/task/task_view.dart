import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart' hide Gfont, gfont;
import '../../constants/color_constants.dart';
import '../../core/text_theme.dart';
import '../../data/models/task_model.dart';
import '../../providers/task/task_provider.dart';
import 'form_task_view.dart';
import 'task_detail_view.dart';

class TaskView extends ConsumerWidget {
  const TaskView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      clipBehavior: Clip.none,
      fit: StackFit.expand,
      children: [
        Column(
          children: [
            // TASK =========
            Expanded(
              child: Consumer(
                builder: (context, ref, _) {
                  final asyncData = ref.watch(taskProvider);

                  return asyncData.when(
                    data: (data) {
                      if (data.isEmpty) {
                        return LzNoData(
                          message: 'Opps! No data found',
                          onTap: () => ref.read(taskProvider.notifier).getTask(),
                        );
                      }

                      return Refreshtor(
                        onRefresh: () => ref.read(taskProvider.notifier).getTask(),
                        child: ListView.separated(
                          padding: Ei.only(t: 10, h: 10, b: 50),
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            final key = GlobalKey();

                            TaskModel datas = data[index];
                            int id = datas.id ?? 0;
                            String tittle = datas.title ?? '';
                            String reminder = datas.reminder.format('dd MMM yyyy');
                            String priority = datas.priority ?? '';

                            return InkTouch(
                              elevation: 1,
                              key: key,
                              color: Colors.white,
                              onTap: () {
                                final options = ['Lihat Detail', 'Edit', 'Hapus']
                                    .options(icons: [Ti.infoCircle, Ti.edit, Ti.trash]);
                                DropX.show(key.currentContext, options: options, onSelect: (val) {
                                  if (val.index == 0) {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => TaskDetailView(task: datas),
                                      ),
                                    );
                                  }

                                  if (val.index == 1) {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => FormTask(
                                          data: datas,
                                        ),
                                      ),
                                    );
                                  }

                                  if (val.index == 2) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return LzConfirm(
                                          title: "Apakah Anda Yakin Untuk Menghapus Data Ini?",
                                          titleSize: 15,
                                          onConfirm: () {
                                            ref.read(taskProvider.notifier).deltask(id);
                                          },
                                        );
                                      },
                                    );
                                  }
                                });
                              },
                              padding: Ei.all(5),
                              child: ListTile(
                                dense: true,
                                minLeadingWidth: 0,
                                leading: Icon(
                                  Ti.notes,
                                  color: ColorConstants.primaryColor,
                                  size: 30,
                                ),
                                title: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        tittle.ucwords,
                                        style: Gfont.autoSizeText(context, FontSizeManager.getBodyFontSize()),
                                        maxLines: 3,
                                      ),
                                    ),
                                    Container(
                                      width: 70,
                                      padding: Ei.all(3),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: getPriorityColor(priority),
                                      ),
                                      child: Text(
                                        priority,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: ColorConstants.secondaryColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                subtitle: Text(
                                  reminder,
                                  style: Gfont.autoSizeText(context, FontSizeManager.getCaptionFontSize()),
                                ),
                                trailing: Icon(Icons.more_vert, color: ColorConstants.primaryColor),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 10);
                          },
                          itemCount: data.length,
                        ),
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
                },
              ),
            )
          ],
        ),
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
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => FormTask(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

Color getPriorityColor(String priority) {
  switch (priority.toLowerCase()) {
    case 'high':
      return Colors.red;
    case 'medium':
      return Colors.orange;
    case 'low':
      return Colors.green;
    default:
      return Colors.grey;
  }
}

