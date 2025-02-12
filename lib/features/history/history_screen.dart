import 'package:annual_saving_calculator/domain/entities/saving_entities.dart';
import 'package:annual_saving_calculator/domain/entities/withdrawal_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../savings/bloc/savings_cubit.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Savings History'),
      ),
      body: BlocBuilder<SavingsCubit, SavingsState>(
        builder: (context, state) {
          if (state.savingsHistory.isEmpty) {
            return Center(
              child: Text('No Savings History Found'),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.savingsHistory.length,
            itemBuilder: (context, index) {
              final Savings saving = state.savingsHistory[index];
              final List<Withdrawal> relatedWithdrawals = state.withdrawals
                  .where((w) =>
                      w.date.year == saving.date.year &&
                      w.date.month == saving.date.month)
                  .toList();

              return Card(
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            DateFormat('MMMM yyyy').format(saving.date),
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                            'Total: ${NumberFormat.currency(symbol: '₹').format(saving.amount)}',
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                      const Divider(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildComponentCard(
                            context,
                            'Component A',
                            saving.compA,
                            Colors.blue.shade100,
                          ),
                          _buildComponentCard(
                            context,
                            'Component B',
                            saving.compB,
                            Colors.purple.shade100,
                          ),
                        ],
                      ),
                      if (relatedWithdrawals.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        Text(
                          'Withdrawals:',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        ...relatedWithdrawals.map((withdrawal) => ListTile(
                              dense: true,
                              leading: Icon(
                                Icons.arrow_downward,
                                color: Colors.red,
                                size: 20,
                              ),
                              title: Text(
                                '${withdrawal.component}: ${NumberFormat.currency(symbol: '₹').format(withdrawal.amount)}',
                                style: const TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              subtitle: Text(
                                DateFormat('MMM dd, yyyy').format(
                                  withdrawal.date,
                                ),
                              ),
                            )),
                      ],
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildComponentCard(BuildContext context, String title, double amount,
      Color backgroundColor) {
    return Expanded(
      child: Card(
        color: backgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 4),
              Text(
                NumberFormat.currency(symbol: '₹').format(amount),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
