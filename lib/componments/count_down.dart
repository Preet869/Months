import 'dart:async';
import 'package:flutter/material.dart';
import 'package:month_project/Pages/photo_page.dart';
import 'package:month_project/componments/button_app.dart';

class CountdownPage extends StatefulWidget {
  const CountdownPage({Key? key});

  @override
  _CountdownPageState createState() => _CountdownPageState();
}

class _CountdownPageState extends State<CountdownPage> {
  late Timer _timer;
  late DateTime _nextMonth;
  bool _showButton = false;

  @override
  void initState() {
    super.initState();
    _calculateNextMonth();
    _startTimer();
  }

  void _calculateNextMonth() {
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
        if (timeUntilNextMonth <= Duration.zero) {
          _showButton = false;
          _timer.cancel();
        }
      });
    });
  }

  void _takePhoto() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TakePhotoPage()),
    );
    // After taking the photo, restart the countdown
    _showButton = false;
    _startTimer();
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
          '$days / $hours / $minutes / $seconds s ',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        if (_showButton)
          ElevatedButton(
            onPressed: _takePhoto,
            child: const Text('Take a Photo'),
          ),
      ],
    );
  }
}
