import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localboss/features/home/view/widgets/end_drawer.dart';
import 'package:localboss/features/reviews/viewModels/reviews_provider.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class HomeLayout extends StatelessWidget {
  final Widget child;
  const HomeLayout({super.key, required this.child});

  static Color blueCyan = const Color.fromRGBO(22, 121, 171, 1);
  static Color bgGrey = const Color.fromRGBO(217, 217, 217, 1);
  static Color blueDark = const Color.fromRGBO(16, 44, 87, 1);
  static Color blueWh = const Color.fromRGBO(235, 244, 246, 1);
  static Color oneStar = const Color.fromRGBO(200, 0, 54, 1);
  static Color twoStars = const Color.fromRGBO(255, 105, 105, 1);
  static Color threeStars = const Color.fromRGBO(252, 220, 42, 1);
  static Color fourStars = const Color.fromRGBO(135, 169, 34, 1);
  static Color fiveStars = const Color.fromRGBO(16, 44, 87, 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const EndDrawer(),
      body: child,
      bottomNavigationBar: Consumer<ReviewsData>(
        builder: (context, value, child) => BottomNavigationBar(
          selectedIconTheme: const IconThemeData(fill: 0.9),
          selectedItemColor: blueCyan,
          unselectedItemColor: Colors.black,
    
          currentIndex: GoRouterState.of(context).fullPath == '/home' ? 0 : 2,
          onTap: (index) async {
            bool canNotSwithch = Provider.of<ReviewsData>(context, listen: false).isLoading;
            if(canNotSwithch) return;
            switch (index) {
              case 0:
                if(GoRouterState.of(context).fullPath != '/home'){
                  context.pop();
                }
                break;
              case 1:
                if (value.selectedBusiness == null) return;
                await Share.share(
                    "Click to send ${value.selectedBusiness!.title} your reviews: ${value.selectedBusiness!.newReviewUri}");
                break;
              case 2:
                context.push("/reviews");
                break;
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 24),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add,
                size: 24,
              ),
              label: 'Get more',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.comment, size: 24),
              label: 'Reviews',
            )
          ],
        ),
      ),
    );
  }
}

bool dataExist = false;