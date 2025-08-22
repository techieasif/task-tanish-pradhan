import 'package:flutter/material.dart';
import 'package:task/core/reusable_widgets/add_todo_bottom_sheet.dart';

Future<String?> addTodoBottomSheet ({
  required BuildContext context,
}) {
  return showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (context) {
      return AddTodoBottomSheet();
    },
  );
}