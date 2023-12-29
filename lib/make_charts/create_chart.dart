import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChartsScreen extends StatefulWidget {
  final List<String> documentIds;
  final List<Color> lineColors;
 final Function(String) onGraphClassChanged;
 String graphClass;
  ChartsScreen({
    required this.documentIds,
    required this.lineColors,
    required this.onGraphClassChanged,
    required this.graphClass
  });

  

  @override
  _ChartsScreenState createState() => _ChartsScreenState();
}



class _ChartsScreenState extends State<ChartsScreen> {
  
final List<String> dropdownItemList1 = [
    "1 Itqaan",
    "1 Ikhlas",
    "1 Ihsaan",
    "1 Tawakal",
    "2 Suhail",
    "2 Unais",
    "2 Saad",
    "2 Zubair",
    "3 Badar",
    "3 Uhud",
    "3 Mu'tah",
    "3 Hunain",
    "4 Al Banna",
    "4 Qutb",
    "4 Qardhawi",
    "5 Hanbali",
    "5 Hanafi",
    "5 Syafie",
    "6 Nawawi",
    "6 Bukhari",
    "SchoolOveralls"
  ];
  /*
  final List<String> documentIds;
  final List<Color> lineColors;
  final String graphClass;
  final Function(String) onGraphClassChanged;

  ChartsScreen({
    required this.documentIds,
    required this.lineColors,
    required this.graphClass,
    required this.onGraphClassChanged,
  });
  final List<String> dropdownItemList1 = [
    "1 Itqaan",
    "1 Ikhlas",
    "1 Ihsaan",
    "1 Tawakal",
    "2 Suhail",
    "2 Unais",
    "2 Saad",
    "2 Zubair",
    "3 Badar",
    "3 Uhud",
    "3 Mu'tah",
    "3 Hunain",
    "4 Al Banna",
    "4 Qutb",
    "4 Qardhawi",
    "5 Hanbali",
    "5 Hanafi",
    "5 Syafie",
    "6 Nawawi",
    "6 Bukhari",
    "SchoolOveralls"
  ];

*/

  /*
  @override
  void initState() {
    super.initState();
    // Set an initial value for graphClass
    graphClass = "SchoolOveralls";
  }
  */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Progression'),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: DropdownButton<String>(
              value: widget.graphClass,
              items: dropdownItemList1
                  .map((String value) => DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      ))
                  .toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                      widget.graphClass = newValue;
                      widget.onGraphClassChanged(newValue);
                  });
                }
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: FutureBuilder<List<LineChartBarData>>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return LineChart(
                  LineChartData(
                    gridData: FlGridData(show: false),

                    titlesData: FlTitlesData(
                      show: true,
                      leftTitles: const AxisTitles(
                        sideTitles:
                            SideTitles(reservedSize: 44, showTitles: true),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles:
                            SideTitles(reservedSize: 30, showTitles: true),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles:
                            SideTitles(reservedSize: 44, showTitles: true),
                      ),
                      bottomTitles: const AxisTitles(
                        sideTitles:
                            SideTitles(reservedSize: 30, showTitles: true),
                      ),
                    ),

                    borderData: FlBorderData(show: true),
                    minX: 0,
                    maxX: 50,
                    minY: 0,
                    maxY: 400, // Adjust based on your data
                    lineBarsData: snapshot.data!,
                    lineTouchData: LineTouchData(
                      touchTooltipData: LineTouchTooltipData(
                        tooltipBgColor: Colors.blueAccent,
                        getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                          return touchedBarSpots.map((barSpot) {
                            final documentId = widget.documentIds[barSpot.barIndex];
                            final value = barSpot.y;

                            return LineTooltipItem(
                              "$documentId\nValue: $value",
                              TextStyle(color: Colors.white),
                            );
                          }).toList();
                        },
                      ),
                    ),
                  ),
                );
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Future<List<LineChartBarData>> fetchData() async {
    List<LineChartBarData> chartsData = [];

    for (int i = 0; i < widget.documentIds.length; i++) {
      String documentId =widget.documentIds[i];
      Color lineColor = widget.lineColors[i];

      List<FlSpot> spots = await getDataFromFirestore(documentId);
      LineChartBarData chartData = LineChartBarData(
        spots: spots,
        isCurved: true,
        color: lineColor,
        belowBarData: BarAreaData(show: false),
      );

      chartsData.add(chartData);
    }

    return chartsData;
  }

  Future<List<FlSpot>> getDataFromFirestore(String documentId) async {
    // Replace with your Firestore query logic
    CollectionReference classData = FirebaseFirestore.instance
        .collection('Turquoise') // Replace with your collection name
        .doc("ForCharts")
        .collection(widget.graphClass);
    DocumentSnapshot<Map<String, dynamic>> document = await classData
        .doc(documentId)
        .get() as DocumentSnapshot<Map<String, dynamic>>;
    Map<String, dynamic> data = document.data() ?? {};
    List<FlSpot> spots = [];

    // Process data
    data.forEach((weekNumber, points) {
      int week = int.tryParse(weekNumber) ?? 0;
      double pointsValue = (points ?? 0).toDouble();
      spots.add(FlSpot(week.toDouble(), pointsValue));
    });
    // Sort spots based on x-values (week numbers)
    spots.sort((a, b) => a.x.compareTo(b.x));
    return spots;
  }
}



