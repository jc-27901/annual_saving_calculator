import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'domain/repo/saving_repo.dart';
import 'features/history_screen.dart';
import 'features/savings/bloc/savings_cubit.dart';
import 'features/savings/saving_manager.dart';
import 'features/savings/savings_entry_screen.dart';
import 'features/savings/withdrawal_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SavingsRepository repository = SavingsRepository();
  await repository.initializeDB();

  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final SavingsRepository repository;

  const MyApp({super.key, required this.repository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SavingsCubit(repository),
      child: MaterialApp(
        title: 'Savings Manager',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/',
        routes: {
          '/': (context) => MainScreen(),
          '/savings-entry': (context) => SavingsEntryScreen(),
          '/withdraw': (context) => WithdrawalScreen(),
          '/history': (context) => HistoryScreen(),
        },
      ),
    );
  }
}