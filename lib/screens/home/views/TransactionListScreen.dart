import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../Model/TransactionModel.dart';
import '../../../databasehelper/TransactionDatabaseHelper.dart';

class TransactionListScreen extends StatefulWidget {
  @override
  _TransactionListScreenState createState() => _TransactionListScreenState();
}

class _TransactionListScreenState extends State<TransactionListScreen> {
  late Future<List<TransactionModel>> _transactions;

  @override
  void initState() {
    super.initState();
    _fetchTransactions();
  }

  Future<void> _fetchTransactions() async {
    TransactionDatabaseHelper dbHelper = TransactionDatabaseHelper();
    _transactions = dbHelper.getTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transaction List'),
      ),
      body: FutureBuilder<List<TransactionModel>>(
        future: _transactions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While the data is being fetched, show a loading indicator
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Handle any errors
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            // If there's no data, show a message
            return Center(child: Text('No transactions found.'));
          }

          // Once we have the data, we can display it
          List<TransactionModel> transactions = snapshot.data!;
          return ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              TransactionModel transaction = transactions[index];
              return ListTile(
                leading: Icon(CupertinoIcons.memories), // You can set a dynamic icon here
                title: Text(transaction.name),
                subtitle: Text('${transaction.place} - ${transaction.totalAmount}'),
                trailing: Text(transaction.date),
              );
            },
          );
        },
      ),
    );
  }
}
