import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:ionicons/ionicons.dart';
import 'package:localboss/core/constants.dart';
import 'package:localboss/features/home/view/pages/home_layout.dart';
import 'package:localboss/features/reviews/utils/reviews_stats.dart';
import 'package:localboss/features/reviews/viewModels/reviews_provider.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class RealRaringTrendContainer extends StatefulWidget {
  const RealRaringTrendContainer({
    super.key,
  });

  @override
  State<RealRaringTrendContainer> createState() =>
      _RealRaringTrendContainerState();
}

enum ChartType { day, month, year }

class _RealRaringTrendContainerState extends State<RealRaringTrendContainer> {
  late List<_ChartData> data;
  late TooltipBehavior tooltip;

  @override
  void initState() {
    _updateData(ChartType.month);
    tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  bool boolRealRatingTrend = true;
  ChartType chartType = ChartType.month;

  void _updateData (ChartType type) {
    final reviews = Provider.of<ReviewsData>(context, listen: false).reviews;

    if(type == ChartType.year){
      final yearData = ReviewsStats.realRatingTrendPerYear(reviews);
      final sortedKeys = yearData.keys.toList()..sort((a, b) => a.compareTo(b));

      data = sortedKeys
      .map((key){
        return _ChartData("${key.year}", yearData[key]!);
      })
      .toList();
    }
    if(type == ChartType.month){
      final monthData = ReviewsStats.realRatingTrendPerMonth(reviews);
      final sortedKeys = monthData.keys.toList()..sort((a, b) => a.compareTo(b));

      data = sortedKeys
      .map((key){
        String monthName = monthNames[key.month - 1];
        
        return _ChartData(monthName, monthData[key]!);
      })
      .toList();
    }
    if(type == ChartType.day){
      final weekData = ReviewsStats.realRatingTrendPerDay(reviews);
      final sortedKeys = weekData.keys.toList()..sort((a, b) => a.compareTo(b));

      data = sortedKeys
      .map((key){
        String monthName = monthNames[key.month - 1];
        
        return _ChartData("$monthName ${key.day}", weekData[key]!);
      })
      .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: HomeLayout.blueWh),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          children: [
            Row(
              children: [
                const Text(
                  "Real rating trend",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(
                  padding: const EdgeInsets.all(0),
                  icon: Icon(
                    Icons.info_rounded,
                    color: HomeLayout.blueCyan,
                    size: 25,
                  ),
                  onPressed: () {
                    showToastWidget(
                      reverseAnimation: StyledToastAnimation.fade,
                      //dismissOtherToast: false,
                      context: context,
                      animation: StyledToastAnimation.fade,
                      isIgnoring: false,
                      duration: Duration.zero,
                      animDuration: const Duration(milliseconds: 200),
                      position: const StyledToastPosition(
                          //92216274
                          align: Alignment.center),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          ModalBarrier(
                            color: Colors.black.withOpacity(0.7),
                            dismissible:
                                false, // Prevents dismissing the toast by tapping outside
                          ),
                          // Container(
                          //   color: Colors.black,
                          //   height: 50,
                          //   width: 50,
                          // ),
                          Container(
                            height: MediaQuery.sizeOf(context).height * 0.35,
                            width: MediaQuery.sizeOf(context).width * 0.9,
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Column(
                              //mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                        //alignment: Alignment.topRight,
                                        onPressed: () {
                                          dismissAllToast(showAnim: true);
                                        },
                                        icon: const Icon(
                                          Ionicons.close_circle_outline,
                                          size: 35,
                                        )),
                                  ],
                                ),

                                const Text(
                                  "What does it mean",
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  textAlign: TextAlign.center,
                                  "This is the total reviews (with and without comment) that your business received during a period of time.",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),

                                //error message in textformfield is not working in the toast so need other way

                                const SizedBox(height: 20),
                                SizedBox(
                                  width: 140,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                        backgroundColor: HomeLayout.blueDark,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20))),
                                    onPressed: () {
                                      dismissAllToast(showAnim: true);
                                    },
                                    child: const Text("Accept",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(
                  width: 5,
                ),
                IconButton(
                  padding: const EdgeInsets.all(0),
                  icon: boolRealRatingTrend
                      ? Icon(CupertinoIcons.arrowtriangle_down_circle_fill,
                          color: HomeLayout.blueCyan, size: 25)
                      : Icon(CupertinoIcons.arrowtriangle_up_circle_fill,
                          color: HomeLayout.blueCyan, size: 25),
                  onPressed: () {
                    setState(() {
                      boolRealRatingTrend = !boolRealRatingTrend;
                    });
                  },
                )
              ],
            ),
            if (boolRealRatingTrend)
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor:
                                chartType == ChartType.day ? HomeLayout.blueCyan : Colors.grey),
                        onPressed: () {
                          setState(() {
                            chartType = ChartType.day;
                            _updateData(ChartType.day);
                          });
                        },
                        child: const Text(
                          "Day",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor:
                                chartType == ChartType.month ? HomeLayout.blueCyan : Colors.grey),
                        onPressed: () {
                          setState(() {
                            chartType = ChartType.month;
                            _updateData(ChartType.month);
                          });
                        },
                        child: const Text(
                          "Month",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor:
                                chartType == ChartType.year ? HomeLayout.blueCyan : Colors.grey),
                        onPressed: () {
                          setState(() {
                            chartType = ChartType.year;
                            _updateData(ChartType.year);
                          });
                        },
                        child: const Text(
                          "Year",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 200,
                    child: SfCartesianChart(
                      zoomPanBehavior: ZoomPanBehavior(
                        enablePanning: true,
                      ),
                      primaryXAxis: const CategoryAxis(
                        autoScrollingMode: AutoScrollingMode.start,
                        autoScrollingDelta: 5,
                        isVisible: true,
                        labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.bold),
                        majorTickLines:
                            MajorTickLines(width: 0), // Hide the dividing lines
                        axisLine: AxisLine(width: 0), // Hide the X-axis line
                      ),
                      primaryYAxis: const NumericAxis(
                          isVisible: false,
                          minimum: 0,
                          maximum: 6,
                          interval: 1),
                      tooltipBehavior: tooltip,
                      series: <CartesianSeries<_ChartData, String>>[
                          ColumnSeries<_ChartData, String>(
                            width: 0.8,
                            spacing: 0.2,
                            dataSource: data,
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            xValueMapper: (_ChartData dataDay, _) => dataDay.x,
                            yValueMapper: (_ChartData dataDay, _) => dataDay.y,
                            name: 'Reviews  ',
                            pointColorMapper: (_ChartData data, _) {
                              return HomeLayout.blueDark;
                            },
                            animationDuration: 500,
                            dataLabelSettings: const DataLabelSettings(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.black),
                                isVisible: true,
                                labelAlignment: ChartDataLabelAlignment.outer,
                                labelPosition: ChartDataLabelPosition.outside),
                          )
                      ],
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y);

  final String x;
  final double y;
}
