import 'package:flutter/material.dart';

void main() => runApp(InstructionApp());

class InstructionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Work Instructions',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        scaffoldBackgroundColor: Colors.grey[100],
        textTheme: TextTheme(
          bodyMedium: TextStyle(fontSize: 16),
        ),
      ),
      home: StartScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// Start screen
class StartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Work Assistant')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.build_circle_outlined, size: 80, color: Colors.indigo),
            SizedBox(height: 20),
            Text(
              'Welcome to Work Instruction Assistant',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            ElevatedButton.icon(
              icon: Icon(Icons.play_arrow),
              label: Text('Start Task'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InstructionScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class InstructionStep {
  final String text;
  bool isDone;

  InstructionStep({required this.text, this.isDone = false});
}

class InstructionScreen extends StatefulWidget {
  @override
  _InstructionScreenState createState() => _InstructionScreenState();
}

class _InstructionScreenState extends State<InstructionScreen> {
  List<InstructionStep> steps = [
    InstructionStep(text: "Shut off power"),
    InstructionStep(text: "Remove old filter"),
    InstructionStep(text: "Insert new filter"),
    InstructionStep(text: "Power on machine"),
  ];

  bool get allDone => steps.every((step) => step.isDone);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Replace Air Filter'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${steps.where((step) => step.isDone).length} / ${steps.length} completed',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Icon(Icons.task_alt, color: Colors.indigo),
              ],
            ),
          ),
          if (allDone)
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                '🎉 Task Completed!',
                style: TextStyle(fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold),
              ),
            ),
          Expanded(
            child: ListView.builder(
              itemCount: steps.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: CheckboxListTile(
                    title: Text(steps[index].text),
                    value: steps[index].isDone,
                    secondary: Icon(Icons.check_box_outlined),
                    onChanged: (bool? value) {
                      setState(() {
                        steps[index].isDone = value ?? false;
                      });
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
