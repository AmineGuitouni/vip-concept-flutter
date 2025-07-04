import 'package:flutter/material.dart';
import 'package:localboss/features/auth/viewModels/auth_provider.dart';
import 'package:localboss/features/business/viewModels/business_data.dart';
import 'package:localboss/features/home/view/pages/home_layout.dart';
import 'package:localboss/features/reviews/viewModels/reviews_provider.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class Loading extends StatefulWidget {
  final int opacity;

  const Loading({super.key, required this.opacity});

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  String state = "signing in";
  bool startLoading = false;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      width: MediaQuery.sizeOf(context).width,
      height: MediaQuery.sizeOf(context).height,
      decoration: BoxDecoration(
        color: Color.fromARGB(widget.opacity, 255, 255, 255),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
              width: 150,
              child: Lottie.asset("lib/core/assets/animations/loading.json")),
          Consumer<AuthProvider>(builder: (context, value, child) {
            if (value.isLoggedIn && !startLoading) {
              startLoading = true;
              state = "loading locations";
              Provider.of<BusinessData>(context, listen: false)
                  .loadBuisnessList()
                  .then((selectedBusiness) {
                if (selectedBusiness != null) {
                  setState(() {
                    state = "loading reviews";
                  });
                  Provider.of<ReviewsData>(context, listen: false)
                      .loadReviews(selectedBusiness)
                      .then((_) {
                    value.finishLoading();
                  });
                } else {
                  value.finishLoading();
                }
              });
            }

            return Text("$state...",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: HomeLayout.blueDark,
                fontStyle: FontStyle.normal,
                decoration: TextDecoration.none,
            ));
          })
        ],
      ),
    ));
  }
}
