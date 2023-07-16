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
      title: "İlgi alanlarını kolayca takip edebiliyor musun?",
      description:
          "İstanbul'daki favori sanatçılarının favori etkinlikleri cebinde. Favori etkinliklerin yaklaştığında ActivitIST bildirimleriyle sana hatırlatacak. Favorindeki etkinlikler profilini parlatacak ve kategorileriyle yer alacak, belki de kendini tarif etmek için artık direkt ActivitIST profilini gösterirsin, ha ne dersin?",
      pageName: "Favori Etkinlikler"),
  OnboardModel(
      image: ImageConstants.ONBOARD2,
      title: "Yakınındaki etkinliklerden ne kadar haberdarsın?",
      description:
          "Artık haritada hangi etkinliğin, nerede olduğunu görüntüleyebilirsin. Dilediğin kadar bilgi ve içerik burada. Etkinlik detay sayfasında mekan ve etkinlik hakkında merak ettiğin her şeyi öğrenebilirsin. İstersen bilet almaya yönlendirilebilirsin. İyi eğlen!",
      pageName: "Etkinlik Haritası"),
  OnboardModel(
      image: ImageConstants.ONBOARD3,
      title: "Sosyal biri misin yoksa henüz o çevreyi bulamadın mı?",
      description: "ActivitIST'de sosyallik var, canlı etkinlik grupları var! Tanış, iletişim kur, haber al. Seninle aynı frekansta olan insanlarla bir araya gelmek bu kadar kolay.",
      pageName: "Etkinlik Grupları"),
];
