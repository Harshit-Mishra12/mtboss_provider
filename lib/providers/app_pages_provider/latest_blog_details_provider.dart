import '../../config.dart';
class LatestBLogDetailsProvider with ChangeNotifier {
  BlogModel? data;

  onReady(context) {
   dynamic arg = ModalRoute.of(context)!.settings.arguments;
   data =arg;
    notifyListeners();
  }
}
