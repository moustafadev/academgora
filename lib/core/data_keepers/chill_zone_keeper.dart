import 'package:academ_gora_release/core/api/firebase_requests_controller.dart';
import 'package:academ_gora_release/features/main_screen/main_screen/domain/enteties/chill_zone.dart';


class ChillZoneKeeper {
  static final ChillZoneKeeper _cancelKeeper = ChillZoneKeeper._();

  ChillZoneKeeper._();

  factory ChillZoneKeeper() {
    return _cancelKeeper;
  }

  RestZone? restZone;
  List<RestText> listZone = [];
  List<String> zoneUrl = [];
  List<dynamic> zone = [];
  final FirebaseRequestsController _firebaseRequestsController =
      FirebaseRequestsController();

  void updateInstructors(Map instructors) {
    listZone = [];
    zone = [];
    restZone = RestZone.fromJson(instructors);
    restZone?.rest_text?.forEach((key, value) {
      listZone.add(RestText.fromJson(key, value));
    });
    restZone?.photo?.forEach((element) {
      zone.add(element);
    });
    updateNewsUrls();
  }

  void updateNewsUrls() async {
    zoneUrl = [];
    zone.forEach((element)async{
      if (element != null)
        {
          final String url = await saveImageUrl(imageName: element['Фото'].toString());
          zoneUrl.add(url);
        }
    });
  }

  Future<String> saveImageUrl({required String imageName}) async {
    String url = "";
    if (imageName == "") {
      return url;
    }
    await _firebaseRequestsController
        .getDownloadUrlFromFirebaseStorage("rest_zone/$imageName")
        .then(
      (downloadUrl) {
        url = downloadUrl.toString();
      },
    );
    return url;
  }
}
