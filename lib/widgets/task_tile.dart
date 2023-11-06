import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
  final String task;
  final bool isCompleted;
  final VoidCallback onDelete;
  final VoidCallback onToggle;

  const TaskTile({
    required this.task,
    required this.isCompleted,
    required this.onDelete,
    required this.onToggle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: isCompleted,
        onChanged: (bool? value) {
          onToggle();
        },
      ),
      title: Text(task.replaceAll(RegExp(r'^\[x\] '), '')),
      trailing: IconButton(
        icon: const Icon(Icons.delete),
        onPressed: onDelete,
      ),
    );
  }
}
