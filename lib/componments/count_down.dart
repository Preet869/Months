import 'dart:async';
import 'package:flutter/material.dart';

class CountdownPage extends StatefulWidget {
  const CountdownPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CountdownPageState createState() => _CountdownPageState();
}

class _CountdownPageState extends State<CountdownPage> {
  late Timer _timer;
  late DateTime _nextMonth;

  @override
  void initState() {
    super.initState();
    _calculateNextMonth();
    _startTimer(); //updates the UI every second to reflect
  }

  void _calculateNextMonth() {
    //calculates the date of the next month based on the current date.
    DateTime now = DateTime.now();
    int currentMonth = now.month;
    int nextMonth = currentMonth == 12 ? 1 : currentMonth + 1;
    int nextYear = currentMonth == 12 ? now.year + 1 : now.year;
    _nextMonth = DateTime(nextYear, nextMonth);
  }

  void _startTimer() {
    Duration timeUntilNextMonth = _nextMonth.difference(DateTime.now());
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        timeUntilNextMonth = _nextMonth.difference(DateTime.now());
      });
      if (timeUntilNextMonth <= Duration.zero) {
        _timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Duration timeUntilNextMonth = _nextMonth.difference(DateTime.now());
    int days = timeUntilNextMonth.inDays;
    int hours = timeUntilNextMonth.inHours.remainder(24);
    int minutes = timeUntilNextMonth.inMinutes.remainder(60);
    int seconds = timeUntilNextMonth.inSeconds.remainder(60);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$days / $hours / $minutes / $seconds s',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
