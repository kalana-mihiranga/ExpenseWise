import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart'; // For color picker

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  TextEditingController _dateController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  TextEditingController _categoryController = TextEditingController();
  Color _selectedColor = Colors.green; // Default color for the category

  List<String> categories = ['Food', 'Transport']; // Initial categories

  // Function to show the Date Picker
  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

  // Function to format the amount with thousand separators
  String _formatAmount(String amount) {
    if (amount.isEmpty) return '';
    final formatter = NumberFormat("#,###");
    return formatter.format(int.parse(amount.replaceAll(',', '')));
  }

  // Function to open the modal for creating a new category
  void _showCategoryModal() {
    String categoryName = '';
    Color categoryColor = Colors.green;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom, left: 16, right: 16, top: 16),
          child: Wrap(
            children: [
              Text(
                "Create New Category",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Category Name
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Category Name',
                  hintText: 'Enter category name',
                  prefixIcon: Icon(CupertinoIcons.pencil_outline),
                  filled: true,
                  fillColor: Colors.grey[100],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                onChanged: (value) {
                  categoryName = value;
                },
              ),
              const SizedBox(height: 16),

              // Color Picker
              Row(
                children: [
                  Text(
                    "Select Color:",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Pick a color'),
                            content: SingleChildScrollView(
                              child: BlockPicker(
                                pickerColor: categoryColor,
                                onColorChanged: (Color color) {
                                  setState(() {
                                    categoryColor = color;
                                  });
                                },
                              ),
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                child: const Text('Done'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: CircleAvatar(
                      backgroundColor: categoryColor,
                      radius: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Save Category Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    if (categoryName.isNotEmpty) {
                      setState(() {
                        categories.add(categoryName);
                        Navigator.pop(context);
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                    backgroundColor: Colors.green, // Button color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16), // Rounded button
                    ),
                  ),
                  child: Text(
                    'Save Category',
                    style: TextStyle(
                      fontSize: 18, // Slightly larger for readability
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // White text for contrast
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Expense Wise',
          style: TextStyle(
            fontFamily: 'Pacifico', // A modern, elegant font
            fontSize: 26, // Slightly larger for prominence
            fontWeight: FontWeight.w600, // Semi-bold for better readability
            color: Colors.white, // White text for contrast
            letterSpacing: 1.5, // Increased letter spacing for a cleaner feel
            shadows: [
              Shadow(
                blurRadius: 4.0,
                color: Colors.black.withOpacity(0.4), // Soft shadow for depth
              ),
            ],
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.greenAccent, Colors.green],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _showCategoryModal, // Opens the modal for adding a category
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0), // Add padding around the form
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align everything to the start
          children: [
            // Form Header
            Center(
              child: Text(
                "Add Expenses",
                style: TextStyle(
                  fontSize: 24, // Larger for prominence
                  fontWeight: FontWeight.bold,
                  color: Colors.green, // Use accent color for the title
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Category Dropdown
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Category',
                prefixIcon: Icon(CupertinoIcons.tag),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              items: categories.map((category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (value) {
                _categoryController.text = value!;
              },
            ),
            const SizedBox(height: 16),

            // Amount Input Field with Thousand Separators
            TextFormField(
              controller: _amountController,
              keyboardType: TextInputType.number, // Numeric input type for amounts
              decoration: InputDecoration(
                labelText: 'Amount',
                hintText: 'Enter amount',
                prefixIcon: Icon(CupertinoIcons.money_dollar),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                String formattedAmount = _formatAmount(value);
                _amountController.value = TextEditingValue(
                  text: formattedAmount,
                  selection: TextSelection.collapsed(offset: formattedAmount.length),
                );
              },
            ),
            const SizedBox(height: 16),

            // Date Input Field with DatePicker
            TextFormField(
              controller: _dateController,
              readOnly: true, // Make the field read-only
              onTap: () {
                _selectDate(context); // Show Date Picker when tapped
              },
              decoration: InputDecoration(
                labelText: 'Date',
                hintText: 'Select date',
                prefixIcon: Icon(CupertinoIcons.calendar),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Save Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Add save functionality
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  backgroundColor: Colors.green, // Button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16), // Rounded button
                  ),
                ),
                child: Text(
                  'Save',
                  style: TextStyle(
                    fontSize: 18, // Slightly larger for readability
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // White text for contrast
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
