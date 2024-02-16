import 'package:flutter/material.dart';

class DeleteMenuCategoryConfirmationDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const DeleteMenuCategoryConfirmationDialog({Key? key, required this.onConfirm}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.purple.shade50,
      title: const Text('Confirm Deletion'),
      content: const Text('Are you sure you want to delete this category?'),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: onConfirm,
          child: Text('Delete'),
        ),
      ],
    );
  }
}
