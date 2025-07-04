import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import 'package:localboss/features/ai/view/widgets/ai_credits.dart';
import 'package:localboss/features/ai/view/widgets/ai_settings.dart';
import 'package:localboss/features/auth/services/auth_service.dart';
import 'package:localboss/features/home/view/pages/home_layout.dart';
import 'package:localboss/features/home/view/widgets/about_and_contact.dart';
import 'package:localboss/features/reviews/viewModels/reviews_provider.dart';
import 'package:provider/provider.dart';

class EndDrawer extends StatelessWidget {
  const EndDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: HomeLayout.blueDark,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!),
                    backgroundColor: Colors.grey[500],
                    onBackgroundImageError: (exception, stackTrace) {
                      if (kDebugMode) print('Failed to load image: $exception');
                    },
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  FirebaseAuth.instance.currentUser!.email!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text('Business List'),
            onTap: () {
              Scaffold.of(context).closeEndDrawer();
              context.push("/businessList");
            },
          ),
          ListTile(
            leading: const Icon(Icons.subscriptions),
            title: const Text('Manage Subscriptions'),
            onTap: () {
              Scaffold.of(context).closeEndDrawer();
              context.push("/manageSubscriptions");
            },
          ),
          ListTile(
            leading: const Icon(Icons.discount),
            title: const Text('Promo Code'),
            onTap: () {
              Scaffold.of(context).closeEndDrawer();
              context.push("/promoCode");
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('AI Settings'),
            onTap: () {
              showModalBottomSheet<dynamic>(
                isScrollControlled: true,
                context: context,
                builder: (BuildContext context) {
                  return const AiSettings();
                },
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.credit_score),
            title: const Text('AI Credits'),
            onTap: () {
              showModalBottomSheet<dynamic>(
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return const AicreditsScreen();
                  });
            },
          ),
          ListTile(
            leading: const Icon(Icons.contact_mail),
            title: const Text('About and Contact'),
            onTap: () {
              showModalBottomSheet<dynamic>(
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return const AboutScreen();
                  });
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            onTap: () {
              _showLogoutToast(context);
            },
            title: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  void _showLogoutToast(BuildContext context) {
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
            height: MediaQuery.sizeOf(context).height * 0.45,
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
                Icon(
                  Ionicons.alert_circle,
                  color: HomeLayout.blueDark,
                  size: 150,
                ),
                const Text(
                  "Logout",
                  style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  "Are you sure you want to logout?",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),

                //error message in textformfield is not working in the toast so need other way

                const SizedBox(height: 20),
                SizedBox(
                  width: 140,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: HomeLayout.blueCyan,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    onPressed: () async {
                      Provider.of<ReviewsData>(context, listen: false).reset();
                      await AuthService.signOut();
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
  }
}
