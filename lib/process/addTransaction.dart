import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Model/TransactionModel.dart'; // Ensure this path is correct
import '../databasehelper/TransactionDatabaseHelper.dart'; // Import your database helper class

class AddTransactionForm extends StatefulWidget {
  @override
  _AddTransactionFormState createState() => _AddTransactionFormState();
}

class _AddTransactionFormState extends State<AddTransactionForm> {
  final _formKey = GlobalKey<FormState>();

  String name = '';
  String place = '';
  String totalAmount = '';
  String date = '';
  String icon = 'shopping'; // Default icon for simplicity
  String color = 'blue'; // Default color

  Future<TransactionModel> insertTransaction(TransactionModel transaction) async {
    final db = await TransactionDatabaseHelper().database; // Access the singleton instance
    final id = await db.insert('transactions', transaction.toMap()); // Insert transaction and get new id
    return transaction.copyWith(id: id); // Return the transaction with the new id
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Wrap your form in a Scaffold
      appBar: AppBar(
        title: Text('Add Transaction'), // Title of the app bar
      ),
      body: SingleChildScrollView( // Enable scrolling
        child: Form(
          key: _formKey,
          child: Padding( // Add padding for better layout
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                  onChanged: (val) => setState(() => name = val),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Place'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a place';
                    }
                    return null;
                  },
                  onChanged: (val) => setState(() => place = val),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Total Amount'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an amount';
                    }
                    return null;
                  },
                  onChanged: (val) => setState(() => totalAmount = val),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Date (YYYY-MM-DD)'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a date';
                    }
                    return null;
                  },
                  onChanged: (val) => setState(() => date = val),
                ),
                SizedBox(height: 20), // Add some spacing
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      TransactionModel newTransaction = TransactionModel(
                        name: name,
                        place: place,
                        totalAmount: totalAmount,
                        date: date,
                        icon: icon,
                        color: color,
                      );

                      // Insert transaction into the database
                      await insertTransaction(newTransaction);

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Transaction Added!'),
                      ));

                      // Optionally, clear the form after adding the transaction
                      _formKey.currentState!.reset();
                    }
                  },
                  child: Text('Add Transaction'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
