import 'package:cloud_firestore/cloud_firestore.dart';


class FirebaseSyncService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Sync categories to Firestore
  Future<void> syncCategories(Database db) async {
    final categories = await db.query('categoryTable');

    for (final category in categories) {
      await firestore.collection('categories').doc(category['title']).set({
        'title': category['title'],
        'entries': category['entries'],
        'totalAmount': category['totalAmount'],
      });
    }
  }

  // Sync expenses to Firestore
  Future<void> syncExpenses(Database db) async {
    final expenses = await db.query('expenseTable');

    for (final expense in expenses) {
      await firestore.collection('expenses').doc(expense['id'].toString()).set({
        'id': expense['id'],
        'title': expense['title'],
        'amount': expense['amount'],
        'date': expense['date'],
        'category': expense['category'],
      });
    }
  }
}
