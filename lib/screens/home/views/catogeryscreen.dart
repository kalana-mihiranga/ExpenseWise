import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../process/addexpense.dart';
import '../../view/fetchcatogery.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});
  static const name = '/category_screen'; // for routes

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Enhanced AppBar with gradient background
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
            gradient: const LinearGradient(
              colors: [Colors.blueAccent, Colors.red],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),

      // Adding the Profile and Total Balance section
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile section with welcome message
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.blue,
                          ),
                        ),
                        const Icon(
                          CupertinoIcons.person_fill,
                          color: Colors.white,
                          size: 30,
                        ),
                      ],
                    ),
                    const SizedBox(width: 12),
                     Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Kalana Mi",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed: () {
                      // Add functionality for settings button
                    },
                    icon: const Icon(CupertinoIcons.settings),
                    color: Colors.black54,
                  ),
                ),
              ],
            ),


            const Expanded(child: CategoryFetcher()),
          ],
        ),
      ),

      // Enhanced Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => const ExpenseForm(),
          );
        },
        shape: const CircleBorder(),
        child: const Icon(
          CupertinoIcons.add,
          size: 28,
        ),

        backgroundColor: Colors.blueAccent,
        splashColor: Colors.lightGreen,
      ),
    );
  }
}
