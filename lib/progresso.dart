import 'package:flutter/material.dart';

class ProgressScreen extends StatelessWidget {
  final Map<String, bool> habits;

  const ProgressScreen({super.key, required this.habits});

  @override
  Widget build(BuildContext context) {
    int completedCount = habits.values.where((status) => status).length;
    int totalHabits = habits.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Progresso de Hábitos'),
        backgroundColor: const Color(0xFF001f36),
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xFF001f36),
                const Color(0xFF1c5560),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Hábitos Concluídos:',
                style:
                    TextStyle(fontSize: 24, color: Color(0xFFfbffcd)),
              ),
              const SizedBox(height: 20),
              Text(
                '$completedCount de $totalHabits',
                style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF79ae92)),
              ),
              const SizedBox(height: 20),
              LinearProgressIndicator(
                value: totalHabits == 0 ? 0 : completedCount / totalHabits,
                minHeight: 10,
                backgroundColor: const Color(0xFF79ae92),
                valueColor: const AlwaysStoppedAnimation<Color>(
                    Color(0xFFfbffcd)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
