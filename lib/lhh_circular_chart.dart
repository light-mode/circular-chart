library lhh_circular_chart;

import 'dart:math';

import 'package:flutter/material.dart';

class CircularChart extends StatelessWidget {
  const CircularChart({
    super.key,
    required this.dataList,
    required this.radius,
    required this.strokeWidth,
    this.dividerColor = Colors.transparent,
    this.dividerWidth = 0,
    this.startDegree = 270,
    this.onSelectionChange,
  });

  final List<ChartData> dataList;
  final double radius;
  final double strokeWidth;
  final Color dividerColor;
  final double dividerWidth;
  final double startDegree;
  final Function(ChartData? data)? onSelectionChange;

  @override
  Widget build(BuildContext context) {
    final adjustStrokeWidth = (strokeWidth > radius) ? radius : strokeWidth;
    final adjustRadius = radius - adjustStrokeWidth / 2;
    final translate = adjustStrokeWidth / 2;
    final painter = CircularChartPainter(
      dataList,
      radius,
      adjustStrokeWidth,
      dividerColor,
      dividerWidth,
      onSelectionChange,
    );
    return Transform.rotate(
      angle: degToRad(startDegree),
      child: Stack(
        children: [
          Positioned(
            left: translate,
            top: translate,
            child: CustomPaint(
              painter: painter,
              size: Size.square(adjustRadius * 2),
            ),
          ),
          GestureDetector(
            onTapDown: (TapDownDetails details) {
              final localPosition = details.localPosition;
              final dx = localPosition.dx - translate;
              final dy = localPosition.dy - translate;
              painter._calculateHitTest(Offset(dx, dy));
            },
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
              ),
              width: radius * 2,
              height: radius * 2,
            ),
          ),
        ],
      ),
    );
  }
}

class CircularChartPainter extends CustomPainter {
  CircularChartPainter(
    this._dataList,
    this._radius,
    this._strokeWidth,
    this._dividerColor,
    this._dividerWidth,
    this._onClick,
  );

  final List<ChartData> _dataList;
  final double _radius;
  final double _strokeWidth;
  final Color _dividerColor;
  final double _dividerWidth;
  final Function(ChartData? data)? _onClick;

  late Offset _center;
  final List<double> _accumulatePercents = List.empty(growable: true);
  int? _currentIndex;

  @override
  void paint(Canvas canvas, Size size) {
    _center = size.center(Offset.zero);
    _paintSection(canvas, size);
    _paintDivider(canvas);
  }

  void _paintSection(Canvas canvas, Size size) {
    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    var startAngle = 0.0;
    var accumulatePercent = 0.0;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = _strokeWidth;
    for (final data in _dataList) {
      final sweepAngle = degToRad(percentToDeg(data.percent));
      paint.color = data.color;
      canvas.drawPath(Path()..addArc(rect, startAngle, sweepAngle), paint);
      startAngle += sweepAngle;
      accumulatePercent += data.percent;
      _accumulatePercents.add(accumulatePercent);
    }
  }

  void _paintDivider(Canvas canvas) {
    if (_dividerWidth <= 0) {
      return;
    }
    var startAngle = 0.0;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = _dividerWidth
      ..color = _dividerColor;
    for (final data in _dataList) {
      final sweepAngle = degToRad(percentToDeg(data.percent));
      final angle = startAngle + sweepAngle;
      final p1 = _getPosition(_center, _radius, angle);
      final p2 = _getPosition(_center, _radius - _strokeWidth, angle);
      canvas.drawLine(p1, p2, paint);
      startAngle += sweepAngle;
    }
  }

  Offset _getPosition(Offset start, double distance, num angle) {
    final dx = distance * cos(angle) + start.dx;
    final dy = distance * sin(angle) + start.dy;
    return Offset(dx, dy);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

  bool? _calculateHitTest(Offset position) {
    final diff = position - _center;
    final adjustRadius = _radius - _strokeWidth / 2;
    int? selectedIndex;
    if (diff.distance >= adjustRadius - _strokeWidth / 2 &&
        diff.distance <= adjustRadius + _strokeWidth) {
      var deg = radToDeg(diff.direction);
      deg = deg.isNegative ? deg + 360 : deg;
      final percent = degToPercent(deg);
      for (final (index, data) in _accumulatePercents.indexed) {
        final lower = index == 0 ? 0 : _accumulatePercents[index - 1];
        if (percent > lower && percent <= data) {
          selectedIndex = index;
          break;
        }
      }
    }
    if (selectedIndex == _currentIndex) {
      return false;
    } else if (selectedIndex == null) {
      _currentIndex = null;
      _onClick?.call(null);
      return false;
    } else {
      _currentIndex = selectedIndex;
      _onClick?.call(_dataList[selectedIndex]);
      return true;
    }
  }
}

class ChartData {
  const ChartData(
    this.name,
    this.percent,
    this.color,
  );

  final String name;
  final double percent;
  final Color color;
}

double percentToDeg(num percent) => percent * 360 / 100;

double degToRad(num deg) => deg * pi / 180;

double radToDeg(num rad) => rad * 180 / pi;

double degToPercent(num deg) => deg * 100 / 360;
