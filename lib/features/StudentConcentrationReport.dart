import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart' as fl;
import 'package:online_meeting/features/custom_app_bar.dart';
import 'package:pie_chart/pie_chart.dart' as pc;
class StudentConcentrationReport extends StatelessWidget {
  final List<String> students = [
    "Student 1",
    "Student 2",
    "Student 3",
    "Student 4",
    "Student 5",
    "Student 6",
    "Student 7",
    "Student 8"
  ];

  final List<int> concentrationLevels = [95, 78, 88, 56, 82, 60, 72, 85];
  final List<String> categories = [
    "High (>80%)",
    "Medium (60-80%)",
    "Low (<60%)"
  ];

  StudentConcentrationReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(txt: "Instructor Report", isIconVisible: false),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Bar Chart
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text("Bar Chart - Concentration Levels"),
            ),
            SizedBox(
              height: 300,
              child: fl.BarChart(
                fl.BarChartData(
                  titlesData: fl.FlTitlesData(
                    topTitles: fl.AxisTitles(
                      sideTitles: fl.SideTitles(showTitles: false),
                    ),
                    rightTitles: fl.AxisTitles(
                      sideTitles: fl.SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: fl.FlBorderData(show: true),
                  barGroups: concentrationLevels
                      .asMap()
                      .entries
                      .map(
                        (entry) => fl.BarChartGroupData(
                          x: entry.key,
                          barRods: [
                            fl.BarChartRodData(
                              toY: entry.value.toDouble(),
                              color: Colors.blueAccent,
                              width: 16,
                            ),
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
            ),

            // Pie Chart
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text("Pie Chart - Focus Categories"),
            ),
            pc.PieChart(
              dataMap: {
                "High (>80%)": concentrationLevels
                    .where((c) => c > 80)
                    .length
                    .toDouble(),
                "Medium (60-80%)": concentrationLevels
                    .where((c) => c >= 60 && c <= 80)
                    .length
                    .toDouble(),
                "Low (<60%)": concentrationLevels
                    .where((c) => c < 60)
                    .length
                    .toDouble(),
              },
              chartType: pc.ChartType.ring,
              chartRadius: 150,
              colorList: const [Colors.green, Colors.orange, Colors.red],
            ),

            // Line Chart
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text("Line Chart - Concentration Over Time"),
            ),
            SizedBox(
              height: 300,
              child: fl.LineChart(
                fl.LineChartData(
                  titlesData: fl.FlTitlesData(
                    topTitles: fl.AxisTitles(
                      sideTitles: fl.SideTitles(showTitles: false),
                    ),
                    rightTitles: fl.AxisTitles(
                      sideTitles: fl.SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: fl.FlBorderData(show: true),
                  lineBarsData: [
                    fl.LineChartBarData(
                      isCurved: true,
                      spots: concentrationLevels
                          .asMap()
                          .entries
                          .map((entry) => fl.FlSpot(
                              entry.key.toDouble(), entry.value.toDouble()))
                          .toList(),
                      color: Colors.blue,
                      barWidth: 4,
                    ),
                  ],
                ),
              ),
            ),

            // Text Analysis
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                _generateReport(),
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _generateReport() {
    final avgConcentration = concentrationLevels.reduce((a, b) => a + b) /
        concentrationLevels.length;
    final highFocus =
        concentrationLevels.where((c) => c > 80).length;
    final mediumFocus =
        concentrationLevels.where((c) => c >= 60 && c <= 80).length;
    final lowFocus =
        concentrationLevels.where((c) => c < 60).length;

    return """
    Report on Student Concentration During a 2-Hour Session:
    - Total Students: ${students.length}
    - Average Concentration: ${avgConcentration.toStringAsFixed(2)}%
    - Number of Students with High Focus (>80%): $highFocus
    - Number of Students with Medium Focus (60-80%): $mediumFocus
    - Number of Students with Low Focus (<60%): $lowFocus
    """;
  }
}