import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleControrler = TextEditingController();

  final amountControrler = TextEditingController();

  DateTime? _selectedDate;

  //nhap du lieu chi tieu
  void _addSumbitted() {
    if (amountControrler.text.isEmpty) {
      return;
    }

    final enterTitle = titleControrler.text;
    final enterAmount = double.parse(amountControrler.text);

    if (enterTitle.isEmpty || enterAmount <= 0 || _selectedDate == null) {
      print('LOI TAI NGUYEN');
      return;
    }

    widget.addTx(
      enterTitle,
      enterAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  //chuc nang chon ngay

  void _pickerDate() {
    //hien thi lich
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2023),
            lastDate: DateTime.now())
        .then((pickeDate) {
      if (pickeDate == null) {
        return;
      }

      //set lai trang thai ngay
      setState(() {
        _selectedDate = pickeDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'TITLE'),
              controller: titleControrler,
              onSubmitted: (_) => _addSumbitted(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'AMOUNT'),
              controller: amountControrler,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _addSumbitted(),
            ),
            Container(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(_selectedDate == null
                      ? 'No Date Chosen'
                      : 'Picked Date: ${DateFormat.yMd().format(_selectedDate!)}'),
                  TextButton(
                      child: Text(
                        'ADD DAY',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: _pickerDate),
                  ElevatedButton(
                    child: Text('ADD'),
                    onPressed: _addSumbitted,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
