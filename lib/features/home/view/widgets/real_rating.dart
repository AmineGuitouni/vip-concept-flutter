import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:ionicons/ionicons.dart';
import 'package:localboss/features/home/view/pages/home_layout.dart';
import 'package:localboss/features/reviews/viewModels/reviews_provider.dart';
import 'package:provider/provider.dart';

class RealRatingContainer extends StatelessWidget {
  const RealRatingContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ReviewsData>(
        builder: (context, value, child) => SizedBox(
              height: value.selectedBusiness != null &&
                      !value.reviews.isNotEmpty
                  ? 200
                  : 270,
              width: MediaQuery.of(context).size.width - 20,
              child: value.selectedBusiness != null && !value.reviews.isNotEmpty ? Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            decoration: BoxDecoration(
                                color: HomeLayout.blueDark,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10))),
                            child: const Center(
                              child: Text(
                                'Get your first review',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const Divider(
                          color: Colors.black,
                          height: 1,
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            width: MediaQuery.of(context).size.width - 20,
                            decoration: BoxDecoration(
                              color: HomeLayout.bgGrey,
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Do you think there is an error?',
                                  style: TextStyle(
                                    color: HomeLayout.blueDark,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    if(value.selectedBusiness != null){
                                      value.loadReviews(value.selectedBusiness!);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: HomeLayout.blueDark,
                                  ),
                                  child: const Text(
                                    'Reload Data',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(
                      width: MediaQuery.of(context).size.width - 2,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage(
                              "lib/core/assets/images/realRating.png"),
                          fit: BoxFit.cover,
                        ),
                        color: HomeLayout.blueDark,
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Real Rating",
                                  style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: HomeLayout.blueDark),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Ionicons.alert_circle_outline,
                                    color: HomeLayout.blueDark,
                                    size: 35,
                                  ),
                                  onPressed: () {
                                    showToastWidget(
                                      reverseAnimation:
                                          StyledToastAnimation.fade,
                                      //dismissOtherToast: false,
                                      context: context,
                                      animation: StyledToastAnimation.fade,
                                      isIgnoring: false,
                                      duration: Duration.zero,
                                      animDuration:
                                          const Duration(milliseconds: 200),
                                      position: const StyledToastPosition(
                                          align: Alignment.center),
                                      Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          ModalBarrier(
                                            color:
                                                Colors.black.withOpacity(0.7),
                                            dismissible:
                                                false, // Prevents dismissing the toast by tapping outside
                                          ),
                                          // Container(
                                          //   color: Colors.black,
                                          //   height: 50,
                                          //   width: 50,
                                          // ),
                                          Container(
                                            height: MediaQuery.sizeOf(context)
                                                    .height *
                                                0.35,
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.9,
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 10, 20, 0),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(18),
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
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
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    IconButton(
                                                        //alignment: Alignment.topRight,
                                                        onPressed: () {
                                                          dismissAllToast(
                                                              showAnim: true);
                                                        },
                                                        icon: const Icon(
                                                          Ionicons
                                                              .close_circle_outline,
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
                                                const Text(
                                                  textAlign: TextAlign.center,
                                                  "This is the Real rating, not rounded, calculated the same way Google does. Notice how it can be higher or lower than the public rating due to rounding",
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
                                                        backgroundColor:
                                                            HomeLayout.blueDark,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20))),
                                                    onPressed: () {
                                                      dismissAllToast(
                                                          showAnim: true);
                                                    },
                                                    child: const Text("Accept",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500)),
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
                              ],
                            ),
                            Text(
                              //TODO: here
                              value.selectedBusiness != null
                                  ? ((value.selectedBusiness!.averageRating * 1000).toInt() / 1000).toString()
                                  : "0.0",
                              //"5.21",
                              style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.w400,
                                  color: HomeLayout.blueDark),
                            )
                          ],
                        ),
                      ),
                    ),
            ));
  }
}
