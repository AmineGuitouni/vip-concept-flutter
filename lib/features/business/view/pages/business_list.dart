import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:localboss/features/business/view/widgets/business_item.dart';
import 'package:localboss/features/business/viewModels/business_data.dart';
import 'package:localboss/features/reviews/viewModels/reviews_provider.dart';
import 'package:provider/provider.dart';

class BusinessList extends StatelessWidget{
  const BusinessList({super.key});

  @override
  Widget build(BuildContext context){
    final reviewsProvider = Provider.of<ReviewsData>(context, listen: false);
    return PopScope(
      child: Consumer<BusinessData>( builder: (context, value, child) => Scaffold(
            appBar: AppBar(
              title: const Text(
                  'Business List',
                  style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(16, 44, 87, 1),
                )
              ),
            ),
            body: value.business.isEmpty ? const Center(child: Text('No Business Found')) :
            Column(
              children: value.business.map((element){
                return GestureDetector(
                  onTap: () async {

                    reviewsProvider.loadReviews(element);
                    
                    if(context.mounted){
                      context.pop();
                    }
                  },
                  child: BusinessItem(business: element),
                );
              }).toList(),
            ),
          )
      ),
    );
  }
}