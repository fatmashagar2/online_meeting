import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class ConcentrationOverview extends StatelessWidget {
  const ConcentrationOverview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blue.shade200),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            // Logo and title
            Row(
              children: [
                const SizedBox(width: 16),
                Container(
                  width: 24,
                  height: 24,
                  decoration: const BoxDecoration(
                    color: Color(0xFF163DBB),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                const Text(
                  'FocusMeet',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Concentration Overview',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // Pie Chart
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: [
                    PieChartSectionData(
                      value: 35,
                      color: const Color.fromRGBO(7, 51, 161, 1),
                      radius: 50,
                      showTitle: false,
                    ),
                    PieChartSectionData(
                      value: 25,
                      color: const Color.fromARGB(255, 73, 86, 198),
                      radius: 50,
                      showTitle: false,
                    ),
                    PieChartSectionData(
                      value: 20,
                      color: const Color.fromARGB(255, 83, 105, 151),
                      radius: 50,
                      showTitle: false,
                    ),
                    PieChartSectionData(
                      value: 20,
                      color: const Color.fromARGB(255, 137, 145, 197),
                      radius: 50,
                      showTitle: false,
                    ),
                  ],
                ),
              ),
            ),
            // Line Chart
            SizedBox(
              height: 100,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: false),
                  titlesData: const FlTitlesData(show: false),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: const [
                        FlSpot(0, 1),
                        FlSpot(1, 1.5),
                        FlSpot(2, 1.2),
                        FlSpot(3, 2),
                        FlSpot(4, 1.8),
                        FlSpot(5, 2.2),
                      ],
                      isCurved: true,
                      color: const Color.fromARGB(255, 5, 19, 110),
                      barWidth: 2,
                      dotData: const FlDotData(show: false),
                    ),
                    LineChartBarData(
                      spots: const [
                        FlSpot(0, 0.5),
                        FlSpot(1, 1),
                        FlSpot(2, 0.8),
                        FlSpot(3, 1.2),
                        FlSpot(4, 1),
                        FlSpot(5, 1.3),
                      ],
                      isCurved: true,
                      color: Colors.grey.shade300,
                      barWidth: 2,
                      dotData: const FlDotData(show: false),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Detailed Analytics section
            const Text(
              'Detailed Analytics',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            // Average Concentration
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: const Color(0xFFF1F8E9),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Average Concentration',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('78% during the session'),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // Peak Concentration
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: const Color(0xFFF1F8E9),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Peak Concentration',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('Occurred at 10:45 AM'),
                ],
              ),
            ),
            const Spacer(),
            // Buttons
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 15, 8, 132),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Export Report'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      child: const Text('Back to Meeting'),
                    ),
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