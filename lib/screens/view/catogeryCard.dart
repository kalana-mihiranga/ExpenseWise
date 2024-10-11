import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../databasehelper/Databasehelper.dart';
import '../home/views/expenseScreen.dart';

class CategoryCard extends StatelessWidget {
  final ExpenseCategory category;
  const CategoryCard(this.category, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // Adds shadow to the card
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12), // Rounded corners
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16), // Margin for spacing
      child: ListTile(
        onTap: () {
          Navigator.of(context).pushNamed(
            ExpenseScreen.name,
            arguments: category.title, // for expensescreen.
          );
        },
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.blue.shade200, // Background color for icon
            child: Icon(
              category.icon,
              color: Colors.white, // Icon color
            ),
          ),
        ),
        title: Text(
          category.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18, // Increased font size for title
          ),
        ),
        subtitle: Text(
          'Entries: ${category.entries}',
          style: const TextStyle(color: Colors.grey), // Subtitle color
        ),
        trailing: Text(
          NumberFormat.currency(locale: 'en_IN', symbol: '').format(category.totalAmount),
          style: const TextStyle(
            fontWeight: FontWeight.w600, // Bold for trailing amount
            color: Colors.green, // Color for total amount
          ),
        ),
      ),
    );
  }
}
