import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:localboss/core/utils.dart';
import 'package:localboss/features/auth/viewModels/user_credentials_provider.dart';
import 'package:localboss/features/home/view/pages/home_layout.dart';
import 'package:localboss/features/subscription/repo/payment.dart';
import 'package:provider/provider.dart';

class ManageSubscriptions extends StatefulWidget {
  const ManageSubscriptions({super.key});

  @override
  State<ManageSubscriptions> createState() => _ManageSubscriptionsState();
}

class _ManageSubscriptionsState extends State<ManageSubscriptions> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HomeLayout.blueCyan,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        color: Colors.black,
                        Ionicons.close_circle_outline,
                        size: 35,
                      )),
                ],
              ),
              const Text(
                "Take control",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.w800),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Unlock vital insights, elevate ratings, attract clients",
                style: TextStyle(fontSize: 15, color: Colors.black),
              ),
              const Spacer(),
              SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.35,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 70,
                      ),
                      Container(
                        height: MediaQuery.sizeOf(context).height * 0.32,
                        width: MediaQuery.sizeOf(context).width * 0.55,
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Monthly",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.w800),
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              const Text("includes 0 AI Credits to reply"),
                              const Text(" reviews with AI"),
                              const SizedBox(
                                height: 12,
                              ),
                              RichText(
                                text: const TextSpan(
                                    style: TextStyle(fontSize: 17),
                                    children: [
                                      TextSpan(
                                        text: "3,29 \$US",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w800),
                                      ),
                                      TextSpan(
                                        text: "/month",
                                        style: TextStyle(
                                          //fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ]),
                              ),
                              const Text(
                                "Cancel any time",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.w800),
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      Stack(
                        alignment: Alignment.topCenter,
                        children: [
                          // Container(
                          //   color: Colors.amber,
                          //   height: MediaQuery.sizeOf(context).height * 0.4,
                          //   width: MediaQuery.sizeOf(context).width * 0.55,
                          // ),
                          Container(
                            height: MediaQuery.sizeOf(context).height * 0.32,
                            width: MediaQuery.sizeOf(context).width * 0.55,
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 7,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "Yearly",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  const Text("includes 0 AI Credits to reply"),
                                  const Text(" reviews with AI"),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  RichText(
                                    text: const TextSpan(
                                        style: TextStyle(fontSize: 17),
                                        children: [
                                          TextSpan(
                                            text: "33,05 \$US",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w800),
                                          ),
                                          TextSpan(
                                            text: "/year",
                                            style: TextStyle(
                                              //fontWeight: FontWeight.bold,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ]),
                                  ),
                                  const Text(
                                    "Cancel any time",
                                    style: TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            //         Positioned(
                            top:
                                2.0, // Adjust this value to control how much the container overlaps
                            //left: 10, // Center horizontally
                            // child: SizedBox(
                            child: Container(
                              height: 30,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.green,
                                boxShadow: const [
                                  // BoxShadow(
                                  //   color: Colors.black.withOpacity(0.3),
                                  //   spreadRadius: 2,
                                  //   blurRadius: 7,
                                  //   offset: const Offset(0, 3),
                                  // ),
                                ],
                              ),
                              //color: Colors.red,
                              child: const Center(
                                  child: Text(
                                "Get 20% off",
                                style: TextStyle(color: Colors.white),
                              )),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 70,
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(
                flex: 2,
              ),
              SizedBox(
                height: 45,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[500],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20))),
                  onPressed: loading
                      ? null
                      : () async {
                          UserCredentialsProvider provider = Provider.of<UserCredentialsProvider>(context,listen: false);

                          if (isSubscribed(provider.user?.subscriptionDate)) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("You have already subscribed for 1 year")));
                            return;
                          }
                          setState(() {
                            loading = true;
                          });
                          bool isValid = await Payment.makePayment(context);
                          
                          if (isValid) {
                            provider.updateSubscriptionDate(Timestamp.now());
                          }
                          setState(() {
                            loading = false;
                          });
                        },
                  child: const Text("Subscribe 1 month for 3,29 \$US",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              RichText(
                text: const TextSpan(style: TextStyle(fontSize: 13), children: [
                  TextSpan(
                    text: "You have ",
                    style: TextStyle(
                      //fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  TextSpan(
                    text: "0 reviews ",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w800),
                  ),
                  TextSpan(
                    text: "in 1 locations.",
                    style: TextStyle(
                      //fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ]),
              ),
              const Text(
                "Do you need an invoice? Contact us",
                style: TextStyle(
                    //fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 13),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {},
                    child: const Text(
                      "Promo code- ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: const Text(
                      "Restore- ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: const Text(
                      "Logout- ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: const Text(
                      "Get help",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
