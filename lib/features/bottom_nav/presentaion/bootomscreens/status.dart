import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_view/widgets/story_view.dart';
import '../../../../core/component_widgets/reuse/reuse.dart';
import '../../../../main.dart';
import '../../../chat/presentation/chatDetails.dart';
import '../../cubit/user/userStates.dart';
import '../../cubit/user/usercubit.dart';

class StoryScreen extends StatelessWidget {
  List<StoryItem> stories = [
    StoryItem.text(
      title: "أهلاً بيك في أول ستوري ✨",
      backgroundColor: Colors.blue,
    ),
    StoryItem.pageImage(
      url: "https://mostaql.hsoubcdn.com/public/assets/images/application-approved.svg?id=e5d66932033f810e1e26604e72a830ce",
      controller: controller,
      caption: Text("منتج جديد نازل 🔥"),
    ),
    StoryItem.pageImage(
      url: "https://media.istockphoto.com/id/1465343359/vector/continuous-teamwork-and-human-solidarity-idea-logo.jpg?s=612x612&w=0&k=20&c=9mnZx8_cmHCu-FZiYc9AoFJ3oInPScMKGMPAg9nu19A=",
      controller: controller,
      caption: Text("خصم 50% اليوم بس"),
    ),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoryView(
        storyItems: stories,
        controller: controller,
        repeat: false,
        onComplete: () {
          Navigator.pop(context);
        },
      )
      ,
    );
  }
}