/*
class ChartsScreen extends StatelessWidget {
  final List<String> documentIds;
  final List<Color> lineColors;

  ChartsScreen({required this.documentIds, required this.lineColors});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Progression'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: FutureBuilder<List<LineChartBarData>>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                return LineChart(
                  LineChartData(
                    gridData: FlGridData(show: false),

                    titlesData: FlTitlesData(
                      show: true,
                      leftTitles: const AxisTitles(
                        sideTitles:
                            SideTitles(reservedSize: 44, showTitles: true),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles:
                            SideTitles(reservedSize: 30, showTitles: true),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles:
                            SideTitles(reservedSize: 44, showTitles: true),
                      ),
                      bottomTitles: const AxisTitles(
                        sideTitles:
                            SideTitles(reservedSize: 30, showTitles: true),
                      ),
                    ),

                    borderData: FlBorderData(show: true),
                    minX: 0,
                    maxX: 50,
                    minY: 0,
                    maxY: 400, // Adjust based on your data
                    lineBarsData: snapshot.data!,
                    lineTouchData: LineTouchData(
                      touchTooltipData: LineTouchTooltipData(
                        tooltipBgColor: Colors.blueAccent,
                        getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
                          return touchedBarSpots.map((barSpot) {
                            final documentId = documentIds[barSpot.barIndex];
                            final value = barSpot.y;

                            return LineTooltipItem(
                              "$documentId\nValue: $value",
                              TextStyle(color: Colors.white),
                            );
                          }).toList();
                        },
                      ),
                    ),
                  ),
                );
              }
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Future<List<LineChartBarData>> fetchData() async {
    List<LineChartBarData> chartsData = [];

    for (int i = 0; i < documentIds.length; i++) {
      String documentId = documentIds[i];
      Color lineColor = lineColors[i];

      List<FlSpot> spots = await getDataFromFirestore(documentId);
      LineChartBarData chartData = LineChartBarData(
        spots: spots,
        isCurved: true,
        color: lineColor,
        belowBarData: BarAreaData(show: false),
      );

      chartsData.add(chartData);
    }

    return chartsData;
  }

  Future<List<FlSpot>> getDataFromFirestore(String documentId) async {
    // Replace with your Firestore query logic
    CollectionReference classData = FirebaseFirestore.instance
        .collection('Turquoise') // Replace with your collection name
        .doc("ForCharts")
        .collection("SchoolOveralls");
    DocumentSnapshot<Map<String, dynamic>> document = await classData
        .doc(documentId)
        .get() as DocumentSnapshot<Map<String, dynamic>>;
    Map<String, dynamic> data = document.data() ?? {};
    List<FlSpot> spots = [];

    // Process data
    data.forEach((weekNumber, points) {
      int week = int.tryParse(weekNumber) ?? 0;
      double pointsValue = (points ?? 0).toDouble();
      spots.add(FlSpot(week.toDouble(), pointsValue));
    });
    // Sort spots based on x-values (week numbers)
    spots.sort((a, b) => a.x.compareTo(b.x));
    return spots;
  }
}
*/