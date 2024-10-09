import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../databasehelper/Databasehelper.dart';
import '../icons/icons.dart'; // Assuming you have a map of icons in this file

class InputForm extends StatefulWidget {
  final String? category; // Add category as an optional parameter

  const InputForm({super.key, this.category});

  @override
  State<InputForm> createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  late String _selectedCategory;

  @override
  void initState() {
    super.initState();
    // Initialize selected category with the category passed from the previous screen
    _selectedCategory = widget.category ?? 'Other';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.blue, // Change the header color
            accentColor: Colors.blue, // Change the accent color
            colorScheme: ColorScheme.light(primary: Colors.blue), // Change the header color
            buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child ?? const Text(''),
        );
      },
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DatabaseProvider>(context, listen: false);

    return AlertDialog(
      title: const Text('Add Expense', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
      backgroundColor: Colors.transparent, // Make background transparent
      content: SizedBox(
        width: double.maxFinite, // To take full width
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20), // Add padding for content
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9), // Slightly white background for the content
              borderRadius: BorderRadius.circular(10.0), // Rounded corners
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title
                TextField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Title of Expense',
                    labelStyle: const TextStyle(color: Colors.blue),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),

                // Amount
                TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Amount of Expense',
                    labelStyle: const TextStyle(color: Colors.blue),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.blue, width: 2.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                const SizedBox(height: 20.0),

                // Date Picker
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate != null
                            ? DateFormat('MMMM dd, yyyy').format(_selectedDate!)
                            : 'Select Date',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                    IconButton(
                      onPressed: _pickDate,
                      icon: const Icon(Icons.calendar_today, color: Colors.blue),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),

                // Category Dropdown
                Row(
                  children: [
                    const Expanded(child: Text('Category')),
                    Expanded(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        items: icons.keys
                            .map(
                              (category) => DropdownMenuItem<String>(
                            value: category,
                            child: Text(category),
                          ),
                        )
                            .toList(),
                        value: _selectedCategory,
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              _selectedCategory = newValue;
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),

                // Button Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Cancel Button
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      child: const Text('Cancel'),
                    ),
                    // Submit Button
                    ElevatedButton.icon(
                      onPressed: () {
                        if (_titleController.text.isNotEmpty &&
                            _amountController.text.isNotEmpty &&
                            _selectedDate != null) {
                          final newExpense = Expense(
                            id: 0,
                            title: _titleController.text,
                            amount: double.parse(_amountController.text),
                            date: _selectedDate!,
                            category: _selectedCategory,
                          );

                          provider.addExpense(newExpense);
                          Navigator.of(context).pop(); // Close the dialog
                        }
                      },
                      icon: const Icon(Icons.add),
                      label: const Text('Add Expense'),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
