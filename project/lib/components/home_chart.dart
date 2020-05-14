import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HomeChart extends StatefulWidget {
  HomeChart({Key key,}) : super(key: key);

  @override
  _HomeChartState createState() => _HomeChartState();
  
  final List<LineChartBarData> listOfChartData = [
    LineChartBarData(
      spots: [
        FlSpot(0, 0),
        FlSpot(1, 356173.75),
        FlSpot(2, 712347.5),
        FlSpot(3, 1068521.25),
        FlSpot(4, 1424695),
        FlSpot(5, 1780868.75),
        FlSpot(6, 2137042.5),
        FlSpot(7, 2493216.25),
        FlSpot(8, 2849390),
        FlSpot(9, 3205563.75),
        FlSpot(10, 3561737.5),
        FlSpot(11, 3917911.25),
      ],
      isCurved: true,
      barWidth: 2,
      colors: [
        Colors.green,
      ],
      dotData: FlDotData(
        show: false,
      ),
    ),
  ];

}

class _HomeChartState extends State<HomeChart> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 900,
      height: 420,
      child: LineChart(
        LineChartData(
          lineTouchData: LineTouchData(enabled: false),
          lineBarsData: [
            LineChartBarData(
              spots: [
                FlSpot(0, 4),
                FlSpot(1, 356173.75),
                FlSpot(2, 712347.5),
                FlSpot(3, 1068521.25),
                FlSpot(4, 1424695),
                FlSpot(5, 1780868.75),
                FlSpot(6, 2137042.5),
                FlSpot(7, 2493216.25),
                FlSpot(8, 2849390),
                FlSpot(9, 3205563.75),
                FlSpot(10, 3561737.5),
                FlSpot(11, 3917911.25),
              ],
              isCurved: true,
              barWidth: 2,
              colors: [
                Colors.green,
              ],
              dotData: FlDotData(
                show: false,
              ),
            ),
          ],
          minY: 0,
          titlesData: FlTitlesData(
            bottomTitles: SideTitles(
                showTitles: true,
                textStyle:
                    TextStyle(fontSize: 10, color: Colors.purple, fontWeight: FontWeight.bold),
                getTitles: (value) {
                  switch (value.toInt()) {
                    case 0:
                      return 'Jan';
                    case 1:
                      return 'Feb';
                    case 2:
                      return 'Mar';
                    case 3:
                      return 'Apr';
                    case 4:
                      return 'May';
                    case 5:
                      return 'Jun';
                    case 6:
                      return 'Jul';
                    case 7:
                      return 'Aug';
                    case 8:
                      return 'Sep';
                    case 9:
                      return 'Oct';
                    case 10:
                      return 'Nov';
                    case 11:
                      return 'Dec';
                    default:
                      return '';
                  }
                }),
            leftTitles: SideTitles(
              showTitles: true,
              getTitles: (value) {
                return '${value/1000}k';
              },
              interval: 200000
            ),
          ),
          gridData: FlGridData(
            show: true,
            checkToShowHorizontalLine: (double value) {
              return value == 800000 || value == 1600000 || value == 2400000 || value == 3200000;
            },
          ),
        ),
      ),
    );
  }
}