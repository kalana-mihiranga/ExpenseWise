import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../../../databasehelper/Databasehelper.dart';

class ExpenseChart extends StatefulWidget {
  final String category;
  const ExpenseChart(this.category, {super.key});

  @override
  State<ExpenseChart> createState() => _ExpenseChartState();
}

class _ExpenseChartState extends State<ExpenseChart> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(builder: (_, db, __) {
      var maxY = db.calculateEntriesAndAmount(widget.category)['totalAmount']?.toDouble() ?? 0;
      var list = db.calculateWeekExpenses().reversed.toList();

      return Padding(
        padding: const EdgeInsets.all(16.0), // Padding around the chart
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Rounded corners for the card
          ),
          elevation: 8, // Elevated shadow for depth
          child: Column(
            children: [
              // Header for the chart
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                  gradient: LinearGradient(
                    colors: [Colors.blueAccent, Colors.redAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child:  Text(
                  'Weekly Expenses ',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              // Chart Area
              Expanded(
                child: BarChart(
                  BarChartData(
                    minY: 0,
                    maxY: maxY > 0 ? maxY * 1.2 : 1, // Adjust maxY to be 20% more than total
                    barGroups: list.asMap().entries.map(
                          (e) => BarChartGroupData(
                        x: e.key,
                        barRods: [
                          BarChartRodData(
                            toY: e.value['amount'].toDouble(),
                            width: 20.0,
                            color: _getColorForBar(e.value['amount']),
                            borderRadius: BorderRadius.circular(8), // Rounded corners for the bar
                          ),
                        ],
                      ),
                    ).toList(),
                    titlesData: FlTitlesData(
                      topTitles: AxisTitles(
                        drawBehindEverything: true,
                      ),
                      leftTitles: AxisTitles(
                        drawBehindEverything: true,
                      ),
                      rightTitles: AxisTitles(
                        drawBehindEverything: true,
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 38,
                          getTitlesWidget: (value, meta) {
                            // Format to display day names on the x-axis
                            return Text(
                              DateFormat.E().format(list[value.toInt()]['day']),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.black54,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    gridData: FlGridData(show: true, drawHorizontalLine: true), // Show grid lines
                    borderData: FlBorderData(
                      show: true,
                      border: Border(
                        bottom: BorderSide(color: Colors.black12, width: 1),
                        left: BorderSide(color: Colors.black12, width: 1),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  Color _getColorForBar(double amount) {
    if (amount <= 100) return Colors.green; // Low amount
    if (amount <= 300) return Colors.orange; // Medium amount
    return Colors.red; // High amount
  }
}
