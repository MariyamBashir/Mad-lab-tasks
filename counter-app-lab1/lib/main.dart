import 'package:flutter/material.dart';

// --- PERSONAL PARAMETERS ---
final int myThreshold = 13; // 0 + 1 + 7 + 5 = 13
final Color mySeedColor = Colors.blue; // Using 'B' for Bashir

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // TASK 4: Personalised Theme
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: mySeedColor),
      ),
      home: const MyHomePage(title: 'CS 442 MAD Reload Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  // TASK 3: Reset Tracker State
  int _resetsUsed = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  // TASK 1 & 3: Reset logic
  void _resetCounter() {
    setState(() {
      _counter = 0;
      _resetsUsed++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Times you Pushed the + :'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            // TASK 2: Personalised Threshold Message
            if (_counter > myThreshold)
              const Text(
                "You're on a roll!",
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

            const SizedBox(height: 20),

            // TASK 3: Reset Tracker UI
            Text('Resets used: $_resetsUsed'),

            const SizedBox(height: 40),

            // TASK 5: About Line
            const Text('Built by Maryam Bashir · BCS-23-017'),
          ],
        ),
      ),
      // TASK 1: Two non-overlapping Floating Action Buttons
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _resetCounter,
            tooltip: 'Reset',
            child: const Icon(Icons.refresh),
          ),
          const SizedBox(height: 16), // Adds spacing between buttons
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
