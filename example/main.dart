import 'package:flutter/material.dart';
import 'package:lhh_circular_chart/lhh_circular_chart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

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
        radius: MediaQuery.of(context).size.width / 4,
        strokeWidth: MediaQuery.of(context).size.width / 4,
      ),
    );
  }
}
