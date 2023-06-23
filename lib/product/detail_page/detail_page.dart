import 'package:akademi_bootcamp/core/base/extensions/date_time_converter.dart';
import 'package:akademi_bootcamp/core/components/app_bar/custom_app_bar.dart';
import 'package:akademi_bootcamp/core/components/buttons/custom_button.dart';
import 'package:akademi_bootcamp/core/constants/theme/theme_constants.dart';
import 'package:akademi_bootcamp/core/model/event_model.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  final EventModel eventModel;
  const DetailPage({super.key, required this.eventModel});

  @override
  Widget build(BuildContext context) {
    String buyText = 'Bilet Satın Al';
    int peopleCount = 8;
    List<Color> gradientColors = [
      Color(0xff323232),
      Color(0xff323232),
      Color(0xff323232),
      Color(0xff323232),
      Color(0xff323232),
      Color(0xff323232),
      Color(0xff323232),
      Color(0xff323232),
      Color(0xff323232).withOpacity(0.9),
      Color(0xff323232).withOpacity(0.8),
      Color(0xff323232).withOpacity(0.7),
      Color(0xff323232).withOpacity(0.6),
      Color(0xff323232).withOpacity(0.5),
      Color(0xff323232).withOpacity(0.4),
      Color(0xff323232).withOpacity(0.3),
      Color(0xff323232).withOpacity(0.2),
      Color(0xff323232).withOpacity(0.1),
      Color(0xff323232).withOpacity(0.05),
      Color(0xffD9D9D9).withOpacity(0)
    ];
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff323232),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            detailHeader(context, gradientColors),
            eventPeopleLiked(peopleCount),
            CustomButton(title: buyText, isFilled: true, verticalPadding: AppSizes.mediumSize, marginPadding: EdgeInsets.all(AppSizes.mediumSize)),
          ],
        ),
      ),
    );
  }

  Widget eventPeopleLiked(int peopleCount) {
    return Padding(
      padding: EdgeInsets.only(left: AppSizes.mediumSize),
      child: Row(
        children: [
          Stack(
              children: List.generate(peopleCount > 5 ? 5 : peopleCount, (index) {
            return Padding(
              padding: EdgeInsets.only(left: 32.0 * index),
              child: personCircleAvatar(),
            );
          })),
          Visibility(
            visible: peopleCount > 5,
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                "+${peopleCount - 5}",
                style: TextStyle(color: AppColors.vanillaShake),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container personCircleAvatar() {
    return Container(
      width: 50,
      height: 50,
      child: ClipOval(child: Image.network("https://picsum.photos/200")),
    );
  }

  Stack detailHeader(BuildContext context, List<Color> gradientColors) {
    return Stack(
      children: [
        Column(
          children: [Image.network(eventModel.posterUrl ?? '', height: MediaQuery.of(context).size.height / 2, fit: BoxFit.fitHeight), Container(height: AppSizes.highSize)],
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: MediaQuery.of(context).size.height / 4,
            decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.bottomCenter, end: Alignment.topCenter, colors: gradientColors)),
          ),
        ),
        CustomAppBar(context: context, left: AppBarWidgets.BACK, right: AppBarWidgets.FAVOURITE),
        Positioned(
            bottom: 0,
            left: AppSizes.mediumSize,
            right: AppSizes.mediumSize,
            child: infoWidget(eventModel.name?.trim() ?? '', eventModel.start.toString().formattedDate, eventModel.start.toString().formattedTime + "-" + eventModel.end.toString().formattedTime,
                eventModel.venue?.name ?? '', context))
      ],
    );
  }

  Widget infoWidget(String name, String date, String time, String location, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: Theme.of(context).textTheme.headline1),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            dateWidget(date),
            timeWidget(time),
          ],
        ),
        SizedBox(height: AppSizes.lowSize),
        locationWidget(location)
      ],
    );
  }

  Row locationWidget(String location) {
    return Row(
      children: [
        Icon(Icons.location_on, size: AppSizes.mediumSize, color: AppColors.vanillaShake),
        SizedBox(width: AppSizes.lowSize),
        Text(location, style: TextStyle(color: AppColors.vanillaShake, fontSize: 15)),
      ],
    );
  }

  Row timeWidget(String time) {
    return Row(
      children: [
        Icon(Icons.access_time, size: AppSizes.mediumSize, color: AppColors.vanillaShake),
        SizedBox(width: AppSizes.lowSize),
        Text(time, style: TextStyle(color: AppColors.vanillaShake, fontSize: 15)),
      ],
    );
  }

  Row dateWidget(String date) {
    return Row(
      children: [
        Icon(Icons.calendar_month, size: AppSizes.mediumSize, color: AppColors.vanillaShake),
        SizedBox(width: AppSizes.lowSize),
        Text(date, style: TextStyle(color: AppColors.vanillaShake, fontSize: 15)),
      ],
    );
  }
}
