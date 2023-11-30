import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lazyui/lazyui.dart';
import 'package:simple_prospect/app/constants/color_constants.dart';
import 'package:simple_prospect/app/data/models/task_model.dart';

class TaskDetailView extends ConsumerWidget {
  final TaskModel task;

  const TaskDetailView({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget buildCard(String title, String content) {
      return Card(
        elevation: 5,
        color: ColorConstants.card,
        child: Padding(
          padding: Ei.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: ColorConstants.textPrimaryColor,
                ),
              ),
              Text(
                ' $content',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Task Detail'),
      ),
      body: Padding(
        padding: Ei.all(10),
        child: ListView(
          children: [
            Text(
              'Task',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            buildCard('Title', '${task.title}'),
            buildCard('Note', '${task.note}'),
            SizedBox(height: 30),
            Text(
              'Details Task',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            buildCard('Relate To', '${task.relateTo}'),
            buildCard('Priority', '${task.priority}'),
            buildCard(
              'Reminder',
              '${task.reminder}',
            ),
          ],
        ),
      ),
    );
  }
}
