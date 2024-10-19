import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../databasehelper/Databasehelper.dart';

class ConfirmBox extends StatelessWidget {
  const ConfirmBox({
    Key? key,
    required this.exp,
  }) : super(key: key);

  final Expense exp;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DatabaseProvider>(context, listen: false);
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Rounded corners for the dialog
      ),
      title: Text(
        'Delete ${exp.title}?',
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        'Are you sure you want to delete this expense?',
        style: const TextStyle(
          fontSize: 16,
          color: Colors.grey,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false); // Don't delete
          },
          child: const Text(
            'Don\'t delete',
            style: TextStyle(
              color: Colors.redAccent, // Red color for emphasis
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(true); // Delete
            provider.deleteExpense(exp.id, exp.category, exp.amount);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent, // Button background color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8), // Rounded corners for the button
            ),
          ),
          child: const Text(
            'Delete',
            style: TextStyle(
              color: Colors.white, // Text color
            ),
          ),
        ),
      ],
    );
  }
}
