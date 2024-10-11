import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../databasehelper/Databasehelper.dart';
import '../home/stats/TotalChart.dart';
import '../home/stats/catogeryList.dart';
import '../home/views/AllExpenses.dart';

class CategoryFetcher extends StatefulWidget {
  const CategoryFetcher({super.key});

  @override
  State<CategoryFetcher> createState() => _CategoryFetcherState();
}

class _CategoryFetcherState extends State<CategoryFetcher> {
  late Future _categoryList;

  Future _getCategoryList() async {
    final provider = Provider.of<DatabaseProvider>(context, listen: false);
    return await provider.fetchCategories();
  }

  @override
  void initState() {
    super.initState();
    // Fetch the list and set it to _categoryList
    _categoryList = _getCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _categoryList,
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          // If connection is done, check for errors or return the result
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 250.0,
                    child: TotalChart(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Expenses',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20, // Increased font size for better visibility
                          color: Colors.blueAccent, // Change color to blue
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.blueAccent, // Color for the button
                          textStyle: const TextStyle(
                            fontSize: 16, // Font size for button text
                            fontWeight: FontWeight.bold, // Bold button text
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed(AllExpenses.name);
                        },
                        child: const Text('View All'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0), // Spacing between sections
                  const Expanded(child: CategoryList()),
                ],
              ),
            );
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
