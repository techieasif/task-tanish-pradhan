import 'package:flutter/material.dart';

class TodoItem extends StatelessWidget {
  final String todo;
  final bool isSelected;
  final Function(bool? newValue) onChanged;
  final VoidCallback deletePressed;
  final VoidCallback? addButtonPressed;

  const TodoItem({
    super.key,
    required this.todo,
    required this.isSelected,
    required this.onChanged,
    required this.deletePressed,
    this.addButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(value: isSelected, onChanged: onChanged),
      title: Text(todo),
      horizontalTitleGap: 0,
      trailing: addButtonPressed != null
          ? Row(
        spacing: 10.0,
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: addButtonPressed,
            child: Icon(Icons.add, color: Colors.black),
          ),
          InkWell(
            onTap: deletePressed,
            child: Icon(Icons.delete_outline, color: Colors.red),
          ),
        ],
      )
          : InkWell(
        onTap: deletePressed,
        child: Icon(Icons.delete_outline, color: Colors.red),
      ),
    );
  }
}
