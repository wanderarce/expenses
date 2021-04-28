import 'package:expenses/components/transaction_item.dart';
import 'package:expenses/entities/transaction.dart';
import 'package:flutter/cupertino.dart';

class TransactionsComponent extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;

  const TransactionsComponent({Key key, this.transactions, this.onRemove})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return transactions == null
        ? LayoutBuilder(builder: (context, constaints) {
            return Container(
              height: constaints.maxHeight * 0.6,
              child: Text("Nenhuma Transação encontrada!"),
            );
          })
        : ListView.builder(
            itemCount: transactions != null ? transactions.length : 0,
            itemBuilder: (ctx, index) {
              final tr = transactions[index];
              return TransactionItem(
                  key: ValueKey(tr.id), tr: tr, onRemove: onRemove);
            },
          );
  }
}
