POS Thermal printer package. This package extends from esc_pos_print package

## Features

- Print direct text
- Print widget screenshot

## Getting started

use this git to pubspec.yaml

## Usage

1. Register the `PrintApi` as abstract and `ThermalPrint()` as implementation to `getIt` singleton.

```dart
final getIt = GetIt.instance;

void setupLocator() {
  getIt.registerSingleton<PrintApi>(ThermalPrint());
}
```

2. Initialize the `initialize` method, from main

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await getIt<PrintApi>().initialize();
  runApp(const MyApp());
}
```

3. Print demo

```dart
 final printer = getIt<PrintApi>();

 printer.printDirectText(
    printerModel: PrinterModel(
    name: "Recipe Print",
    ip: "192.168.1.13",
    ),
    print: ReceiptModel.demo(),
);
```
