import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => MoodModel(),
      child: const MyApp(),
    ),
  );
}

class MoodModel with ChangeNotifier {
  String _currentMoodAsset = 'assets/images/happy.jpg';

  String get currentMoodAsset => _currentMoodAsset;

  void setHappy() {
    _currentMoodAsset = 'assets/images/happy.png';
    notifyListeners();
  }

  void setSad() {
    _currentMoodAsset = 'assets/images/sad.png';
    notifyListeners();
  }

  void setExcited() {
    _currentMoodAsset = 'assets/images/excited.png';
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Toggle Challenge',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.grey[100],
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            textStyle: const TextStyle(fontSize: 16),
          ),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mood Toggle Challenge'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'How are you feeling today?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            MoodDisplay(),
            SizedBox(height: 50),
            MoodButtons(),
          ],
        ),
      ),
    );
  }
}

class MoodDisplay extends StatelessWidget {
  const MoodDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MoodModel>(
      builder: (context, moodModel, child) {
        return Image.asset(
          moodModel.currentMoodAsset,
          height: 150,
          width: 150,
        );
      },
    );
  }
}

class MoodButtons extends StatelessWidget {
  const MoodButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final moodModel = Provider.of<MoodModel>(context, listen: false);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            moodModel.setHappy();
          },
          child: const Text('Happy 😊'),
        ),
        ElevatedButton(
          onPressed: () {
            moodModel.setSad();
          },
          child: const Text('Sad 😢'),
        ),
        ElevatedButton(
          onPressed: () {
            moodModel.setExcited();
          },
          child: const Text('Excited 🎉'),
        ),
      ],
    );
  }
}