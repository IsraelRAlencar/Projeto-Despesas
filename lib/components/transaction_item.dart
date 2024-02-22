import 'dart:math';

import 'package:flutter/material.dart';
import 'package:expenses/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatefulWidget {
  const TransactionItem({
    super.key,
    required this.tr,
    required this.onRemove,
  });

  final Transaction tr;
  final void Function(String p1) onRemove;

  @override
  State<TransactionItem> createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  static const colors = [
    Colors.red,
    Colors.purple,
    Colors.orange,
    Colors.blue,
    Colors.black,
  ];
  late Color _backgroundColor;

  @override
  void initState() {
    super.initState();
    int i = Random().nextInt(5);
    _backgroundColor = colors[i];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      color: Colors.white,
      surfaceTintColor: Theme.of(context).colorScheme.primary,
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          //backgroundColor: Theme.of(context).colorScheme.primary,
          backgroundColor: _backgroundColor,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: FittedBox(
              child: Text('R\$${widget.tr.value.toStringAsFixed(2)}'),
            ),
          ),
        ),
        title: Text(
          widget.tr.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Text(
          DateFormat('d MMM y').format(widget.tr.date),
          style: Theme.of(context).textTheme.titleSmall,
        ),
        trailing: MediaQuery.of(context).size.width > 480
            ? TextButton.icon(
                onPressed: () => widget.onRemove(widget.tr.id),
                label: const Text('Excluir'),
                icon: const Icon(Icons.delete),
                style: TextButton.styleFrom(
                  foregroundColor: Theme.of(context).colorScheme.error,
                ),
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).colorScheme.error,
                onPressed: () => widget.onRemove(widget.tr.id),
              ),
      ),
    );
  }
}
