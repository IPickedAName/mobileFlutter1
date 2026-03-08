import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' show defaultTargetPlatform, TargetPlatform;
import 'package:flutter/material.dart';

void main() {
  runApp(const MyQuizApp());
}

bool get _isIOS => defaultTargetPlatform == TargetPlatform.iOS;

class MyQuizApp extends StatelessWidget {
  const MyQuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    if (_isIOS) {
      return const CupertinoApp(
        debugShowCheckedModeBanner: false,
        home: QuizPage(),
      );
    }

    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() {
    return _QuizPageState();
  }
}

class _QuizPageState extends State<QuizPage> {
  int? _num1;
  int? _num2;
  int? _solution;
  int _totalCount = 0;
  bool _hasPlayed = false;
  bool _solved = false;

  void _playGame() {
    final random = Random();

    setState(() {
      _num1 = random.nextInt(101);
      _num2 = random.nextInt(101);
      _solution = null;
      _solved = false;
      _hasPlayed = true;
      _totalCount++;
    });
  }

  void _solveGame() {
    if (_num1 == null || _num2 == null) {
      return;
    }

    setState(() {
      _solution = _num1! + _num2!;
      _solved = true;
    });
  }

  String get _expressionText {
    if (_num1 == null || _num2 == null) {
      return 'Expression';
    }
    return '$_num1 + $_num2';
  }

  String get _solutionText {
    if (!_hasPlayed) {
      return 'Solution';
    }

    if (_solved && _solution != null) {
      return '$_solution';
    }

    if (_num1 != null && _num2 != null) {
      return '?';
    }

    return 'Solution';
  }

  String get _playButtonText {
    if (_hasPlayed) {
      return 'Play Again';
    }
    return 'Play';
  }

  @override
  Widget build(BuildContext context) {
    return _isIOS ? _buildIOSView() : _buildAndroidView();
  }

  Widget _buildAndroidView() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('myQuiz'),
        centerTitle: true,
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return _buildPortraitLayout(false);
          } else {
            return _buildLandscapeLayout(false);
          }
        },
      ),
    );
  }

  Widget _buildIOSView() {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('myQuiz'),
      ),
      child: SafeArea(
        child: OrientationBuilder(
          builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              return _buildPortraitLayout(true);
            } else {
              return _buildLandscapeLayout(true);
            }
          },
        ),
      ),
    );
  }

  Widget _buildPortraitLayout(bool isIOS) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _expressionText,
              style: const TextStyle(fontSize: 32),
            ),
            const SizedBox(height: 20),
            const Text(
              '=',
              style: TextStyle(fontSize: 28),
            ),
            const SizedBox(height: 20),
            Text(
              _solutionText,
              style: const TextStyle(fontSize: 32),
            ),
            const SizedBox(height: 40),
            isIOS
                ? CupertinoButton(
                    onPressed: _solveGame,
                    child: const Text('Solve'),
                  )
                : ElevatedButton(
                    onPressed: _solveGame,
                    child: const Text('Solve'),
                  ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Counts: $_totalCount'),
                isIOS
                    ? CupertinoButton(
                        onPressed: _playGame,
                        child: Text(_playButtonText),
                      )
                    : TextButton(
                        onPressed: _playGame,
                        child: Text(_playButtonText),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLandscapeLayout(bool isIOS) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _expressionText,
                    style: const TextStyle(fontSize: 32),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    '=',
                    style: TextStyle(fontSize: 28),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _solutionText,
                    style: const TextStyle(fontSize: 32),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 30),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  isIOS
                      ? CupertinoButton(
                          onPressed: _solveGame,
                          child: const Text('Solve'),
                        )
                      : ElevatedButton(
                          onPressed: _solveGame,
                          child: const Text('Solve'),
                        ),
                  const SizedBox(height: 30),
                  Text('Total Counts: $_totalCount'),
                  const SizedBox(height: 10),
                  isIOS
                      ? CupertinoButton(
                          onPressed: _playGame,
                          child: Text(_playButtonText),
                        )
                      : TextButton(
                          onPressed: _playGame,
                          child: Text(_playButtonText),
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}