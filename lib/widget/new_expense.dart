import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:own_app3/models/expense.dart';

final formatter = DateFormat.yMd();

class NewExpanse extends StatefulWidget {
  const NewExpanse(this.onAddExpanse, {super.key});

  final void Function(Expense expanse) onAddExpanse;

  @override
  State<NewExpanse> createState() => _NewExpanseState();
}

class _NewExpanseState extends State<NewExpanse> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }
  // var _enteredTitle = '';

  // void _savedTitleInput(String inputValue) {
  //   _enteredTitle = inputValue;
  // }
  void _submitExpenseData() {
    final enteredAmount = double.parse(_amountController.text);
    final invalidAmount = enteredAmount == (null) || enteredAmount <= 0;

    if (_titleController.text.trim().isEmpty ||
        invalidAmount ||
        _selectedDate == null) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Something Went Wrong'),
          content: const Text(
              'Please Enter Valid Title or Amount or Date or Category'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text(
                'Okay',
                style: (TextStyle(color: Colors.red)),
              ),
            ),
          ],
        ),
      );
      return;
    }
    widget.onAddExpanse(Expense(
        amount: enteredAmount,
        title: _titleController.text,
        date: _selectedDate!,
        category: _selectedCategory));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            // _savedTitleInput,
            maxLength: 50,
            decoration: const InputDecoration(label: Text('Title')),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                      label: Text('Amount'), prefixText: '₹ '),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(_selectedDate == null
                        ? 'No Date Selected'
                        : formatter.format(_selectedDate!)),
                    IconButton(
                      onPressed: _presentDatePicker,
                      icon: const Icon(Icons.calendar_month),
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              DropdownButton(
                  value: _selectedCategory,
                  items: Category.values
                      .map((category) => DropdownMenuItem(
                            value: category,
                            child: Text(
                              category.name.toUpperCase(),
                            ),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      if (value == null) {
                        return;
                      }
                      _selectedCategory = value;
                    });
                  }),
              const Spacer(),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                  onPressed: () {
                    _submitExpenseData();
                  },
                  child: const Text('Save Expense'))
            ],
          ),
        ],
      ),
    );
  }
}
