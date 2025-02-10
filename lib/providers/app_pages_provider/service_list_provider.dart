import 'dart:developer';

import 'package:dio/dio.dart' as dio;
import 'package:fixit_provider/config.dart';

class ServiceListProvider with ChangeNotifier {
  List<CategoryModel> newCategoryList = [];
  int selectedIndex = 0;
  double widget1Opacity = 0.0;
  int tabIndex = 0;
  List<Services> serviceList = [];
  List<Widget> serviceWidgetList = [];
  bool isLoading = false;

  // service list as per sub category tab change
  onTapTab(context, val, sync) {
    tabIndex = val;
    notifyListeners();

    getServiceByCategoryId(
        context, categoryList[selectedIndex].hasSubCategories![tabIndex].id);
  }

  // on page init data fetch
  onReady(context, sync) async {
    notifyListeners();
    log("SELECT :$selectedIndex");
    dynamic data = ModalRoute.of(context)!.settings.arguments;
    if (data != null) {
      if (categoryList.isNotEmpty) {
        selectedIndex =
            categoryList.indexWhere((element) => element.id == data);
      } else {
        selectedIndex = 0;
      }
    } else {
      selectedIndex = 0;
    }
    log("categoryList :${categoryList.length}");
    notifyListeners();
    if (categoryList.isNotEmpty) {
      await getServiceByCategoryId(
          context,
          categoryList[selectedIndex].hasSubCategories != null &&
                  categoryList[selectedIndex].hasSubCategories!.isNotEmpty
              ? categoryList[selectedIndex].hasSubCategories![0].id
              : categoryList[selectedIndex].id);
    }
    Future.delayed(const Duration(milliseconds: 200), () {
      widget1Opacity = 1;
      notifyListeners();
    });
  }

  //update active status of service
  updateActiveStatusService(context, id, val, index) async {
    showLoading(context);

    serviceList[index].status = val == true ? 1 : 0;
    notifyListeners();
    log("SS ;${serviceList[index].status} // $id");
    var body = {"status": val == true ? "1" : 0, "_method": "PUT"};
    dio.FormData formData = dio.FormData.fromMap(body);
    try {
      await apiServices
          .postApi("${api.service}/$id", formData, isToken: true)
          .then((value) {
        hideLoading(context);

        notifyListeners();
        log("dsjf :${value.message}");
        if (value.isSuccess!) {
          final common =
              Provider.of<UserDataApiProvider>(context, listen: false);
          common.getPopularServiceList();
          getServiceByCategoryId(
              context,
              categoryList[selectedIndex].hasSubCategories != null &&
                      categoryList[selectedIndex].hasSubCategories!.isNotEmpty
                  ? categoryList[selectedIndex].hasSubCategories![0].id
                  : categoryList[selectedIndex].id);
        } else {
          snackBarMessengers(context,
              color: appColor(context).appTheme.red, message: value.message);
        }
      });
    } catch (e) {
      hideLoading(context);
      notifyListeners();
    }
  }

  //service list as per category
  onCategories(context, index, sync) async {
    showLoading(context);
    notifyListeners();
    selectedIndex = index;
    notifyListeners();

    serviceList = [];
    if (categoryList.isNotEmpty) {
      log("categoryList[selectedIndex].hasSubCategories :${categoryList[selectedIndex].hasSubCategories}");
      if (categoryList[selectedIndex].hasSubCategories != null &&
          categoryList[selectedIndex].hasSubCategories!.isNotEmpty) {
        await getServiceByCategoryId(
            context, categoryList[selectedIndex].hasSubCategories![0].id);
      } else {
        await getServiceByCategoryId(context, categoryList[selectedIndex].id);
      }
    }

    hideLoading(context);
    notifyListeners();
  }

  onBack(context, isBack) {
    selectedIndex = 0;
    tabIndex = 0;

    serviceList = [];
    widget1Opacity = 0.0;
    notifyListeners();
    if (isBack) {
      route.pop(context);
    }
  }

  //get service by category or sub category wise
  getServiceByCategoryId(context, id) async {
    notifyListeners();

    try {
      String apiUrl = "";

      apiUrl = "${api.providerServices}?category_id=$id";
      log("apiUrlapiUrlapiUrl::$apiUrl");
      await apiServices.getApi(apiUrl, [], isToken: true).then((value) {
        if (value.isSuccess!) {
          serviceList = [];
          notifyListeners();
          List dataList = value.data;
          if (dataList.isNotEmpty) {
            for (var data in value.data) {
              Services services = Services.fromJson(data);
              log("CHECK :${services.id} // ${services.status}");
              if (!serviceList.contains(services)) {
                serviceList.add(services);
              }
            }

            notifyListeners();
          } else {
            notifyListeners();
          }
        } else {
          notifyListeners();
        }

        notifyListeners();
      });
      log("serviceList:${serviceList.length}");
    } catch (e) {
      notifyListeners();
    }
  }
}
