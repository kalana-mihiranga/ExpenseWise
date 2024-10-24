import 'package:flutter/material.dart';
import '../FirebaseSyncService.dart';


class SyncController with ChangeNotifier {
  final FirebaseSyncService _syncService = FirebaseSyncService();

  // Initialize syncing when the app starts
  Future<void> initializeSync(Database db) async {
    await _syncService.syncCategories(db);
    await _syncService.syncExpenses(db);
  }
}
