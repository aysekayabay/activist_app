import 'package:akademi_bootcamp/core/constants/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../core/components/app_bar/custom_app_bar.dart';
class EntryScreen extends StatefulWidget {
  const EntryScreen({super.key});

  @override
  State<EntryScreen> createState() => _EntryScreenState();
}

class _EntryScreenState extends State<EntryScreen> {
  late PageController _pageController;
  int _currentPageIndex = 0;


  

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

void goToNextPage() {
    if (_currentPageIndex < demo_data.length - 1) {
      _currentPageIndex++;
      _pageController.animateToPage(
        _currentPageIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }

void goToPreviousPage() {
    if (_currentPageIndex > 0) {
      _currentPageIndex--;
      _pageController.animateToPage(
        _currentPageIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Column(
          children: [
            Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: demo_data.length,
              onPageChanged: (index) {
                  setState(() {
                    _currentPageIndex = index;
                  });
                },
                itemBuilder: (context, index) => EntryContent(
                image: demo_data[index].image,
                title: demo_data[index].title,
                description: demo_data[index].description,
              ),
              ),
            ),
            CustomAppBar(
              context: context,
              left: AppBarWidgets.BACK,
              onTapLeft: goToPreviousPage,
              right: AppBarWidgets.NEXT,
              onTapRight: goToNextPage, 
              leftIconColor: AppColors.white,
              rightIconColor: AppColors.white,
            ),
            SmoothPageIndicator(  
              controller: _pageController,  
              count:  demo_data.length,   
              effect:  SlideEffect(  
              spacing:  20.0,  
              radius:  14,  
              dotWidth:  12.0,  
              dotHeight:  12.0,  
              paintStyle:  PaintingStyle.stroke,  
             strokeWidth:  1.5,  
             dotColor:  AppColors.grey,  
             activeDotColor:  AppColors.white,  
          ),  
         ), 
            const SizedBox(height: 150)
          ],
        ),
      )
    );
  }
}




class Entry {
  final String image, title, description;

  Entry({
    required this.image, 
    required this.title, 
    required this.description});
}

final List<Entry> demo_data = [
  Entry(
    image: "assets/input/map.png",
    title: "VIEW Events\n On The MAP!",
    description: "When you become a member, you will be\n able to see the events on the map!",
    ),
    Entry(
    image: "assets/input/ticket.png",
    title: "If You Want\n You can BUY the\n TICKET!",
    description: "You will be able to buy your ticket for the\n activities  you like!",
    ),
];

class EntryContent extends StatelessWidget {
  const EntryContent({
    super.key, 
    required this.image, 
    required this.title, 
    required this.description,
  });

  final image, title, description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 319,
          width: 390,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.lightGrey, AppColors.black],
              stops: [0,0.7],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              ),
            image: DecorationImage(
              image: AssetImage(
                image,
                ),
                ),
          ),
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: AppColors.white, fontSize: AppSizes.highSize),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          Text(
            description,
              textAlign: TextAlign.center,
            )
      ],
    );
  }
}
