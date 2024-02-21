import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'adaptative_button.dart';
import 'adaptative_text_field.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  const TransactionForm(this.onSubmit, {Key? key}) : super(key: key);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleControler = TextEditingController();
  final _valueControler = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleControler.text;
    final value = double.tryParse(_valueControler.text) ?? 0.0;

    if (title.isEmpty || value <= 0) {
      return;
    }

    widget.onSubmit(title, value, _selectedDate);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        color: Colors.white,
        surfaceTintColor: Colors.purple[300],
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              AdaptativeTextField(
                  controller: _titleControler,
                  keyboardType: TextInputType.text,
                  onSubmitted: (_) => _submitForm(),
                  label: 'Título'),
              AdaptativeTextField(
                  controller: _valueControler,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  onSubmitted: (_) => _submitForm(),
                  label: 'Valor (R\$)'),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Data selecionada: ${DateFormat('dd/MM/y').format(_selectedDate)}',
                        style: TextStyle(
                          fontFamily: Theme.of(context)
                              .textTheme
                              .labelLarge
                              ?.fontFamily,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: _showDatePicker,
                      child: Text(
                        'Selecionar data',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AdaptativeButton(
                      label: 'Nova Transação', onPressed: _submitForm)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
