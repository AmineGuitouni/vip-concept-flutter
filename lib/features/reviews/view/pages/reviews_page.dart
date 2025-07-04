
import 'package:flutter/material.dart';
import 'package:localboss/features/reviews/view/widgets/reviews_list.dart';
import 'package:localboss/features/reviews/viewModels/reviews_provider.dart';
import 'package:provider/provider.dart';

class ReviewsPage extends StatefulWidget {
  const ReviewsPage({
    super.key,
  });

  @override
  State<ReviewsPage> createState() => _ReviewsContainerState();
}

class _ReviewsContainerState extends State<ReviewsPage> {
  bool showAll = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        title: Row(
          children: [
            const Icon(
              Icons.reviews,
              size: 24,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              "Reviews",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      showAll = true;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: showAll
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.surfaceContainer,
                    shape: const ContinuousRectangleBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(16))),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.all_inbox_outlined,
                        color: showAll
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.onSurface,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "All Reviews",
                        style: TextStyle(
                            color: showAll
                                ? Theme.of(context).colorScheme.onPrimary
                                : Theme.of(context).colorScheme.onSurface),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      showAll = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: !showAll
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.surfaceContainer,
                    shape: const ContinuousRectangleBorder(
                        borderRadius:
                            BorderRadius.all(Radius.circular(16))),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.reply_all_outlined,
                        color: !showAll
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.onSurface,
                        textDirection: TextDirection.rtl,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Non Replied",
                        style: TextStyle(
                            color: !showAll
                                ? Theme.of(context).colorScheme.onPrimary
                                : Theme.of(context).colorScheme.onSurface),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          //const SizedBox(height: 8,),
          Consumer<ReviewsData>(builder: (context, value, child){
            value.reviews.forEach((r){
              print(r.updateTime);
              print(r.comment);
            });
            return Expanded(
              child: ReviewsList(
              reviews: value.reviews,
              showAll: showAll,
            ));
          })
        ],
      )
    );
  }
}