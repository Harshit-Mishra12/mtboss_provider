import 'package:fixit_provider/config.dart';

class HoldBookingProvider with ChangeNotifier {

  String amount = "0",id="id";

  BookingModel? bookingModel;

  TextEditingController reasonCtrl = TextEditingController();
  onReady(context){
    dynamic data = ModalRoute.of(context)!.settings.arguments;
    id = data.toString();

    notifyListeners();
    getBookingDetailById(context, id);
  //  holdBookingModel = PendingBookingModel.fromJson(appArray.holdBookingList);
    notifyListeners();
  }

  onRefresh(context)async{
    showLoading(context);
    notifyListeners();
    await getBookingDetailById(context,bookingModel!.id);
    hideLoading(context);
    notifyListeners();
  }

  onBack(context,isBack){

    bookingModel =null;
    notifyListeners();
    if(isBack){
      route.pop(context);
    }
  }

//booking detail by id
  getBookingDetailById(context,id) async {
    try {
      await apiServices
          .getApi("${api.booking}/${id ??bookingModel!.id}", [],
          isToken: true, isData: true)
          .then((value) {
        if (value.isSuccess!) {
          debugPrint("BOOKING DATA : ${value.data}");
          bookingModel = BookingModel.fromJson(value.data);
          notifyListeners();
        }
      });

      notifyListeners();
    } catch (e) {
      notifyListeners();
    }
  }


}