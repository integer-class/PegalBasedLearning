import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class ResultDetail extends StatelessWidget {
  final String name;
  final Map<String, double> dataMap; // Updated to use dataMap
  final List<Color> colorList; // Updated to use colorList

  const ResultDetail({
    Key? key,
    required this.name,
    required this.dataMap, // Added dataMap
    required this.colorList, // Added colorList
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Center(
        child: SizedBox(
          width: 300,
          height: 300,
          child: PieChart(
            dataMap: dataMap,
            animationDuration: Duration(milliseconds: 800),
            chartLegendSpacing: 32,
            chartRadius: MediaQuery.of(context).size.width / 3.2,
            colorList: colorList,
            initialAngleInDegree: 0,
            chartType: ChartType.ring,
            ringStrokeWidth: 32,
            centerText: "HYBRID",
            legendOptions: LegendOptions(
              showLegendsInRow: false,
              legendPosition: LegendPosition.right,
              showLegends: true,
              legendShape: BoxShape.circle,
              legendTextStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            chartValuesOptions: ChartValuesOptions(
              showChartValueBackground: true,
              showChartValues: true,
              showChartValuesInPercentage: false,
              showChartValuesOutside: false,
              decimalPlaces: 1,
            ),
          ),
        ),
      ),
    );
  }
}