import 'dart:math';

import 'package:expenses/entities/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  final Transaction tr;
  final void Function(String) onRemove;
  const TransactionItem({
    Key key,
    @required this.tr,
    @required this.onRemove,
  }) : super(key: key);

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  static const colors = [
    Colors.red,
    Colors.purple,
    Colors.orange,
    Colors.amber,
    Colors.blue
  ];
  Color backgroundColor;
  @override
  void initState() {
    super.initState();
    int i = Random().nextInt(5);
    backgroundColor = colors[i];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: backgroundColor,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Flexible(child: Text("${widget.tr.value}")),
          ),
        ),
        title: Text("${widget.tr.title}"),
        subtitle: Text("${DateFormat('d/MM/y').format(widget.tr.date)}"),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          color: Theme.of(context).errorColor,
          onPressed: () => this.widget.onRemove(widget.tr.id),
        ),
      ),
    );
  }
}
