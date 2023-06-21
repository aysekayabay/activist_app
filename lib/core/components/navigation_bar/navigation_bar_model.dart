import '../../constants/image/image_constants.dart';

class NavigationBarModel {
  final String title;
  final String imagePath;

  NavigationBarModel(this.title, this.imagePath);
}

List<NavigationBarModel> bottomNavs = [
  NavigationBarModel("Home", ImageConstants.HOME),
  NavigationBarModel("Map", ImageConstants.MAP),
  NavigationBarModel("Ticket", ImageConstants.TICKET),
];
