import '../../config.dart';

class ServiceReviewProvider with ChangeNotifier {
  String exValue = appArray.reviewLowHighList[0]["id"];
  String? settingExValue;
  bool isSetting = false;
  Services? services;
  List<Reviews> reviewList = [];

  // on back data set again
  onBack(context, isBack) {
    isSetting = false;
    notifyListeners();
    if (isBack) {
      route.pop(context);
    }
  }

  //service review filter option select
  onReview(val) {
    exValue = val;
    notifyListeners();
    getReviewByServiceId(services!.id);
  }

  //provider review filter option select
  onSettingReview(val) {
    settingExValue = val;
    notifyListeners();
  }

  onTap(context,Reviews review){
    if(review.service != null){
    route.pushNamed(
        context, routeName.serviceDetails,
        arg: {"detail": review.serviceId});
    }else if(review.serviceman != null){
      route.pushNamed(
          context, routeName.servicemanDetail,
          arg: {"detail": review.servicemanId});
    }
  }

  //on page init data fetch
  onReady(context) {
    dynamic data = ModalRoute.of(context)!.settings.arguments;
    if (data != null) {
      isSetting = data['isSetting'] ?? false;
      if (data['service'] != null) {
        services = data['service'];
        getReviewByServiceId(services!.id);
      } else {
        getMyReview(context);
      }
    } else {
      getMyReview(context);
    }
    notifyListeners();
  }

  //get review by service id
  getReviewByServiceId(serviceId) async {
    reviewList = [];
    try {
      await apiServices
          .getApi(
              "${api.review}?serviceId=$serviceId&field=rating&sort=${exValue == "0" ? "asc" : "desc"}",
              [],
              isToken: true)
          .then((value) {
        if (value.isSuccess!) {
          for (var data in value.data) {
            if (!reviewList.contains(Reviews.fromJson(data))) {
              reviewList.add(Reviews.fromJson(data));
            }
            notifyListeners();
          }
          notifyListeners();
        }
      });
    } catch (e) {
      notifyListeners();
    }
  }

  //get review by user
  getMyReview(context) async {
    try {
      showLoading(context);
      notifyListeners();
      await apiServices.getApi(api.review, [], isToken: true).then((value) {
        hideLoading(context);
        notifyListeners();
        if (value.isSuccess!) {
          List list = value.data;
          if (list.isNotEmpty) {
            reviewList = [];
          }
          for (var data in value.data) {
            if (!reviewList.contains(Reviews.fromJson(data))) {
              reviewList.add(Reviews.fromJson(data));
            }
            notifyListeners();
          }
        }
      });
    } catch (e) {
      hideLoading(context);
      notifyListeners();

      notifyListeners();
    }
  }
}
