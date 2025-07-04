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

enum ChartType { week, month, year }

class AverageContainer extends StatefulWidget {
  const AverageContainer({super.key});

  @override
  State<AverageContainer> createState() => _AverageContainerState();
}

class _AverageContainerState extends State<AverageContainer> {
  late List<_ChartData> data;
  late TooltipBehavior tooltip;

  late List<_ChartData> datay;

  bool boolAverageReviews = true;
  ChartType chartType = ChartType.week;

  @override
  void initState() {
    _updateData(ChartType.week);
    tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  bool loading = false;

  void _updateData (ChartType type) {
    final reviews = Provider.of<ReviewsData>(context, listen: false).reviews;

    if(type == ChartType.year){
      final yearData = ReviewsStats.yearlyAvregeRating(reviews);
      final sortedKeys = yearData.keys.toList()..sort((a, b) => a.compareTo(b));

      data = sortedKeys
      .map((key){
        return _ChartData("${key.year}", yearData[key]!);
      })
      .toList();
    }
    if(type == ChartType.month){
      final monthData = ReviewsStats.monthlyAvregeRating(reviews);
      final sortedKeys = monthData.keys.toList()..sort((a, b) => a.compareTo(b));

      data = sortedKeys
      .map((key){
        String monthName = monthNames[key.month - 1];
        
        return _ChartData(monthName, monthData[key]!);
      })
      .toList();
    }
    if(type == ChartType.week){
      final weekData = ReviewsStats.weaklyAvregeRating(reviews);
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  chartType == ChartType.year
                      ? "Yearly average"
                      : chartType == ChartType.month
                          ? "Monthly average"
                          : "Weekly average",
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                  icon: boolAverageReviews
                      ? Icon(CupertinoIcons.arrowtriangle_down_circle_fill,
                          color: HomeLayout.blueCyan, size: 25)
                      : Icon(CupertinoIcons.arrowtriangle_up_circle_fill,
                          color: HomeLayout.blueCyan, size: 25),
                  onPressed: () {
                    setState(() {
                      boolAverageReviews = !boolAverageReviews;
                    });
                  },
                )
              ],
            ),
            Text(
              data.isNotEmpty ? ((data[data.length-1].y * 100).toInt() / 100).toString() : "",
              style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
            ),
            Text(
              data.isNotEmpty ? data[data.length-1].x : "",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 5,
                ),
                TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor:
                          chartType == ChartType.week ? HomeLayout.blueCyan : Colors.grey),
                  onPressed: () {
                    setState(() {
                      chartType = ChartType.week;
                      _updateData(ChartType.week);
                    });
                  },
                  child: const Text(
                    "Week",
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
                      backgroundColor: ChartType.month == chartType
                          ? HomeLayout.blueCyan
                          : Colors.grey),
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
                          ChartType.year == chartType ? HomeLayout.blueCyan : Colors.grey),
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
            if (boolAverageReviews)
              Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: SfCartesianChart(
                      zoomPanBehavior: ZoomPanBehavior(
                        enablePanning: true,
                        enableDoubleTapZooming: false,
                        enablePinching: false,
                        enableMouseWheelZooming: false,
                        zoomMode: ZoomMode.x,
                      ),
                      primaryXAxis: const CategoryAxis(
                        autoScrollingMode: AutoScrollingMode.start,
                        autoScrollingDelta: 10,
                        isVisible: true,
                        labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
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
                            dataSource: data,
                            xValueMapper: (_ChartData dataDay, _) => dataDay.x,
                            yValueMapper: (_ChartData dataDay, _) => dataDay.y,
                            name: 'Reviews  ',
                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                            pointColorMapper: (_ChartData data, _) {
                              return HomeLayout.blueDark;
                            },
                            animationDuration: 300,
                            dataLabelSettings: const DataLabelSettings(
                                textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.black),
                                isVisible: true,
                                labelAlignment: ChartDataLabelAlignment.outer,
                                labelPosition: ChartDataLabelPosition.outside,
                                
                              ),
                          ),
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
