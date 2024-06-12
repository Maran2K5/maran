import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(ExerciseApp());
}

class ExerciseApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fitness App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fitness App'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              color: Colors.blue,
              child: Center(
                child: Text(
                  'Welcome to Fitness App',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExerciseCategories(),
                        ),
                      );
                    },
                    child: Text('Start Workout'),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                      // Add navigation to other features like diet plans, progress tracker, etc.
                    },
                    child: Text('More Features'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ExerciseCategories extends StatelessWidget {
  final List<String> categories = [
    'Cardio',
    'Strength Training',
    'Yoga',
    'Stretching',
    'Pilates',
    'HIIT'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise Categories'),
      ),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(categories[index]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExerciseList(category: categories[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ExerciseList extends StatelessWidget {
  final String category;

  ExerciseList({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: ListView.builder(
        itemCount: 10, // Change this to your actual number of exercises
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('Exercise ${index + 1}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ExerciseDetail(exerciseName: 'Exercise ${index + 1}'),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ExerciseDetail extends StatelessWidget {
  final String exerciseName;

  ExerciseDetail({required this.exerciseName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(exerciseName),
      ),
      body: Center(
        child: Text(
          'Details of $exerciseName',
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TimerPage(),
            ),
          );
        },
        child: Icon(Icons.timer),
      ),
    );
  }
}

class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  int _seconds = 0;
  bool _isActive = false;

  void _toggleTimer() {
    if (_isActive) {
      setState(() {
        _isActive = false;
      });
    } else {
      setState(() {
        _isActive = true;
      });
      _startTimer();
    }
  }

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(oneSec, (timer) {
      if (!_isActive) {
        timer.cancel();
      } else {
        setState(() {
          _seconds++;
        });
      }
    });
  }

  void _resetTimer() {
    setState(() {
      _seconds = 0;
      _isActive = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    String timerText = '$_seconds seconds';
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise Timer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              timerText,
              style: TextStyle(
                fontSize: 40.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FloatingActionButton(
                  onPressed: _toggleTimer,
                  child: Icon(_isActive ? Icons.pause : Icons.play_arrow),
                ),
                SizedBox(width: 20.0),
                FloatingActionButton(
                  onPressed: _resetTimer,
                  child: Icon(Icons.stop),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}