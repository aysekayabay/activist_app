class ImageConstants {
  ImageConstants._();
  static late final ImageConstants instance = ImageConstants._();

  static final String AUTH_IMAGE = imageToPng("auth_image");
  static final String GOOGLE = iconToPng("google");
  static final String TWITTER = iconToPng("twitter");
  static final String FACEBOOK = iconToPng("facebook");
}

String iconToPng(String name) => 'assets/icons/$name.png';
String imageToPng(String name) => 'assets/images/$name.png';
