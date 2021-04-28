import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double value;
  final double percentage;

  const ChartBar({Key key, this.label, this.value, this.percentage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: constraints.maxHeight * .10,
            child: FittedBox(child: Text("R\$ ${value.toStringAsFixed(2)}")),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.15,
          ),
          Container(
            height: constraints.maxHeight * .6,
            width: 10,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(5)),
                ),
                FractionallySizedBox(
                  heightFactor: percentage,
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 1.0),
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(5)),
                  ),
                )
              ],
            ),
          ),
          Container(
              height: constraints.maxHeight * .15,
              child: FittedBox(child: Text(label))),
        ],
      );
    });
  }
}
