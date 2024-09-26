import 'package:flutter/material.dart';

class HabitTrackerApp extends StatelessWidget {
  const HabitTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Controle de Hábitos',
      theme: ThemeData(
        primaryColor: const Color(0xFF001f36),
        scaffoldBackgroundColor: const Color(0xFFfbffcd),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1C5560),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF000000),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
              color: Color(0xFF000000)),
          bodyMedium: TextStyle(
              color: Color(0xFF000000)),
        ),
        cardColor: const Color(0xFF79ae92),
        checkboxTheme: CheckboxThemeData(
          checkColor:
              MaterialStateProperty.all(const Color(0xFFfbffcd)),
          fillColor:
              MaterialStateProperty.all(const Color(0xFF1c5560)),
        ),
      ),
      home: const HabitListScreen(),
    );
  }
}

class HabitListScreen extends StatefulWidget {
  const HabitListScreen({super.key});

  @override
  _HabitListScreenState createState() => _HabitListScreenState();
}

class _HabitListScreenState extends State<HabitListScreen> {
  Map<String, bool> habits = {
    'Beber água': false,
    'Fazer exercícios': false,
    'Meditar': false,
  };

  double totalWaterIntake = 0;
  TextEditingController waterController = TextEditingController();

  double totalKmWalked = 0;
  TextEditingController kmController = TextEditingController();

  double totalMeditationHours = 0;
  TextEditingController meditationController = TextEditingController();

  List<String> exerciseList = ['Caminhada'];

  void _addHabit(String habit) {
    setState(() {
      habits[habit] = false;
    });
  }

  void _toggleHabit(String habit) {
    setState(() {
      habits[habit] = !habits[habit]!;
    });
  }

