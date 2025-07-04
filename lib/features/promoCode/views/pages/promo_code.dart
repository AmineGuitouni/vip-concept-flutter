import 'package:flutter/material.dart';

class PromoCode extends StatelessWidget {
  const PromoCode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Promo Code",
        style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color.fromRGBO(16, 44, 87, 1),
          )
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 40
        ),
        child: const TextField(
          style: TextStyle(
            fontSize: 20
          ),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              gapPadding: 4,
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            labelText: 'Promo Code',
            hintText: 'Enter your promo code',
            hintStyle: TextStyle(
              fontSize: 18
            ),
            labelStyle: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold
            ),
          )
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 20
                  ),
                ),
                child: const Text("Apply Code",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold
                  )
                ),
                onPressed: () async {

                }
              ),
          ),
        ],
      ),
    );
  }
}