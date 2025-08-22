import 'package:flutter/material.dart';

class AddTodoBottomSheet extends StatefulWidget {
  // final Function() buttonPressed;

  const AddTodoBottomSheet({
    super.key,
    // required this.buttonPressed,
  });

  @override
  State<AddTodoBottomSheet> createState() => _AddTodoBottomSheetState();
}

class _AddTodoBottomSheetState extends State<AddTodoBottomSheet> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 10.0,
          children: [
            Text("Add Todo"),
            TextField(controller: controller),
            Align(
              alignment: AlignmentDirectional.center,
              child: TextButton(
                onPressed: () {
                  if (controller.text.isNotEmpty) {
                    Navigator.pop(context, controller.text);
                  } else {
                    Navigator.pop(context);
                  }
                },
                child: Text("Add"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