  void _showAddHabitDialog() {
    TextEditingController habitController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Adicionar novo hábito'),
        content: TextField(
          controller: habitController,
          decoration: const InputDecoration(hintText: 'Nome do hábito'),
        ),
        backgroundColor:
            const Color(0xFF79ae92),
        titleTextStyle:
            const TextStyle(color: Color(0xFFfbffcd)),
        contentTextStyle:
            const TextStyle(color: Color(0xFFfbffcd)),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancelar',
                style: TextStyle(color: Color(0xFFfbffcd))),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF000000),
            ),
            child: const Text(
              'Adicionar',
              style: TextStyle(color: Color(0xFFfbffcd)),
            ),
            onPressed: () {
              if (habitController.text.isNotEmpty) {
                _addHabit(habitController.text);
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }

  void _addWaterIntake() {
    double? waterIntake = double.tryParse(waterController.text);
    if (waterIntake != null && waterIntake > 0) {
      setState(() {
        totalWaterIntake += waterIntake;
        waterController.clear();
      });
    }
  }

  void _addKmWalked() {
    double? kmWalked = double.tryParse(kmController.text);
    if (kmWalked != null && kmWalked > 0) {
      setState(() {
        totalKmWalked += kmWalked;
        kmController.clear();
      });
    }
  }

  void _addMeditationHours() {
    double? meditationHours = double.tryParse(meditationController.text);
    if (meditationHours != null && meditationHours > 0) {
      setState(() {
        totalMeditationHours += meditationHours;
        meditationController.clear();
      });
    }
  }

  void _showAddExerciseDialog() {
    TextEditingController exerciseController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Adicionar novo exercício'),
        content: TextField(
          controller: exerciseController,
          decoration: const InputDecoration(hintText: 'Nome do exercício'),
        ),
        backgroundColor:
            const Color(0xFF79ae92),
        titleTextStyle:
            const TextStyle(color: Color(0xFFfbffcd)),
        contentTextStyle: const TextStyle(color: Color(0xFFfbffcd)),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancelar',
                style: TextStyle(color: Color(0xFFfbffcd))),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF000000),
            ),
            child: const Text(
              'Adicionar',
              style: TextStyle(color: Color(0xFFfbffcd)),
            ),
            onPressed: () {
              if (exerciseController.text.isNotEmpty) {
                setState(() {
                  exerciseList.add(exerciseController.text);
                });
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }

  void _deleteExercise(int index) {
    setState(() {
      exerciseList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Hábitos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => ProgressScreen(
                          habits: habits,
                          totalWaterIntake: totalWaterIntake,
                          totalKmWalked: totalKmWalked,
                          totalMeditationHours: totalMeditationHours,
                        )),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: habits.length,
        itemBuilder: (context, index) {
          String habit = habits.keys.elementAt(index);
          bool completed = habits[habit]!;

          return Card(
            color: const Color(0xFF79ae92),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.check_circle,
                    color: completed
                        ? const Color(0xFF1dDF24)
                        : const Color(0xFFfbffcd),
                  ),
                  title: Text(habit),
                  trailing: habit == 'Beber água'
                      ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              width: 60,
                              child: TextField(
                                controller: waterController,
                                decoration: const InputDecoration(
                                  hintText: 'Litros',
                                  border: OutlineInputBorder(),
                                ),
                                keyboardType: TextInputType.number,
                                onSubmitted: (_) => _addWaterIntake(),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add),
                              onPressed: _addWaterIntake,
                            ),
                            Text(
                              '${totalWaterIntake.toStringAsFixed(2)} L',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      : habit == 'Meditar'
                          ? Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 60,
                                  child: TextField(
                                    controller: meditationController,
                                    decoration: const InputDecoration(
                                      hintText: 'Horas',
                                      border: OutlineInputBorder(),
                                    ),
                                    keyboardType: TextInputType.number,
                                    onSubmitted: (_) => _addMeditationHours(),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: _addMeditationHours,
                                ),
                                Text(
                                  '${totalMeditationHours.toStringAsFixed(2)} h',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )
                          : Checkbox(
                              value: completed,
                              onChanged: (value) {
                                _toggleHabit(habit);
                              },
                            ),
                ),
                if (habit == 'Fazer exercícios') ...[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: exerciseList.map((exercise) {
                        int exerciseIndex = exerciseList.indexOf(exercise);
                        return ListTile(
                          title: Text(exercise),
                          leading: const Icon(Icons.fitness_center),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => _deleteExercise(exerciseIndex),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  TextButton(
                    onPressed: _showAddExerciseDialog,
                    child: const Text('Adicionar Exercício'),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 60,
                        child: TextField(
                          controller: kmController,
                          decoration: const InputDecoration(
                            hintText: 'Km',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          onSubmitted: (_) => _addKmWalked(),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: _addKmWalked,
                      ),
                      Text(
                        '${totalKmWalked.toStringAsFixed(2)} km',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ]
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddHabitDialog,
        child: const Icon(Icons.add, color: Color(0xFFfbffcd)),
      ),
    );
  }
}

class ProgressScreen extends StatelessWidget {
  final Map<String, bool> habits;
  final double totalWaterIntake;
  final double totalKmWalked;
  final double totalMeditationHours;

  const ProgressScreen({
    super.key,
    required this.habits,
    required this.totalWaterIntake,
    required this.totalKmWalked,
    required this.totalMeditationHours,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progresso'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Progresso dos Hábitos',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ...habits.entries.map((entry) {
              return ListTile(
                title: Text(entry.key),
                trailing: Icon(
                  entry.value ? Icons.check_circle : Icons.cancel,
                  color: entry.value
                      ? const Color(0xFF1dDF24)
                      : const Color(0xFFff0037),
                ),
              );
            }).toList(),
            const Divider(),
            const Text(
              'Progresso de Água',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('Total ingerido: ${totalWaterIntake.toStringAsFixed(2)} L'),
            const Divider(),
            const Text(
              'Progresso de Exercícios',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('Total caminhado: ${totalKmWalked.toStringAsFixed(2)} km'),
            const Divider(),
            const Text(
              'Progresso de Meditação',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
                'Total de horas de meditação: ${totalMeditationHours.toStringAsFixed(2)} h'),
          ],
        ),
      ),
    );
  }
}
