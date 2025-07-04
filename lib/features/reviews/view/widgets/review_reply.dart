import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:localboss/core/constants.dart';
import 'package:localboss/core/utils.dart';
import 'package:localboss/features/ai/view/widgets/ai_settings.dart';
import 'package:localboss/features/auth/services/auth_service.dart';
import 'package:localboss/features/auth/viewModels/user_credentials_provider.dart';
import 'package:localboss/features/reviews/models/reviews_model.dart';
import 'package:localboss/features/reviews/viewModels/reviews_provider.dart';
import 'package:localboss/features/ai/viewModels/ai_settings.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ReviewReply extends StatefulWidget {
  final ReviewsModel review;
  const ReviewReply({ super.key, required this.review });

  @override
  State<ReviewReply> createState() => _ReviewReplyState();
}

class _ReviewReplyState extends State<ReviewReply> {
  ReviewsModel get review => widget.review;
  final TextEditingController textController = TextEditingController();

  bool isLoading = false;
  String state = "";
  
  @override
  void initState() {
    super.initState();
    textController.text = review.reply != null ? review.reply!.comment : "";
  }
  
  @override
  Widget build(BuildContext context) {
    final userDataPorvider = Provider.of<UserCredentialsProvider>(context, listen: true);
    final reviewsProvider = Provider.of<ReviewsData>(context, listen: true);
    return PopScope(
      canPop: !isLoading,
      child: Container(
        height: 500 + MediaQuery.of(context).viewInsets.bottom * 0.7,
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(
          vertical: 24.0,
          horizontal: 16.0,
        ),
        child: Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(review.reviewer.profilePhotoUrl),
                          //backgroundImage: const AssetImage("lib/assets/back.jpg"),
                          backgroundColor: Colors.grey[500],
                          onBackgroundImageError: (exception, stackTrace) {
                            if(kDebugMode) print('Failed to load image: $exception');
                          },
                          radius: 16,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 4.0,
                            horizontal: 8.0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                review.reviewer.displayName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              Row(
                                children: [
                                  ...List.generate(5, (index) {
                                    return Icon(
                                      index < review.starRating ? Icons.star : Icons.star_border,
                                      color: Colors.blue[900],
                                      size: 12,
                                    );
                                  }),
                                  const SizedBox(width: 8),
                                  Text(
                                    getTime(review.createTime),
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                ]
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(review.comment),
                              const SizedBox(
                                height: 10,
                              ),
                            ]
                          ),
                        ),
                      ]
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                
                      children: [
                        const Text(
                          "your Reply :",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: (){
                                // bech tala3 help w tips
                              },
                              icon: const Icon(Icons.question_mark_rounded),
                              iconSize: 16,
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(Colors.grey[400]),
                                minimumSize: WidgetStateProperty.all(const Size(12, 12)),
                              ),
                            ),
                            IconButton(
                              onPressed: ()async{
                                await deleteReply();
                                setState(() {
                                  review.reply = null;
                                  textController.text = "";
                                });
                                reviewsProvider.deleteReply(review);
                              },
                              icon: const Icon(Icons.delete),
                              iconSize: 16,
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(Theme.of(context).colorScheme.error),
                                minimumSize: WidgetStateProperty.all(const Size(16, 16)),
                              ),
                            )
                          ]
                        )
                      ]
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextField(
                      minLines: 3,
                      maxLines: 100,
                      controller: textController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Add your reply here...",
                        hintStyle: TextStyle(
                          fontSize: 12,
                        )
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              if(userDataPorvider.user == null || userDataPorvider.user!.aiCredit <= 0){
                                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("You don't have enough credit")));
                                return;
                              }
                              aiReply();
                            }, 
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              shape: const ContinuousRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(16))),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).colorScheme.error,
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Center(
                                    child: Text(
                                      userDataPorvider.user != null ? userDataPorvider.user!.aiCredit.toString() : "0",
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold
                                      )
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                const Text(
                                  "ai reply",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                  )
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                const Icon(Ionicons.chatbubble,size: 16, color: Colors.white),
                              ]
                            )
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              _showBottomSheet(context);
                            }, 
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).colorScheme.primary,
                              shape: const ContinuousRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(16))),
                            ),
                            child: const Row( 
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "ai Settings",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white
                                  )
                                ),
                                  SizedBox(
                                  width: 8,
                                ),
                                Icon(Ionicons.settings,size: 16, color: Colors.white),
                              ]
                            )
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Center(
                      child: ElevatedButton(
                        onPressed: () async {
                          ReplyModel? reply = await sendReply();
                          reviewsProvider.addReply(review, reply);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
                          shape: const ContinuousRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "reply",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary
                              )
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Icon(Ionicons.send_outline,size: 16, color: Theme.of(context).colorScheme.primary),
                          ]
                        )
                      ),
                    )
                  ],
                ),
              ),
              if(isLoading) Opacity(
                opacity: 0.5,
                child: Container(
                  height: 500,
                  width: double.maxFinite,
                  color: Colors.white,
                ),
              ),
              if(isLoading) Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 150,
                      child: Lottie.asset("lib/core/assets/animations/loading.json")
                    ),
                    Text(state,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                      )
                    )
                  ],
                )
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<ReplyModel?> sendReply() async {
    if(textController.text.isEmpty || textController.text == review.reply?.comment){
      return null;
    }

    setState(() {
      isLoading = true;
      state = "sending reply...";
    });

    final replyReq = {
      "name": review.name,
      "accessToken" : await AuthService().getAccessToken(),
      "updateTime": getRfc3339ZuluTimestamp(),
      "comment": textController.text
    };

    final reviewsResult = await http.post(
      Uri.parse('$apiBaseUrl/api/reply'),
      body: replyReq,
    );

    final reviewData = jsonDecode(reviewsResult.body);

    setState(() {
      isLoading = false;
      state = "";
    });

    return ReplyModel(
      comment: reviewData['comment'],
      updateTime: reviewData['updateTime']
    );
  }

  Future<void> deleteReply() async {
    setState(() {
      isLoading = true;
      state = "deleting reply...";
    });

    final replyReq = {
      "name": review.name,
      "accessToken" : await AuthService().getAccessToken(),
    };

    final reviewsResult = await http.post(
      Uri.parse('$apiBaseUrl/api/reply/delete'),
      body: replyReq,
    );

    final data = jsonDecode(reviewsResult.body);

    if(data["error"] != null){
      if(kDebugMode) print("error : ${data["error"]}");
    }

    setState(() {
      isLoading = false;
      state = "";
    });
  }

  String getReviewComment(ReviewsModel review){
    List<String> reviewList = review.comment.split("(Original)");

    return reviewList[reviewList.length-1].trim();
  }
  Future<void> aiReply() async {
    final provider = Provider.of<AiSettingsProvider>(context, listen: false);
    final dataProvider = Provider.of<UserCredentialsProvider>(context, listen: false);

    if(dataProvider.user == null){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("out of credits!")));
      return;
    }

    if(dataProvider.user!.aiCredit == 0){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("out of credits!")));
      return;
    }

    setState(() {
      isLoading = true;
      state = "generating ai reply...";
    });

    final replyReq = {
      "review": getReviewComment(review),
      "userId": FirebaseAuth.instance.currentUser!.uid,
      "aiSettings":{
        "useEmojis": provider.useEmojis,
        "responseLength": provider.responseLength,
        "customOptions": provider.customOptions
      }
    };

    final aiResult = await http.post(
      Uri.parse('$apiBaseUrl/api/ai/reply'),
      headers: {
        "Content-Type": "application/json", // Set the content type to application/json
      },
      body: jsonEncode(replyReq),
    );

    final data = jsonDecode(aiResult.body);

    setState(() {
      isLoading = false;
      state = "";
    });

    if(data["error"] != null){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("error : ${data["error"]}")));
      return;
    }
    
    dataProvider.addAiCredits(-1);

    textController.text = data['reply'];
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet<dynamic>(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return const AiSettings();
      },
    );
  }
}