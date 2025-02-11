import 'package:annual_saving_calculator/domain/repo/saving_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/entities/saving_entities.dart';
import '../../../domain/entities/withdrawal_entity.dart';

part 'savings_state.dart';

class SavingsCubit extends Cubit<SavingsState> {
  final SavingsRepository repo;
  SavingsCubit(this.repo)
      : super(SavingsState(
          compA: 0,
          compB: 0,
          savingsHistory: [],
          withdrawals: [],
        ));

  Future<void> addSavings(double amount) async {
    final double splitA = amount * 0.5;
    final double splitB = amount * 0.5;

    final savings = Savings(
      id: DateTime.now().millisecondsSinceEpoch,
      amount: amount,
      date: DateTime.now(),
      compA: splitA,
      compB: splitB,
    );

    await repo.insertSavings(savings);
    await loadSavings();
  }

  Future<void> withdraw(String component, double amount) async {
    final withdrawal = Withdrawal(
      id: DateTime.now().millisecondsSinceEpoch,
      amount: amount,
      date: DateTime.now(),
      component: component,
    );

    await repo.insertWithdrawal(withdrawal);
    await loadSavings();
  }

  Future<void> loadSavings() async {
    final savings = await repo.getSavings();
    final withdrawals = await repo.getWithdrawals();

    double totalCompA = 0;
    double totalCompB = 0;

    for (var saving in savings) {
      totalCompA += saving.compA;
      totalCompB += saving.compB;
    }

    for (var withdrawal in withdrawals) {
      if (withdrawal.component == 'CompA') {
        totalCompA -= withdrawal.amount;
      } else {
        totalCompB -= withdrawal.amount;
      }
    }

    emit(SavingsState(
      compA: totalCompA,
      compB: totalCompB,
      savingsHistory: savings,
      withdrawals: withdrawals,
    ));
  }
}
