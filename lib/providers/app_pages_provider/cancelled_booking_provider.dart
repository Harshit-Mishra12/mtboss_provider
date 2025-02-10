import 'dart:developer';

import 'package:fixit_provider/config.dart';

class CancelledBookingProvider with ChangeNotifier {

  BookingModel? bookingModel;
  String? id;

  onReady(context){

    dynamic data = ModalRoute.of(context)!.settings.arguments ?? "";
    id =data.toString();
    getBookingDetailById(context,id);
    log("id :$id");
    //  ongoingBookingModel = PendingBookingModel.fromJson( isServicemen ? appArray.ongoingBookingWithList : appArray.ongoingBookingList);
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
          .getApi("${api.booking}/$id", [],
          isToken: true, isData: true)
          .then((value) {
        if (value.isSuccess!) {
          debugPrint("BOOKING DATA : ${value.data}");
          bookingModel = BookingModel.fromJson(value.data);
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