import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../databasehelper/Databasehelper.dart';

class TotalChart extends StatefulWidget {
  const TotalChart({super.key});

  @override
  State<TotalChart> createState() => _TotalChartState();
}

class _TotalChartState extends State<TotalChart> {
  bool _isExpensesVisible = true; // State variable to control expenses visibility

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(builder: (_, db, __) {
      var list = db.categories;
      var total = db.calculateTotalExpenses();

      return Container(
        width: MediaQuery.of(context).size.width * 0.95,
        padding: const EdgeInsets.all(24.0),
        margin: const EdgeInsets.symmetric(vertical: 16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade300,
              Colors.red.shade300,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              flex: 60,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_isExpensesVisible) // Show total expenses conditionally
                      FittedBox(
                        alignment: Alignment.center,
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'Total Expenses: ${NumberFormat.currency(locale: 'en_IN', symbol: '').format(total)}',
                          textScaleFactor: 1.5,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    const SizedBox(height: 12.0),
                    ...list.map(
                          (e) => Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Row(
                          children: [
                            Container(
                              width: 8.0,
                              height: 8.0,
                              color: Colors.primaries[list.indexOf(e) % Colors.primaries.length],
                            ),
                            const SizedBox(width: 8.0),
                            Expanded(
                              child: Text(
                                e.title,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8.0),
                            Text(
                              total == 0
                                  ? '0%'
                                  : '${((e.totalAmount / total) * 100).toStringAsFixed(2)}%',
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 20.0),
            Expanded(
              flex: 40,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isExpensesVisible = !_isExpensesVisible; // Toggle visibility
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: _isExpensesVisible ? 200 : 300, // Increase height for pie chart
                  child: PieChart(
                    PieChartData(
                      centerSpaceRadius: 20.0,
                      sections: total != 0
                          ? list
                          .map(
                            (e) => PieChartSectionData(
                          showTitle: false,
                          value: e.totalAmount,
                          color: Colors.primaries[list.indexOf(e) % Colors.primaries.length],
                        ),
                      )
                          .toList()
                          : list
                          .map(
                            (e) => PieChartSectionData(
                          showTitle: false,
                          color: Colors.primaries[list.indexOf(e) % Colors.primaries.length],
                        ),
                      )
                          .toList(),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
