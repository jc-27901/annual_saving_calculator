# Annual Savings Calculator

## Features

- Input annual savings amount
- Automatic 50-50 split between Component A and Component B
- Withdrawal functionality from either component
- Transaction history tracking
- Persistent data storage
- Clean Architecture implementation

## Project Structure

```
lib/
├── data/
│   
├── domain/
│   ├── repositories/
|   |   └── saving_repo.dart
|   |── entities/
│       ├── savings_entity.dart
│       └── withdrawal_entity.dart
├── features/
    └── savings/
        └── saving_manager.dart
        ├── bloc/
        │   ├── savings_cubit.dart
        │   └── savings_state.dart
        └── widgets/
                ├── action_card.dart
                ├── savings_entry_screen.dart
                ├── balance_card_row.dart
                ├── balance_card.dart
                └── withdrawal_screen.dart
   └── history/    
        ├── history_screen.dart  
└── main.dart      
```

## State Management

The application uses the BLoC pattern (specifically Cubit) for state management. This choice was made for several reasons:

### Why Cubit?
1. **Simplicity**: Cubit is simpler than full BLoC, making it ideal for this app's straightforward state changes
2. **Predictable State Flow**: All state changes are tracked and can be easily debugged
3. **Separation of Concerns**: Business logic is separated from UI

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_bloc: ^9.0.0
  sqflite: ^2.4.1
  path: ^1.9.0
  intl: ^0.20.2

dev_dependencies:
  flutter_test:
    sdk: flutter
```

## Getting Started

1. Clone the repository
```bash
git clone https://github.com/jc-27901/annual_saving_calculator
```

2. Install dependencies
```bash
flutter pub get
```

3. Run the app
```bash
flutter run
```

## Architecture Flow

1. **User Interaction**
    - User interacts with UI elements in presentation layer

2. **State Management**
    - Cubit handles state changes and business logic
    - Emits new states based on user actions

3. **Data Flow**
    - Repository pattern manages data operations
    - SQLite database handles persistence
    - Clean Architecture ensures separation of concerns

