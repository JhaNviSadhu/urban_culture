import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:urban_culture/utils/urban_culture_colors.dart';
import 'package:urban_culture/utils/urban_culture_common.dart';
import 'package:urban_culture/utils/urban_culture_textstyles.dart';

class StreakScreen extends StatelessWidget {
  const StreakScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      physics: ClampingScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 16),
          child: Text(
            "Today's Goal: 3 streak days",
            style: UrbanCultureTextStyle.h5W700(
                color: UrbanCultureColors.urbanCulturTextColors.textTitleColor),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
                color: UrbanCultureColors.containerColor,
                borderRadius: BorderRadius.circular(14)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Streak Days",
                  style: UrbanCultureTextStyle.callout(
                      color: UrbanCultureColors
                          .urbanCulturTextColors.textTitleColor),
                ),
                8.height,
                Text(
                  "2",
                  style: UrbanCultureTextStyle.h4W700(
                      color: UrbanCultureColors
                          .urbanCulturTextColors.textTitleColor),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Daily Streak",
                style: UrbanCultureTextStyle.callout(
                    color: UrbanCultureColors
                        .urbanCulturTextColors.textTitleColor),
              ),
              8.height,
              Text(
                "2",
                style: UrbanCultureTextStyle.h3W700(
                    color: UrbanCultureColors
                        .urbanCulturTextColors.textTitleColor),
              ),
              8.height,
              Text.rich(
                TextSpan(
                  text: 'Last 30 Days ',
                  style: UrbanCultureTextStyle.calloutW400(
                      color: UrbanCultureColors.primaryColor),
                  children: <InlineSpan>[
                    TextSpan(
                      text: '+100%',
                      style: UrbanCultureTextStyle.callout(
                          color: UrbanCultureColors.greenColor),
                    )
                  ],
                ),
              ),
              Container(
                height: 280,
                // width: 100,
                child: LineChart(
                  mainData(),
                ),
              ),
              30.height,
              Text(
                "Keep it up! You're on a roll.",
                style: UrbanCultureTextStyle.calloutW400(
                    color: UrbanCultureColors
                        .urbanCulturTextColors.textTitleColor),
              ),
              10.height,
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.all(9.5),
                  decoration: BoxDecoration(
                      color: UrbanCultureColors.containerColor,
                      borderRadius: BorderRadius.circular(14)),
                  child: Center(
                    child: Text(
                      "Get Started",
                      style: UrbanCultureTextStyle.subheadW700(
                          color: UrbanCultureColors
                              .urbanCulturTextColors.textTitleColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}

// chart data
LineChartData mainData() {
  return LineChartData(
    gridData: FlGridData(
      show: false,
      drawVerticalLine: false,
      horizontalInterval: 1,
      verticalInterval: 1,
      getDrawingHorizontalLine: (value) {
        return const FlLine(
          // color: AppColors.mainGridLineColor,
          strokeWidth: 1,
        );
      },
      getDrawingVerticalLine: (value) {
        return const FlLine(
          // color: AppColors.mainGridLineColor,
          strokeWidth: 1,
        );
      },
    ),
    titlesData: FlTitlesData(
      show: true,
      rightTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      topTitles: const AxisTitles(
        sideTitles: SideTitles(showTitles: false),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          interval: 1,
          getTitlesWidget: bottomTitleWidgets,
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: false,
          interval: 1,
          // getTitlesWidget: leftTitleWidgets,
          reservedSize: 42,
        ),
      ),
    ),
    borderData: FlBorderData(
      show: false,
      border: Border.all(color: const Color(0xff37434d)),
    ),
    minX: 0,
    maxX: 20,
    minY: 0,
    maxY: 7,
    lineBarsData: [
      LineChartBarData(
        spots: const [
          FlSpot(0, 3),
          FlSpot(3, 5),
          FlSpot(9, 4),
          FlSpot(11, 3.5),
          FlSpot(12, 5),
          FlSpot(15, 4),
          FlSpot(18, 3),
          FlSpot(20, 2.5),
        ],
        isCurved: true,
        barWidth: 5,
        isStrokeCapRound: true,
        color: UrbanCultureColors.primaryColor,
        dotData: const FlDotData(
          show: false,
        ),
        belowBarData: BarAreaData(
          show: true,
          applyCutOffY: true,
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              UrbanCultureColors.containerColor,
              UrbanCultureColors.scaffoldColor
            ].map((color) => color.withOpacity(1)).toList(),
          ),
        ),
      ),
    ],
  );
}

Widget bottomTitleWidgets(double value, TitleMeta meta) {
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = Text('1D',
          style: UrbanCultureTextStyle.footnoteW700(
              color: UrbanCultureColors.primaryColor));
      break;
    case 5:
      text = Text('1W',
          style: UrbanCultureTextStyle.footnoteW700(
              color: UrbanCultureColors.primaryColor));
      break;
    case 10:
      text = Text('1M',
          style: UrbanCultureTextStyle.footnoteW700(
              color: UrbanCultureColors.primaryColor));
      break;
    case 15:
      text = Text('3M',
          style: UrbanCultureTextStyle.footnoteW700(
              color: UrbanCultureColors.primaryColor));
      break;
    case 20:
      text = Text('1Y',
          style: UrbanCultureTextStyle.footnoteW700(
              color: UrbanCultureColors.primaryColor));
      break;

    default:
      text = Text('',
          style: UrbanCultureTextStyle.footnoteW700(
              color: UrbanCultureColors.primaryColor));
      break;
  }

  return SideTitleWidget(
    axisSide: meta.axisSide,
    child: text,
  );
}
