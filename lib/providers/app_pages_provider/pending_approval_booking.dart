import 'package:fixit_provider/config.dart';

class PendingApprovalBookingProvider with ChangeNotifier {

  BookingModel? bookingModel;
  List statusList = [];
  String amount = "0",id="";

  TextEditingController reasonCtrl = TextEditingController();
  onReady(context){
    dynamic data = ModalRoute.of(context)!.settings.arguments ?? "";
    id =data.toString();
    //pendingApprovalBookingModel = PendingBookingModel.fromJso
    notifyListeners();
    getBookingDetailById(context);
  }


//booking detail by id
  getBookingDetailById(context) async {
    try {
      await apiServices
          .getApi("${api.booking}/$id", [],
          isToken: true, isData: true)
          .then((value) {
        if (value.isSuccess!) {
          hideLoading(context);

          notifyListeners();
          debugPrint("BOOKING DATA : ${value.data}");
          bookingModel = BookingModel.fromJson(value.data);
          notifyListeners();
        }else{
          hideLoading(context);

          notifyListeners();
        }
      });
      hideLoading(context);

      notifyListeners();
    } catch (e) {
      hideLoading(context);
      notifyListeners();
    }
  }
}