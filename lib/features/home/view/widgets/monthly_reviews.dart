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

class MonthlyreviewsContainer extends StatefulWidget {
  const MonthlyreviewsContainer({super.key});

  @override
  State<MonthlyreviewsContainer> createState() =>
      _MonthlyreviewsContainerState();
}

class _MonthlyreviewsContainerState extends State<MonthlyreviewsContainer> {
  late List<List<_ChartData>> data;
  late TooltipBehavior tooltip;

  @override
  void initState() {
    final reviews = Provider.of<ReviewsData>(context, listen: false).reviews;
    final monthCounts = ReviewsStats.monthlyReviews(reviews);

    final sortedKeys = monthCounts.keys.toList()..sort((a, b) => a.compareTo(b));

    data = [[],[],[],[],[]];
    for(var key in sortedKeys){
      for(int i = 0; i < 5; i++){
        data[i].add(_ChartData(monthNames[key.month - 1], monthCounts[key]![i]));
      }
    }

    tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  int sumData(List<List<_ChartData>> data){
    int last = data[0].length - 1;
    if(last < 0) return 0;
    int sum = 0;

    for(int i = 0; i < 5; i++){
      sum += data[i][last].y;
    }
    return sum;
  }

  bool boolMonthlyReviews = true;

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
                const Text(
                  "Monthly reviews",
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
                      position:
                          const StyledToastPosition(align: Alignment.center),
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
                  icon: boolMonthlyReviews
                      ? Icon(CupertinoIcons.arrowtriangle_down_circle_fill,
                          color: HomeLayout.blueCyan, size: 25)
                      : Icon(CupertinoIcons.arrowtriangle_up_circle_fill,
                          color: HomeLayout.blueCyan, size: 25),
                  onPressed: () {
                    setState(() {
                      boolMonthlyReviews = !boolMonthlyReviews;
                    });
                  },
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data[0].isNotEmpty ? sumData(data).toString() : "0",
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  if(data.isNotEmpty && data[0].isNotEmpty) Text(
                    data[0][data[0].length-1].x,
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                ]
              ),
            ),
            if (boolMonthlyReviews)
              Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: SfCartesianChart(
                      zoomPanBehavior: ZoomPanBehavior(
                        enablePanning: true, // Enable horizontal panning
                      ),
                      primaryXAxis: const CategoryAxis(
                        autoScrollingMode: AutoScrollingMode.start,
                        autoScrollingDelta: 2,
                        isVisible: true,
                        labelStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                        majorTickLines:
                            MajorTickLines(width: 0),
                        axisLine: AxisLine(width: 0),
                      ),
                      primaryYAxis: const NumericAxis(
                          isVisible: false,
                          minimum: 0,
                          maximum: 3,
                          interval: 1,
                          labelFormat: '{value}',
                        ),
                      tooltipBehavior: tooltip,
                      series: <CartesianSeries<_ChartData, String>>[
                        ...List.generate(5, (index){
                          return ColumnSeries<_ChartData, String>(
                            dataSource: data[4 - index],
                            xValueMapper: (_ChartData data, _) => data.x,
                            yValueMapper: (_ChartData data, _) => data.y > 0 ? data.y : 0.2,
                            dataLabelMapper: (_ChartData data, _) => data.y.toString(),
                            borderRadius: const BorderRadius.all(Radius.circular(3)),
                            pointColorMapper: (datum, _) {
                              switch (4 - index){
                                case 0: 
                                  return HomeLayout.oneStar;
                                case 1:
                                  return HomeLayout.twoStars;
                                case 2:
                                  return HomeLayout.threeStars;
                                case 3:
                                  return HomeLayout.fourStars;
                                case 4:
                                  return HomeLayout.fiveStars;
                                default:
                                  return HomeLayout.blueCyan;
                              }
                            },
                            name: 'Reviews  ',
                            dataLabelSettings: const DataLabelSettings(
                              textStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.white),
                              isVisible: true,
                              labelAlignment: ChartDataLabelAlignment.middle,
                            ),
                          );
                        })
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 20,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.square,
                            color: HomeLayout.fiveStars,
                            size: 14,
                          ),
                          const Text(
                            " 5 stars",
                            style: TextStyle(
                                fontSize: 10,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.square,
                            color: HomeLayout.fourStars,
                            size: 14,
                          ),
                          const Text(
                            " 4 stars",
                            style: TextStyle(
                                fontSize: 10,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.square,
                            color: HomeLayout.threeStars,
                            size: 14,
                          ),
                          const Text(
                            " 3 stars",
                            style: TextStyle(
                                fontSize: 10,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.square,
                            color: HomeLayout.twoStars,
                            size: 14,
                          ),
                          const Text(
                            " 2 stars",
                            style: TextStyle(
                                fontSize: 10,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.square,
                            color: HomeLayout.oneStar,
                            size: 14,
                          ),
                          const Text(
                            " 1 star",
                            style: TextStyle(
                                fontSize: 10,
                                color: Colors.black,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  )
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
  final int y;
}
