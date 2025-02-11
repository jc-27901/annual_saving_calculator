part of 'savings_cubit.dart';

@immutable
 class SavingsState {
    final double compA;
  final double compB;
  final List<Savings> savingsHistory;
  final List<Withdrawal> withdrawals;

  const SavingsState({required this.compA, required this.compB, required this.savingsHistory, required this.withdrawals});
}

// final class SavingsInitial extends SavingsState {}

// final class SavedState extends SavingsState {
//   final double compA;
//   final double compB;
//   final List<Savings> savingsHistory;
//   final List<Withdrawal> withdrawals;
//
//   SavedState(
//       {required this.compA,
//       required this.compB,
//       required this.savingsHistory,
//       required this.withdrawals});
// }
