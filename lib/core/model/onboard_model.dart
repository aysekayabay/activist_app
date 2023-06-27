import '../constants/image/image_constants.dart';

class OnboardModel {
  final String image, title, description, pageName;

  OnboardModel({
    required this.image,
    required this.title,
    required this.description,
    required this.pageName,
  });
}

final List<OnboardModel> onboard_data = [
  OnboardModel(
      image: ImageConstants.ONBOARD1,
      title: "What can you do in this app ?",
      description:
          "Lorem ipsum dolor sit amet consectetur. Nunc diam quis tortor bibendum nisl gravida nulla ultricies at. Tempor in mattis sit cursus. Ac pharetra ultrices vel lacus pharetra vestibulum nam ipsum dolor. Nunc ornare sem aliquet in dolor malesuada quisque.",
      pageName: "Concert Information"),
  OnboardModel(
      image: ImageConstants.ONBOARD2,
      title: "What can you do in this app ?",
      description:
          "Lorem ipsum dolor sit amet consectetur. Nunc diam quis tortor bibendum nisl gravida nulla ultricies at. Tempor in mattis sit cursus. Ac pharetra ultrices vel lacus pharetra vestibulum nam ipsum dolor. Nunc ornare sem aliquet in dolor malesuada quisque.",
      pageName: "Theater Information"),
  OnboardModel(
      image: ImageConstants.ONBOARD3,
      title: "What can you do in this app ?",
      description:
          "Lorem ipsum dolor sit amet consectetur. Nunc diam quis tortor bibendum nisl gravida nulla ultricies at. Tempor in mattis sit cursus. Ac pharetra ultrices vel lacus pharetra vestibulum nam ipsum dolor. Nunc ornare sem aliquet in dolor malesuada quisque.",
      pageName: "Workshop Activities"),
];
