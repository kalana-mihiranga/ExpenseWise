import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child:
        Column(
          children: [
            Container(

              child: Row(
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
                                  shape: BoxShape.circle, color: Colors.blue),
                            ),
                            Icon(
                              CupertinoIcons.person_fill,
                              color: Colors.black,
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                "welcome",
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "Kalana Mi",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Container(
                      child: Row(
                        children: [
                          Column(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(CupertinoIcons.settings),
                              ),
                            ],
                          )
                        ],
                      ),

                    ),
              ]),

            ),
            SizedBox(height: 20,),
            Container(
              width: MediaQuery.of(context).size.width,
              height:MediaQuery.of(context).size.width/2,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(25)
              ),

              child: Column(
                children: [
                  Text(
                    "Total Balance"
                  ),
                  Text(
                      "Total Balance"
                  ),
                  Text(
                      "Total Balance"
                  )
                ],

              ),

            )
          ],
        ),

      ),
    );
  }
}
