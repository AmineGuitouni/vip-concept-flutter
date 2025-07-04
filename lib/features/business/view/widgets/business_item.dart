import 'package:flutter/material.dart';
import 'package:localboss/features/business/models/buisness_model.dart';

class BusinessItem extends StatelessWidget{
  final BuisnessModel business;

  const BusinessItem({super.key, required this.business});

  @override
  Widget build(BuildContext context){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
        leading: const CircleAvatar(
          radius: 30,
          backgroundColor: Colors.blueGrey,
          child: Icon(Icons.business),
        ),
        title: Text(
          business.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Row(
            children: [
               ...List.generate(5, (index) {
                return Icon(
                  index + 1 < business.averageRating.round() ? Icons.star : Icons.star_border,
                  color: Colors.blue[900],
                  size: 20,
                );
              }),
              
            ]
          ),
      ),
    );
  }
}