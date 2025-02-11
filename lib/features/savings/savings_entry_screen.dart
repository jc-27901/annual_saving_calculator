import 'package:annual_saving_calculator/features/savings/bloc/savings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavingsEntryScreen extends StatefulWidget {
  const SavingsEntryScreen({super.key});

  @override
  SavingsEntryScreenState createState() => SavingsEntryScreenState();
}

class SavingsEntryScreenState extends State<SavingsEntryScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Savings')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Annual Savings Amount',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final amount = double.tryParse(_controller.text);
                if (amount != null) {
                  context.read<SavingsCubit>().addSavings(amount);
                  Navigator.pop(context);
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}