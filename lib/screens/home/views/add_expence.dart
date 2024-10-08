import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:intl/intl.dart';

import '../../../data/data.dart'; // For formatting currency

class AddExpense extends StatefulWidget {
  const AddExpense({super.key});

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  TextEditingController _dateController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  Color _selectedColor = Colors.green; // Default color for the category

  List<String> categories = ['Food', 'Transport']; // Initial categories
  List<IconData> categoryIcons = [CupertinoIcons.car, CupertinoIcons.car]; // Initial icons
  IconData _selectedIcon = CupertinoIcons.cube_box; // Default icon for new categories

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

  // Function to open the modal for creating or editing a category
  void _showCategoryModal({String? categoryToEdit}) {
    String categoryName = categoryToEdit ?? '';
    Color categoryColor = _selectedColor;
    IconData selectedIcon = _selectedIcon;

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Wrap(
              children: [
                Center(
                  child: Text(
                    categoryToEdit == null
                        ? "Create New Category"
                        : "Edit Category",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.green[800],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Category Name Input
                TextFormField(
                  initialValue: categoryName,
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

                // Icon Picker
                Row(
                  children: [
                    Text(
                      "Select Icon:",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        _showIconPicker(context, (IconData selected) {
                          setState(() {
                            selectedIcon = selected;
                          });
                        });
                      },
                      child: Icon(
                        selectedIcon,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Delete Category Button (visible only when editing an existing category)
                if (categoryToEdit != null)
                  Center(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          int index = categories.indexOf(categoryToEdit);
                          categories.removeAt(index);
                          categoryIcons.removeAt(index);
                          Navigator.pop(context);
                        });
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.red, // Red for delete button
                      ),
                      child: Text("Delete Category"),
                    ),
                  ),
                const SizedBox(height: 16),

                // Save Category Button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (categoryName.isNotEmpty) {
                        setState(() {
                          if (categoryToEdit == null) {
                            // Adding a new category
                            categories.add(categoryName);
                            categoryIcons.add(selectedIcon);
                          } else {
                            // Editing an existing category
                            int index = categories.indexOf(categoryToEdit);
                            categories[index] = categoryName;
                            categoryIcons[index] = selectedIcon;
                          }
                          Navigator.pop(context);
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 32, vertical: 14),
                      backgroundColor: Colors.green, // Button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16), // Rounded button
                      ),
                    ),
                    child: Text(
                      categoryToEdit == null ? 'Save Category' : 'Update Category',
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
          ),
        );
      },
    );
  }

  // Function to show the Icon Picker dialog
  void _showIconPicker(BuildContext context, Function(IconData) onIconSelected) {
    List<IconData> iconOptions = [
      CupertinoIcons.car,
      CupertinoIcons.cube_box,
      CupertinoIcons.home,
      CupertinoIcons.shopping_cart,
      CupertinoIcons.heart_fill,
      CupertinoIcons.airplane,
      // Add more icons as needed
    ];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pick an icon'),
          content: SingleChildScrollView(
            child: Wrap(
              spacing: 10,
              runSpacing: 10,
              children: iconOptions.map((icon) {
                return GestureDetector(
                  onTap: () {
                    onIconSelected(icon);
                    Navigator.pop(context);
                  },
                  child: Icon(icon, size: 36),
                );
              }).toList(),
            ),
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
                  fontFamily: 'Roboto', // A sleek, modern font for headers
                  fontSize: 22, // Larger for prominence
                  fontWeight: FontWeight.w500, // Semi-bold for emphasis
                  color: Colors.green[800], // Dark green for better visibility
                ),
              ),
            ),
            const SizedBox(height: 20), // Space between header and form fields

            // Date Input Field
            TextFormField(
              controller: _dateController,
              readOnly: true,
              decoration: InputDecoration(
                labelText: 'Date',
                hintText: 'Select date',
                prefixIcon: Icon(Icons.calendar_today),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              onTap: () => _selectDate(context),
            ),
            const SizedBox(height: 16),

            // Amount Input Field
            TextFormField(
              controller: _amountController,
              decoration: InputDecoration(
                labelText: 'Amount',
                hintText: 'Enter amount',
                prefixIcon: Icon(Icons.attach_money),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _amountController.text = _formatAmount(value);
                  _amountController.selection = TextSelection.fromPosition(TextPosition(offset: _amountController.text.length));
                });
              },
            ),
            const SizedBox(height: 16),

            // Category Selector
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Select Category',
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
              items: categories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Row(
                    children: [
                      Icon(
                        categoryIcons[categories.indexOf(category)], // Get the corresponding icon
                        color: Colors.green[700],
                      ),
                      SizedBox(width: 10),
                      Text(category),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {},
              hint: Text('Choose a category'),
            ),
            const SizedBox(height: 20),

            // Submit Button
            Center(
              child: ElevatedButton(
                onPressed: () {

                  setState(() {
                    myTransactionData.add({
                      'icon': _selectedIcon, // Add the selected icon
                      'color': _selectedColor, // Add the selected color
                      'name': categories[0], // Assuming first category is selected, you can enhance it later
                      'totalAmount': '-${_amountController.text}', // Add amount
                      'date': _dateController.text, // Add date
                    });

                    // Clear the input fields after submission
                    _amountController.clear();
                    _dateController.clear();
                  });

                  // Logic for saving the expense can go here
                  print("Expense Added: ${_amountController.text} on ${_dateController.text}");
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  'Add Expense',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
