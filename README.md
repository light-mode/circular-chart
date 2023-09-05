<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

A circular chart library which includes data visualization widgets such as pie and doughnut charts.

## Features

Provides functionality for rendering circular chart types, namely pie, doughnut.
![chart_pie.jpg](https://github.com/light-mode/circular-chart/blob/main/screenshots/chart_pie.jpg "Pie Chart")
![chart_doughnut.jpg](https://github.com/light-mode/circular-chart/blob/main/screenshots/chart_doughnut.jpg "Doughnut Chart")

## Getting started

### Depend on it

Run this command:
With Flutter:

```
$ flutter pub add lhh_circular_chart
```

This will add a line like this to your package's pubspec.yaml (and run an
implicit `flutter pub get`):

```
dependencies:
  lhh_circular_chart: ^0.0.1
```

Alternatively, your editor might support `flutter pub get`. Check the docs for your editor to learn
more.

### Import it

Now in your Dart code, you can use:

```
import 'package:lhh_circular_chart/lhh_circular_chart.dart';
```

## Usage

Add the chart widget as a child of any widget. Here, the chart widget is added as a child of
container widget.

```dart
@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.blue,
      title: const Text(
        'Pie Chart',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    ),
    body: CircularChart(
      dataList: [
        ChartData('', 10, Colors.blue.shade900),
        ChartData('', 10, Colors.blue.shade800),
        ChartData('', 10, Colors.blue.shade700),
        ChartData('', 10, Colors.blue.shade600),
        ChartData('', 10, Colors.blue.shade500),
        ChartData('', 10, Colors.blue.shade400),
        ChartData('', 10, Colors.blue.shade300),
        ChartData('', 10, Colors.blue.shade200),
        ChartData('', 10, Colors.blue.shade100),
        ChartData('', 10, Colors.blue.shade50),
      ],
      radius: MediaQuery
          .of(context)
          .size
          .width / 4,
      strokeWidth: MediaQuery
          .of(context)
          .size
          .width / 4,
    ),
  );
}
```

## Additional information
