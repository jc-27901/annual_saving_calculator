part of '../saving_manager.dart';

class BalanceCardsRow extends StatelessWidget {
  const BalanceCardsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SavingsCubit, SavingsState>(
      builder: (context, state) {
        return Row(
          spacing: 8.0,
          children: [
            BalanceCard(
              title: 'Component A',
              amount: state.compA,
              backgroundColor: Colors.blue.shade50,
              icon: Icons.account_balance_wallet,
            ),
            BalanceCard(
              title: 'Component B',
              amount: state.compB,
              backgroundColor: Colors.purple.shade50,
              icon: Icons.savings,
            ),
          ],
        );
      },
    );
  }
}