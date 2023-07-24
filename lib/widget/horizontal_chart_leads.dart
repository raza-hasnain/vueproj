import 'package:flutter/material.dart';

class HorizontalChartLeads extends StatelessWidget {
  const HorizontalChartLeads({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> chartData = [
      {"units": 50, "color": const Color(0xFF133465),},
      {"units": 10, "color": const Color(0xFF68B532),},
      {"units": 70, "color": Colors.yellow.shade600,},
      {"units": 100, "color": Colors.lightBlueAccent,},
      {"units": 50, "color": const Color(0xFFD3D3D3),},
      {"units": 10, "color": Colors.orange,},
      {"units": 70, "color": Colors.red.shade600,},
      {"units": 100, "color": const Color(0xFF949494),},
    ];
    double maxWidth = MediaQuery.of(context).size.width;
    var totalUnitNum = 0;
    for (int i = 0; i < chartData.length; i++) {
      totalUnitNum = totalUnitNum + int.parse(chartData[i]["units"].toString());
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 11.0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(90),
            child: Row(
              children: [
                for (int i = 0; i < chartData.length; i++)
                  i == chartData.length - 1
                      ? Expanded(
                    child: SizedBox(
                      height: 16,
                      child: ColoredBox(
                        color: chartData[i]["color"],
                      ),
                    ),
                  )
                      : Row(
                    children: [
                      SizedBox(
                        width:
                        chartData[i]["units"] / totalUnitNum * maxWidth,
                        height: 16,
                        child: ColoredBox(
                          color: chartData[i]["color"],
                        ),
                      ),
                      // const SizedBox(width: 6),
                    ],
                  ),
              ],
            ),
          ),
          // const SizedBox(
          //   height: 15.0,
          // ),
        ],
      ),
    );
  }
}