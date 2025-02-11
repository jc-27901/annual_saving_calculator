import 'package:annual_saving_calculator/features/savings/bloc/savings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<SavingsCubit>().loadSavings();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Savings Manager'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => Navigator.pushNamed(context, '/history'),
          ),
        ],
      ),
      body: BlocBuilder<SavingsCubit, SavingsState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    _buildBalanceCard(
                      context,
                      'Component A',
                      state.compA,
                      Colors.blue.shade50,
                      Icons.account_balance_wallet,
                    ),
                    const SizedBox(width: 16),
                    _buildBalanceCard(
                      context,
                      'Component B',
                      state.compB,
                      Colors.purple.shade50,
                      Icons.savings,
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                _buildActionButton(
                  context,
                  'Add Savings',
                  Icons.add_circle_outline,
                  Colors.green,
                  () => Navigator.pushNamed(context, '/savings-entry'),
                ),
                const SizedBox(height: 16),
                _buildActionButton(
                  context,
                  'Withdraw',
                  Icons.remove_circle_outline,
                  Colors.red,
                  () => Navigator.pushNamed(context, '/withdraw'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildBalanceCard(BuildContext context, String title, double amount,
      Color backgroundColor, IconData icon) {
    return Expanded(
      child: Card(
        elevation: 4,
        color: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                spacing: 4.0,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 16),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '₹${amount.toStringAsFixed(1)}',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, String title, IconData icon,
      Color color, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton.icon(
        icon: Icon(icon, color: Colors.white),
        label: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
