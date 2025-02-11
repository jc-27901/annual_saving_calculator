import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/savings_cubit.dart';

class WithdrawalScreen extends StatefulWidget {
  const WithdrawalScreen({super.key});

  @override
  WithdrawalScreenState createState() => WithdrawalScreenState();
}

class WithdrawalScreenState extends State<WithdrawalScreen> {
  final TextEditingController _controller = TextEditingController();
  String _selectedComponent = 'CompA';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Withdraw')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: _selectedComponent,
              items: ['CompA', 'CompB']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => _selectedComponent = value);
                }
              },
            ),
            SizedBox(height: 16),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Withdrawal Amount',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                final amount = double.tryParse(_controller.text);
                if (amount != null) {
                  context
                      .read<SavingsCubit>()
                      .withdraw(_selectedComponent, amount);
                  Navigator.pop(context);
                }
              },
              child: Text('Withdraw'),
            ),
          ],
        ),
      ),
    );
  }
}
