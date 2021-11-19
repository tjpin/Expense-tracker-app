// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double spending;
  final double spendingPct;

  ChartBar(this.label, this.spending, this.spendingPct);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(child: Text("\$${spending.toStringAsFixed(0)}")),
        SizedBox(
          height: 4,
        ),
        Container(
          height: 70,
          width: 10,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.grey, style: BorderStyle.solid, width: 1),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(5)),
              ),
              FractionallySizedBox(
                heightFactor: spendingPct,
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).splashColor,
                      borderRadius: BorderRadius.circular(5)),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(label)
      ],
    );
  }
}


// Container(
//             margin: EdgeInsets.only(top: 5),
//             width: double.infinity,
//             height: 60,
//             ////////ITEM CARD PARENT ////////
//             child: SizedBox(
//               width: double.infinity,
//               child: Container(
//                 padding: EdgeInsets.only(left: 10, right: 15),
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                     color: Theme.of(context).splashColor,
//                     borderRadius: BorderRadius.circular(4)),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     ///// Title Container//////////////////////////
//                     Container(
//                       width: 150,
//                       color: Theme.of(context).splashColor,
//                       alignment: Alignment.centerLeft,
//                       child: Text(
//                         transactions[index].title,
//                         style: TextStyle(
//                             color: Theme.of(context).primaryColor,
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                             fontFamily: "Open Sans"),
//                       ),
//                     ),
//                     ////// SECOND AMOUNT COLUMN //////////////////////////////
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Container(
//                           // Amount
//                           child: Text(
//                             "\$${transactions[index].amount.toStringAsFixed(2)}",
//                             style: TextStyle(
//                                 fontSize: 18,
//                                 color: Theme.of(context).primaryColor,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         Text(
//                           DateFormat('yyyy-MM-dd')
//                               .format(transactions[index].date),
//                           style: TextStyle(
//                               fontSize: 16,
//                               color: Colors.black54,
//                               fontWeight: FontWeight.bold),
//                         )
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           );