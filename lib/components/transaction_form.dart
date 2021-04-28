import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm({Key key, this.onSubmit}) : super(key: key);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController _titleController = new TextEditingController();
  final TextEditingController _valueController = new TextEditingController();
  DateTime _selectedDate = DateTime.now();
  submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text);
    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }
    widget.onSubmit(title, value, _selectedDate);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2010),
      lastDate: DateTime(2022),
    ).then((pickerDate) {
      if (pickerDate == null) return;
      setState(() {
        _selectedDate = pickerDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final double bottom = MediaQuery.of(context).viewInsets.bottom + 10;
    return Container(
      padding: EdgeInsets.only(top: 20),
      height: MediaQuery.of(context).size.height,
      child: Card(
        elevation: 5,
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _titleController,
                onSubmitted: (_) => submitForm,
                decoration: InputDecoration(labelText: "Título: "),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _valueController,
                onSubmitted: (_) => submitForm,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(labelText: "Valor R\$: "),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(_selectedDate == null
                        ? "Nenhuma data selecionada"
                        : "Data selecionada ${DateFormat("dd/MM/y").format(_selectedDate)}"),
                  ),
                  TextButton(
                    onPressed: _showDatePicker,
                    child: Text("Selecionar Data",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    final title = _titleController.text;
                    final value = double.tryParse(_valueController.text);
                    widget.onSubmit(title, value, _selectedDate);
                  },
                  child: Text(
                    "Nova transação",
                    style: TextStyle(color: Colors.purple),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
