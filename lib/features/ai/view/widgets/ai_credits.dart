import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:localboss/features/ai/repo/ai_credits_payment.dart';
import 'package:localboss/features/auth/viewModels/user_credentials_provider.dart';
import 'package:localboss/features/home/view/pages/home_layout.dart';
import 'package:provider/provider.dart';

class AicreditsScreen extends StatefulWidget {
  const AicreditsScreen({super.key});

  @override
  State<AicreditsScreen> createState() => _AicreditsScreenState();
}

class _AicreditsScreenState extends State<AicreditsScreen> {
  int chechedOffer = -1;
  bool loading = false;

  void setChechedOffer(int index) {
    setState(() {
      chechedOffer = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topRight: Radius.circular(30), topLeft: Radius.circular(30)),
          color: Colors.grey[200]),
      height: MediaQuery.sizeOf(context).height * 0.9,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 40,
            ),
            CircleAvatar(
              backgroundColor: HomeLayout.blueCyan,
              child: Icon(
                Ionicons.star_half,
                color: HomeLayout.bgGrey,
              ),
            ),
            Consumer<UserCredentialsProvider>(
              builder: (context, value, child) => Text(
                "AI Credits : ${value.user != null ? value.user!.aiCredit : 0}",
                style:
                    const TextStyle(fontSize: 27, fontWeight: FontWeight.w900),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              "Puchase AI Credits to generate AI review replies.",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 20,
            ),
            AICreditWidget(
              index: 0,
              isCheched: chechedOffer == 0,
              offre: "100",
              price: "10.00",
              fonction: setChechedOffer,
            ),
            const SizedBox(
              height: 20,
            ),
            AICreditWidget(
              index: 1,
              isCheched: chechedOffer == 1,
              offre: "500",
              price: "45.00",
              fonction: setChechedOffer,
            ),
            const SizedBox(
              height: 20,
            ),
            AICreditWidget(
              index: 2,
              isCheched: chechedOffer == 2,
              offre: "1000",
              price: "75.00",
              fonction: setChechedOffer,
            ),
            const Spacer(),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: HomeLayout.blueCyan,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  fixedSize:
                      Size.fromWidth(MediaQuery.of(context).size.width * 0.5),
                ),
                onPressed: loading
                    ? null
                    : () async {
                        final provider = Provider.of<UserCredentialsProvider>(
                            context,
                            listen: false);
                        if (provider.user == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please login first"),
                            ),
                          );
                          return;
                        }

                        if (chechedOffer == -1) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Please select an offer"),
                            ),
                          );
                          return;
                        }

                        setState(() {
                          loading = true;
                        });

                        final isValid = await AiCreditsPayment.makeAiPayment(
                            context,
                            chechedOffer == 0
                                ? 100
                                : chechedOffer == 1
                                    ? 500
                                    : 1000);

                        if (isValid) {
                          provider.addAiCredits((chechedOffer == 0
                              ? 100
                              : chechedOffer == 1
                                  ? 500
                                  : 1000));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Payment failed"),
                            ),
                          );
                        }

                        setState(() {
                          loading = false;
                        });
                      },
                child: const Text(
                  "Get AI Credits",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                )),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}

class AICreditWidget extends StatelessWidget {
  final bool isCheched;
  final String offre;
  final String price;
  final Function(int) fonction;
  final int index;

  const AICreditWidget(
      {super.key,
      required this.isCheched,
      required this.offre,
      required this.price,
      required this.fonction,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 42,
        width: MediaQuery.sizeOf(context).width * 0.85,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Row(
          children: [
            Checkbox(
                activeColor: Colors.black,
                //materialTapTargetSize: MaterialTapTargetSize.padded,
                shape: const CircleBorder(),
                value: isCheched,
                onChanged: (val) {
                  if (isCheched) {
                    fonction(-1);
                  }
                  fonction(index);
                }),
            const SizedBox(
              width: 10,
            ),
            Text(
              "$offre AI Credits",
              style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: Colors.black),
            ),
            const Spacer(),
            Text(
              "$price \$US",
              style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.black),
            ),
            const SizedBox(
              width: 15,
            )
          ],
        ));
  }
}
