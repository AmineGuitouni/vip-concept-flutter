import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:ionicons/ionicons.dart';
import 'package:localboss/features/home/view/pages/home_layout.dart';

class ThesecrettomorerevContainer extends StatelessWidget {
  const ThesecrettomorerevContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            InkWell(
              onTap: () {
                showToastWidget(
                  reverseAnimation: StyledToastAnimation.fade,
                  //dismissOtherToast: false,
                  context: context,
                  animation: StyledToastAnimation.fade,
                  isIgnoring: false,
                  duration: Duration.zero,
                  animDuration: const Duration(milliseconds: 200),
                  position: const StyledToastPosition(align: Alignment.center),
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
                        height: MediaQuery.sizeOf(context).height * 0.52,
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
                              "The secret to more Reviews",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            const Text(
                              textAlign: TextAlign.center,
                              "Asking for customer reviews can be a game changer for your business and get much higher ratings. The secret is to emphasize that you're seeking honest feedback to help improve your business, rather than just asking for high ratings. Try it. People will leave you awesome reviews and this approach will lead to increased credibility and better Google ratings for your business.",
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
              child: Container(
                height: 50.0,
                //width: MediaQuery.of(context).size.width - 20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: HomeLayout.blueWh),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    children: [
                      Icon(Icons.info_rounded, color: HomeLayout.blueCyan),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        "The Secret to More Reviews",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            InkWell(
              onTap: () {
                showToastWidget(
                  reverseAnimation: StyledToastAnimation.fade,
                  //dismissOtherToast: false,
                  context: context,
                  animation: StyledToastAnimation.fade,
                  isIgnoring: false,
                  duration: Duration.zero,
                  animDuration: const Duration(milliseconds: 200),
                  position: const StyledToastPosition(align: Alignment.center),
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
                        height: MediaQuery.sizeOf(context).height * 0.55,
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
                              "Always answer 1-star reviews",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              textAlign: TextAlign.center,
                              "Quick response to 1-star reviews is critical. It can help resolve any issues before they escalate. Prompt attention to negative feedback can also demonstrate your commitment to customer satisfaction, which can improve your online reputation and increase customer loyalty. It also shows to anyone reading that you're proactive and engaged when things go wrong, which is a peace of mind for them.",
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
              child: Container(
                height: 50.0,
                //width: MediaQuery.of(context).size.width - 20,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: HomeLayout.blueWh),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Row(
                    children: [
                      Icon(Icons.info_rounded, color: HomeLayout.blueCyan),
                      const SizedBox(
                        width: 5,
                      ),
                      const Text(
                        "Always answer 1-star reviews",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
