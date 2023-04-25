import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_5/models/expenses_model.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(ExpensesModel expense) onAddExpense;
  @override
  State<NewExpense> createState() {
    return _NewExpense();
  }
}

class _NewExpense extends State<NewExpense> {
  // var _enteredTitle = '';

  // void _saveTitleInput(String input) {
  //   _enteredTitle = input;
  // }

  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  ExpenseCategory selectedCategory = ExpenseCategory.leisure;
  DateTime? selectedDate;

  void _presentDatePicker() async {
    final todayDate = DateTime.now();
    final firstDate =
        DateTime(todayDate.year - 1, todayDate.month, todayDate.day);
    // showDatePicker(
    //     context: context,
    //     initialDate: todayDate,
    //     firstDate: firstDate,
    //     lastDate: todayDate).then((value) => {

    //     });
    final pickedDate = await showDatePicker(
        context: context,
        initialDate: todayDate,
        firstDate: firstDate,
        lastDate: todayDate);
    setState(() {
      selectedDate = pickedDate;
    });
  }

/*  if you are using textediting controller you must call this
dispose function if not it will not deleted and memory might be taken up*/
  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountInvalid = enteredAmount == null || enteredAmount <= 0;
    if (_titleController.text.trim().isEmpty ||
        amountInvalid ||
        selectedDate == null) {
      // cupertino dialog is for ios 
      // showCupertinoDialog(context: context, builder: builder)
      // name of the ios styling language is cupertino. 
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text('Invalid input'),
              content: const Text('Please enter all fields'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(ctx);
                    },
                    child: const Text('Ok'))
              ],
            );
          });
      return;
    }
    widget.onAddExpense(
      ExpensesModel(selectedCategory,
          amount: enteredAmount,
          title: _titleController.text,
          date: selectedDate!),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, constraints) {
      final width = constraints.maxWidth;

      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 16, 16, keyboardSpace + 16),
            child: Column(children: [
              if (width >= 600)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextField(
                        // onChanged: _saveTitleInput,
                        controller: _titleController,
                        maxLength: 50,
                        decoration: const InputDecoration(
                          label: Text('Title'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 24,
                    ),
                    Expanded(
                      child: TextField(
                        // onChanged: _saveTitleInput,
                        controller: _amountController,
                        decoration: const InputDecoration(
                          prefixText: '\$ ',
                          label: Text('Amount'),
                        ),
                      ),
                    ),
                  ],
                )
              else
                TextField(
                  // onChanged: _saveTitleInput,
                  controller: _titleController,
                  maxLength: 50,
                  decoration: const InputDecoration(
                    label: Text('Title'),
                  ),
                ),
              if (width >= 600)
                Row(children: [
                  DropdownButton(
                        value: selectedCategory,
                        items: ExpenseCategory.values
                            .map(
                              (categoryItem) => DropdownMenuItem(
                                value: categoryItem,
                                child: Text(
                                  categoryItem.name.toUpperCase(),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            selectedCategory = value;
                          });
                        }),
                    const SizedBox(width: 24,),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(selectedDate == null
                              ? 'No date selected'
                              : formatter.format(selectedDate!)),
                          IconButton(
                            onPressed: _presentDatePicker,
                            icon: const Icon(Icons.calendar_month),
                          ),
                        ],
                      ),
                    ),
                ],)
              else
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        // onChanged: _saveTitleInput,
                        controller: _amountController,
                        decoration: const InputDecoration(
                          prefixText: '\$ ',
                          label: Text('Amount'),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(selectedDate == null
                              ? 'No date selected'
                              : formatter.format(selectedDate!)),
                          IconButton(
                            onPressed: _presentDatePicker,
                            icon: const Icon(Icons.calendar_month),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              const SizedBox(
                height: 16,
              ),
              if (width >= 600) 
              Row(children: [
                const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                        onPressed: _submitExpenseData,
                        child: const Text('Save expense'))
              ],)
              else 
              Row(
                children: [
                  DropdownButton(
                      value: selectedCategory,
                      items: ExpenseCategory.values
                          .map(
                            (categoryItem) => DropdownMenuItem(
                              value: categoryItem,
                              child: Text(
                                categoryItem.name.toUpperCase(),
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {
                        if (value == null) {
                          return;
                        }
                        setState(() {
                          selectedCategory = value;
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
                      onPressed: _submitExpenseData,
                      child: const Text('Save expense'))
                ],
              )
            ]),
          ),
        ),
      );
    });
  }
}
