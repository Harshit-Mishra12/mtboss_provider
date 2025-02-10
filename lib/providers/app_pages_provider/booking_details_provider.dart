import 'package:fixit_provider/config.dart';

class BookingDetailsProvider with ChangeNotifier {
  Histories? commission;
  BookingModel? bookingModel;

  onReady(context) {
    dynamic data = ModalRoute.of(context)!.settings.arguments ?? "";
    notifyListeners();
    commission = data;
    showLoading(context);
    notifyListeners();
    getBookingDetailById(context, commission!.bookingId);
  }

  //booking detail by id
  getBookingDetailById(context, id) async {
    try {
      await apiServices
          .getApi("${api.booking}/$id", [], isToken: true, isData: true)
          .then((value) {
        if (value.isSuccess!) {
          hideLoading(context);

          notifyListeners();
          bookingModel = BookingModel.fromJson(value.data);
          notifyListeners();
        } else {
          hideLoading(context);

          notifyListeners();
        }
      });
    } catch (e) {
      hideLoading(context);
      notifyListeners();
    }
  }

  onTapPhone(phone, context) {
    if (phone != null) {
      launchCall(context, phone);
      notifyListeners();
    }
  }
}
