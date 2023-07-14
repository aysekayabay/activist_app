import 'package:akademi_bootcamp/core/base/extensions/date_time_converter.dart';
import 'package:akademi_bootcamp/core/base/state/base_state.dart';
import 'package:akademi_bootcamp/core/components/app_bar/custom_app_bar.dart';
import 'package:akademi_bootcamp/core/components/buttons/custom_button.dart';
import 'package:akademi_bootcamp/core/components/image/cached_network_image_widget.card.dart';
import 'package:akademi_bootcamp/core/constants/theme/theme_constants.dart';
import 'package:akademi_bootcamp/core/model/event_model.dart';
import 'package:akademi_bootcamp/core/model/expanded_item.dart';
import 'package:akademi_bootcamp/product/detail_page/detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class DetailView extends StatefulWidget {
  final EventModel eventModel;
  const DetailView({super.key, required this.eventModel});

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends BaseState<DetailView> {
  DetailViewModel _viewModel = DetailViewModel();
  @override
  void initState() {
    super.initState();
    _viewModel.init(widget.eventModel);
  }

  @override
  Widget build(BuildContext context) {
    String buyText = 'Bilet Satın Al';
    // int peopleCount = 8;

    return Scaffold(
      backgroundColor: Color(0xff323232),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            detailHeader(context, _viewModel.gradientColors),
            drawers(),
            buttons(buyText),
          ],
        ),
      ),
    );
  }

  Container drawers() {
    return Container(
      padding: EdgeInsets.all(20),
      child: ExpansionPanelList(
        expandedHeaderPadding: EdgeInsets.zero,
        elevation: 1,
        animationDuration: Duration(milliseconds: 300),
        children: _viewModel.items.map<ExpansionPanel>((EventExpandedItem item) {
          return ExpansionPanel(
            backgroundColor: AppColors.vanillaShake,
            headerBuilder: (BuildContext context, bool isExpanded) {
              return ListTile(
                title: Text(item.headerValue, style: themeData.textTheme.displaySmall!.copyWith(color: AppColors.black)),
              );
            },
            body: ListTile(
              title: Text(item.expandedValue, style: themeData.textTheme.bodyMedium!.copyWith(color: AppColors.black)),
            ),
            isExpanded: item.isExpanded,
          );
        }).toList(),
        expansionCallback: (int index, bool isExpanded) {
          setState(() {
            _viewModel.items[index].isExpanded = !isExpanded;
          });
        },
      ),
    );
  }

  Row buttons(String buyText) {
    return Row(
      children: [
        Expanded(
            child: CustomButton(
                title: buyText,
                isFilled: true,
                verticalPadding: AppSizes.mediumSize,
                marginPadding: EdgeInsets.all(AppSizes.mediumSize),
                textStyle: Theme.of(context).textTheme.displayMedium!.copyWith(color: AppColors.black, fontSize: 16),
                onTap: () => _viewModel.goToTicketSelling(widget.eventModel.ticketUrl))),
        _viewModel.anon
            ? SizedBox()
            : Padding(
                padding: EdgeInsets.only(right: AppSizes.mediumSize),
                child: Observer(builder: (context) {
                  return GestureDetector(
                      onTap: () => _viewModel.favButton(widget.eventModel), child: Icon(_viewModel.isFav ? Icons.favorite_rounded : Icons.favorite_outline_rounded, color: AppColors.red, size: 32));
                }),
              ),
      ],
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
          children: [cachedNetworkImageWidget(posterUrl: widget.eventModel.posterUrl, height: MediaQuery.of(context).size.height / 2), Container(height: AppSizes.highSize)],
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.bottomCenter, end: Alignment.topCenter, colors: gradientColors)),
          ),
        ),
        CustomAppBar(context: context, left: AppBarWidgets.BACK, onTapLeft: () => Navigator.of(context).pop()),
        Positioned(
            bottom: 0,
            left: AppSizes.mediumSize,
            right: AppSizes.mediumSize,
            child: infoWidget(widget.eventModel.name?.trim() ?? '', widget.eventModel.start.toString().formattedDate,
                widget.eventModel.start.toString().formattedTime + "-" + widget.eventModel.end.toString().formattedTime, widget.eventModel.venue?.name ?? '', context))
      ],
    );
  }

  Widget infoWidget(String name, String date, String time, String location, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name, style: Theme.of(context).textTheme.displayLarge),
        SizedBox(height: 10),
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
        Flexible(child: Text(location, overflow: TextOverflow.ellipsis, maxLines: 3, style: TextStyle(color: AppColors.vanillaShake, fontSize: 15))),
      ],
    );
  }

  Row timeWidget(String time) {
    return Row(
      children: [
        Icon(Icons.access_time, size: AppSizes.mediumSize, color: AppColors.vanillaShake),
        SizedBox(width: AppSizes.lowSize),
        Text(time, style: Theme.of(context).textTheme.displaySmall),
      ],
    );
  }

  Row dateWidget(String date) {
    return Row(
      children: [
        Icon(Icons.calendar_month, size: AppSizes.mediumSize, color: AppColors.vanillaShake),
        SizedBox(width: AppSizes.lowSize),
        Text(date, style: Theme.of(context).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.w400)),
      ],
    );
  }
}
