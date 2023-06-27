import 'package:akademi_bootcamp/core/components/app_bar/custom_app_bar.dart';
import 'package:akademi_bootcamp/core/constants/theme/theme_constants.dart';
import 'package:flutter/material.dart';

class MyOnboardingScreen extends StatefulWidget {
  const MyOnboardingScreen({super.key});

  @override
  State<MyOnboardingScreen> createState() => _MyOnboardingScreenState();
}

class _MyOnboardingScreenState extends State<MyOnboardingScreen> {

 late PageController _pageController;

 @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
   _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.vanillaShake,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                itemCount: demo_data.length,
                controller: _pageController,
                itemBuilder: (context, index) => OnboardView(
                image: demo_data[index].image,
                question:  demo_data[index].question,
                title: demo_data[index].title,
              ),
              ),
            ),
            SizedBox(
              child: CustomAppBar(context: context,
              left: AppBarWidgets.BACK,
              onTapLeft: () => Navigator.pop(context),  
              center: AppBarWidgets.TITLE,
              centerTitle: "page 1",
              right: AppBarWidgets.NEXT,
              onTapRight: () => Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext) => MyOnboardingScreen())),
              leftIconColor: AppColors.black,
              rightIconColor: AppColors.black,
              
              ),
            )
          ],
        ),
       
      ),
    );
  }
}

class Onboard {
  final String image, question, title;

  Onboard({
    required this.image,
    required this.question,
    required this.title,
  });
}

final List<Onboard> demo_data = [
  Onboard(
    image: "assets/photos/page1.png",
    question:  "What can you do in this app ?",
    title: "0",
    ),
    Onboard(
    image: "assets/photos/page2.png",
    question:  "What can you do in this app ?",
    title: "Lorem ipsum dolor sit amet consectetur. Nunc diam quis tortor bibendum nisl gravida nulla ultricies at. Tempor in mattis sit cursus. Ac pharetra ultrices vel lacus pharetra vestibulum nam ipsum dolor. Nunc ornare sem aliquet in dolor malesuada quisque.",
    ),
    Onboard(
    image: "assets/photos/page3.png",
    question:  "What can you do in this app ?",
    title: "Lorem ipsum dolor sit amet consectetur. Nunc diam quis tortor bibendum nisl gravida nulla ultricies at. Tempor in mattis sit cursus. Ac pharetra ultrices vel lacus pharetra vestibulum nam ipsum dolor. Nunc ornare sem aliquet in dolor malesuada quisque.",
    ),
    Onboard(
    image: "assets/photos/page4.png",
    question:  "What can you do in this app ?",
    title: "Lorem ipsum dolor sit amet consectetur. Nunc diam quis tortor bibendum nisl gravida nulla ultricies at. Tempor in mattis sit cursus. Ac pharetra ultrices vel lacus pharetra vestibulum nam ipsum dolor. Nunc ornare sem aliquet in dolor malesuada quisque.",
    ),
];

class OnboardView extends StatelessWidget {
  const OnboardView({
    super.key,
     this.image,
     this.question, 
     this.title,
  });

  final image, question, title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          image,
          ),
      Text(
       question,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: AppColors.black),
        ),
        const SizedBox(height: 16,),
      Text(
        title,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.darkGrey),
      textAlign: TextAlign.center,
      ),
    ]
    );
  }
}