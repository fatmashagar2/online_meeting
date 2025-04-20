import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart' as fl;
import 'package:online_meeting/features/custom_app_bar.dart';
import 'package:pie_chart/pie_chart.dart' as pc;

// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Student Concentration Analysis',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         useMaterial3: true,
//       ),
//       home: DataInputScreen(),
//     );
//   }
// }

class StudentData {
  final String name;
  final List<double> concentrationLevels;

  StudentData({required this.name, required this.concentrationLevels});
}

class DataInputScreen extends StatefulWidget {
  const DataInputScreen({super.key});

  @override
  State<DataInputScreen> createState() => _DataInputScreenState();
}

class _DataInputScreenState extends State<DataInputScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<StudentData> _students = [];
  int _numberOfStudents = 0;
  int _periodInMinutes = 120; // Default 2 hours
  final TextEditingController _studentNameController = TextEditingController();
  final TextEditingController _concentrationController = TextEditingController();
  int _currentStudentIndex = 0;
  List<double> _currentStudentConcentrations = [];
  int _currentTimeInterval = 0;
  final int _timeIntervalMinutes = 15; // 15-minute intervals
  bool _hasStartedDataEntry = false;  // New flag to track if we've started data entry

  void _submitStudentData() {
    if (_formKey.currentState!.validate() && _concentrationController.text.isNotEmpty) {
      double concentration = double.tryParse(_concentrationController.text) ?? 0;
      if (concentration < 0 || concentration > 100) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Concentration must be between 0 and 100')),
        );
        return;
      }

      setState(() {
        _currentStudentConcentrations.add(concentration);
        _concentrationController.clear();
        _currentTimeInterval += _timeIntervalMinutes;
      });

      if (_currentTimeInterval >= _periodInMinutes) {
        // Save current student data and move to next student
        _students.add(StudentData(
          name: _studentNameController.text.isEmpty 
              ? 'Student ${_currentStudentIndex + 1}' 
              : _studentNameController.text,
          concentrationLevels: List.from(_currentStudentConcentrations),
        ));

        if (_currentStudentIndex + 1 < _numberOfStudents) {
          setState(() {
            _currentStudentIndex++;
            _currentTimeInterval = 0;
            _currentStudentConcentrations = [];
            _studentNameController.clear();
          });
        } else {
          // All students data collected, navigate to results
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResultsScreen(
                students: _students,
                periodInMinutes: _periodInMinutes,
              ),
            ),
          );
        }
      }
    }
  }

  void _startDataEntry() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _hasStartedDataEntry = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(txt: "Data Input", isIconVisible: false),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: !_hasStartedDataEntry
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Number of Students',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter number of students';
                        }
                        if (int.tryParse(value) == null || int.parse(value) <= 0) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _numberOfStudents = int.parse(value!);
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Period (minutes)',
                        border: OutlineInputBorder(),
                      ),
                      initialValue: '120',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter period duration';
                        }
                        if (int.tryParse(value) == null || int.parse(value) <= 0) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _periodInMinutes = int.parse(value!);
                      },
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _startDataEntry,
                      child: const Text('Start Data Entry'),
                    ),
                  ],
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Student ${_currentStudentIndex + 1} of $_numberOfStudents',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    if (_currentStudentConcentrations.isEmpty)
                      TextFormField(
                        controller: _studentNameController,
                        decoration: const InputDecoration(
                          labelText: 'Student Name',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    const SizedBox(height: 16),
                    Text(
                      'Time Interval: $_currentTimeInterval-${_currentTimeInterval + _timeIntervalMinutes} minutes',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _concentrationController,
                      decoration: const InputDecoration(
                        labelText: 'Concentration Level (0-100)',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter concentration level';
                        }
                        double? concentration = double.tryParse(value);
                        if (concentration == null || concentration < 0 || concentration > 100) {
                          return 'Please enter a value between 0 and 100';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _submitStudentData,
                      child: const Text('Submit Interval Data'),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _studentNameController.dispose();
    _concentrationController.dispose();
    super.dispose();
  }
}

class ResultsScreen extends StatelessWidget {
  final List<StudentData> students;
  final int periodInMinutes;

  const ResultsScreen({
    super.key,
    required this.students,
    required this.periodInMinutes,
  });

  List<fl.FlSpot> _getAverageConcentrationOverTime() {
    List<fl.FlSpot> spots = [];
    final intervals = students.first.concentrationLevels.length;

    for (int i = 0; i < intervals; i++) {
      double sum = 0;
      for (var student in students) {
        sum += student.concentrationLevels[i];
      }
      double average = sum / students.length;
      spots.add(fl.FlSpot(i * 15.0, average));
    }
    return spots;
  }

  List<double> _getFinalConcentrationLevels() {
    return students.map((student) => student.concentrationLevels.last).toList();
  }

  String _getTimeAnalysis() {
    var spots = _getAverageConcentrationOverTime();
    double initialAvg = spots.first.y;
    double finalAvg = spots.last.y;
    double maxAvg = spots
        .map((spot) => spot.y)
        .reduce((curr, next) => curr > next ? curr : next);
    int peakTimeIndex = spots.indexWhere((spot) => spot.y == maxAvg);

    return """
Time-Based Analysis:
• Initial Average Concentration (0-15 mins): ${initialAvg.toStringAsFixed(1)}%
• Peak Concentration Period: ${(peakTimeIndex * 15)}-${(peakTimeIndex * 15 + 15)} minutes
• Final Average Concentration: ${finalAvg.toStringAsFixed(1)}%
• Overall Decline: ${(initialAvg - finalAvg).toStringAsFixed(1)}%

Key Observations:
• ${students.length} students monitored over $periodInMinutes minutes
• Peak concentration occurred at ${peakTimeIndex * 15} minutes
• Average decline rate: ${((initialAvg - finalAvg) / (spots.length - 1)).toStringAsFixed(2)}% per interval

Recommendations:
• Consider implementing short breaks every 60 minutes
• Use engagement activities during the ${(spots.length ~/ 2) * 15}-${((spots.length ~/ 2) + 1) * 15} minute period
• Plan most important activities for the first hour
""";
  }

  @override
  Widget build(BuildContext context) {
    final concentrationLevels = _getFinalConcentrationLevels();

    return Scaffold(
      appBar: CustomAppBar(txt: "Analysis Results", isIconVisible: false),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Time-based Line Chart
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Average Concentration Over Time",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 300,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: fl.LineChart(
                  fl.LineChartData(
                    gridData: fl.FlGridData(show: true),
                    titlesData: fl.FlTitlesData(
                      leftTitles: fl.AxisTitles(
                        sideTitles: fl.SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (value, meta) {
                            return Text('${value.toInt()}%');
                          },
                        ),
                      ),
                      bottomTitles: fl.AxisTitles(
                        sideTitles: fl.SideTitles(
                          showTitles: true,
                          reservedSize: 30,
                          getTitlesWidget: (value, meta) {
                            return Text('${value.toInt()}m');
                          },
                        ),
                      ),
                      topTitles: fl.AxisTitles(
                        sideTitles: fl.SideTitles(showTitles: false),
                      ),
                      rightTitles: fl.AxisTitles(
                        sideTitles: fl.SideTitles(showTitles: false),
                      ),
                    ),
                    borderData: fl.FlBorderData(show: true),
                    minX: 0,
                    maxX: periodInMinutes.toDouble(),
                    minY: 0,
                    maxY: 100,
                    lineBarsData: [
                      fl.LineChartBarData(
                        spots: _getAverageConcentrationOverTime(),
                        isCurved: true,
                        color: Colors.blue,
                        barWidth: 3,
                        dotData: fl.FlDotData(show: true),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Pie Chart
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                "Focus Categories Distribution",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            pc.PieChart(
              dataMap: {
                "High (>80%)":
                    concentrationLevels.where((c) => c > 80).length.toDouble(),
                "Medium (60-80%)": concentrationLevels
                    .where((c) => c >= 60 && c <= 80)
                    .length
                    .toDouble(),
                "Low (<60%)":
                    concentrationLevels.where((c) => c < 60).length.toDouble(),
              },
              chartType: pc.ChartType.ring,
              chartRadius: 150,
              colorList: const [Colors.green, Colors.orange, Colors.red],
            ),

            // Time Analysis Text
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Detailed Time Analysis",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        _getTimeAnalysis(),
                        style: const TextStyle(fontSize: 14, height: 1.5),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
