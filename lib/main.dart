import 'package:flutter/material.dart';
import 'package:expenses/components/transaction_user.dart';

main() => runApp(const ExpensesApp());

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Despesas Pessoais'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ignore: avoid_unnecessary_containers
            Container(
              child: const Card(
                elevation: 5,
                color: Colors.blue,
                child: Text('Gráfico'),
              ),
            ),
            const TransactionUser(),
          ],
        ));
  }
}
