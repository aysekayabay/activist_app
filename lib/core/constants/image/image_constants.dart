class ImageConstants {
  ImageConstants._();
  static late final ImageConstants instance = ImageConstants._();

  static final String AUTH_IMAGE = imageToPng("auth_image");
  static final String GOOGLE = iconToPng("google");
  static final String TWITTER = iconToPng("twitter");
  static final String FACEBOOK = iconToPng("facebook");
  static final String LOGO_GREY = iconToPng("logo_grey");
  static final String BACK = iconToPng("back");
  static final String NEXT = iconToPng("next");
  static final String NOTIFICATION = iconToPng("notification");
}

String iconToPng(String name) => 'assets/icons/$name.png';
String imageToPng(String name) => 'assets/images/$name.png';
