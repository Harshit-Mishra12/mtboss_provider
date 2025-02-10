import 'dart:developer';

import 'package:fixit_provider/config.dart';

class PlanDetailsProvider with ChangeNotifier {
  bool isMonthly = true, isTrial = false;
  CarouselSliderController carouselController = CarouselSliderController();
  List<SubscriptionModel> planList = [];
  int selIndex = 0;

  onPageChange(index, reason) {
    selIndex = index;
    notifyListeners();
  }

  onReady(context) async {
    dynamic arg = ModalRoute.of(context)!.settings.arguments;
    if (arg != null && arg['isTrial'] != null && arg['isTrial'] == true) {
      isTrial = true;
    } else {
      isTrial = arg ?? false;
    }
    log("isMonthly:$isMonthly");
    log("isMonthly:${subscriptionList.length}");
    if (subscriptionList.isNotEmpty) {
      planList = subscriptionList.where((element) {
        log("DURA :${element.duration}");
        return element.duration == (isMonthly ? "monthly" : "yearly");
      }).toList();
      notifyListeners();
    } else {
      showLoading(context);
      notifyListeners();
      final commonApi = Provider.of<CommonApiProvider>(context, listen: false);

      await commonApi.getSubscriptionPlanList(context);
      planList = [];
      await Future.delayed(Durations.short4);
      planList = subscriptionList
          .where((element) =>
              element.duration == (!isMonthly ? "monthly" : "yearly"))
          .toList();
      hideLoading(context);
      notifyListeners();
    }

    log("planList L${planList.length}");
    if (userModel!.activeSubscription != null) {
      int index = subscriptionList.indexWhere((element) =>
          element.id.toString() ==
          userModel!.activeSubscription!.userPlanId.toString());

      if (index >= 0) {
        if (subscriptionList[index].duration == "monthly") {
          isMonthly = false;
        } else {
          isMonthly = true;
        }
        planList = subscriptionList
            .where((element) =>
                element.duration == (!isMonthly ? "monthly" : "yearly"))
            .toList();
        selIndex = index;
      }
    } else {
      selIndex = 0;
    }
    log("SELECTED  :$selIndex");
    notifyListeners();
    carouselController.jumpToPage(selIndex);
    notifyListeners();
  }

  onToggle(val) {
    isMonthly = val;
    planList = subscriptionList
        .where((element) =>
            element.duration == (!isMonthly ? "monthly" : "yearly"))
        .toList();
    log("planList :${planList.length}");
    notifyListeners();
  }

  selectPlan(plan, context) async {
    userSubscribe = plan;

    notifyListeners();
    route.pushNamed(context, routeName.paymentMethodList, arg: isTrial);
  }
}
