import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:localboss/features/auth/services/auth_service.dart';
import 'package:localboss/features/auth/viewModels/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage("lib/core/assets/images/vipConceptBack.png"),
              fit: BoxFit.contain,
              alignment: Alignment(1, 0)
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const Spacer(
                  flex: 2,
                ),
                const Image(image: AssetImage("lib/core/assets/images/vipconcept.png")),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 4,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    )
                  ]),
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      fixedSize: Size.fromWidth(
                          MediaQuery.of(context).size.width * 0.8),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                          color: Color.fromRGBO(36, 52, 96, 1),
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      AuthService().signInWithGoogle(Provider.of<AuthProvider>(context, listen: false));
                    },
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      fixedSize: Size.fromWidth(
                          MediaQuery.of(context).size.width * 0.8),
                    ),
                    onPressed: () async {
                      if(kDebugMode) print(await AuthService().getAccessToken());
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          CupertinoIcons.exclamationmark_circle,
                          color: Color.fromRGBO(36, 52, 96, 1),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "App's Persmissions",
                          style: TextStyle(
                              color: Color.fromRGBO(36, 52, 96, 1),
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )),
                const Spacer(
                  flex: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Terms & Conditions",
                        style: TextStyle(
                            fontSize: 18, color: Color.fromRGBO(36, 52, 96, 1)),
                      ),
                    ),
                    const Text(
                      "-",
                      style: TextStyle(
                          fontSize: 20, color: Color.fromRGBO(36, 52, 96, 1)),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Get Help",
                        style: TextStyle(
                            fontSize: 18, color: Color.fromRGBO(36, 52, 96, 1)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
