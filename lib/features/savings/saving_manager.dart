import 'package:annual_saving_calculator/features/savings/bloc/savings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'widgets/action_card.dart';
part 'widgets/balance_card.dart';
part 'widgets/balance_card_row.dart';

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
      body: const MainScreenBody(),
    );
  }
}

class MainScreenBody extends StatelessWidget {
  const MainScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SavingsCubit, SavingsState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 16.0,
            children: [
              const BalanceCardsRow(),
              const SizedBox(height: 8),
              ActionButton(
                title: 'Add Savings',
                icon: Icons.add_circle_outline,
                color: Colors.green,
                onPressed: () => Navigator.pushNamed(context, '/savings-entry'),
              ),
              ActionButton(
                title: 'Withdraw',
                icon: Icons.remove_circle_outline,
                color: Colors.red,
                onPressed: () => Navigator.pushNamed(context, '/withdraw'),
              ),
              const Spacer(),
              ActionButton(
                title: 'Reset Data',
                icon: Icons.delete_outline_rounded,
                color: Colors.blue,
                onPressed: () => context.read<SavingsCubit>().clearData(),
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }
}




