import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../databasehelper/Databasehelper.dart';
import '../../../icons/icons.dart';
import 'ConfirmBox.dart';

class ExpenseCard extends StatelessWidget {
  final Expense exp;
  const ExpenseCard(this.exp, {super.key});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(exp.id),
      confirmDismiss: (_) async {
        showDialog(
          context: context,
          builder: (_) => ConfirmBox(exp: exp),
        );
      },
      child: Card(
        elevation: 4, // Adds a shadow for depth
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10), // Rounded corners
        ),
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0), // Margin around the card
        child: ListTile(
          contentPadding: const EdgeInsets.all(16.0), // Padding inside the card
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Colors.blueAccent, // Background color for the icon
            child: Icon(
              icons[exp.category],
              color: Colors.white, // Icon color
              size: 30, // Icon size
            ),
          ),
          title: Text(
            exp.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            DateFormat('MMMM dd, yyyy').format(exp.date),
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
          trailing: Text(
            NumberFormat.currency(locale: 'en_IN', symbol: '₹').format(exp.amount),
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.green, // Change color to green for positive amount
            ),
          ),
        ),
      ),
    );
  }
}
