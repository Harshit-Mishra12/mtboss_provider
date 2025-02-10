import 'dart:developer';

import 'package:fixit_provider/screens/app_pages_screens/custom_job_request/job_request_details/layouts/bid_amount.dart';

import '../../../config.dart';

class JobRequestDetailsProvider with ChangeNotifier {
  int selectedIndex = 0, selected =-1;
  bool isBottom = true;
  int? serviceId;
  ScrollController scrollController = ScrollController();
  double widget1Opacity = 0.0;
  GlobalKey<FormState> withdrawKey = GlobalKey<FormState>();
  FocusNode amountFocus = FocusNode();
  JobRequestModel? service;
  List<ServiceFaqModel> serviceFaq = [];
  TextEditingController amountCtrl = TextEditingController();

  onImageChange(index) {
    selectedIndex = index;
    notifyListeners();
  }

  onReady(context)  async{
    scrollController.addListener(listen);

    notifyListeners();
    dynamic data = ModalRoute.of(context)!.settings.arguments;
    log("service :$data");
    if (data['serviceId'] != null) {
      getServiceById(context, data['serviceId']);
    } else {
      service = data['services'];
      notifyListeners();
      getServiceById(context, service!.id);

    }
    Future.delayed(const Duration(milliseconds: 500), () {
      widget1Opacity = 1;
      notifyListeners();
    });
    notifyListeners();
  }

  onRefresh(context) async {
    showLoading(context);
    notifyListeners();
    await getServiceById(context, service!.id);

    hideLoading(context);
    notifyListeners();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  onExpansionChange(newState, index) {
    log("dghfdkg:$newState");
    if (newState) {
      const Duration(seconds: 20000);
      selected = index;
      notifyListeners();
    } else {
      selected = -1;
      notifyListeners();
    }
  }

  void listen() {
    if (scrollController.position.pixels >= 200) {
      hide();
      notifyListeners();
    } else {
      show();
      notifyListeners();
    }
  }

  void show() {
    if (!isBottom) {
      isBottom = true;
      notifyListeners();
    }
    notifyListeners();
  }

  void hide() {
    if (isBottom) {
      isBottom = false;
      notifyListeners();
    }
    notifyListeners();
  }

  onBack(context, isBack) {
    service = null;
    serviceFaq = [];
    selectedIndex = 0;
    serviceId = 0;
    widget1Opacity = 0.0;
    notifyListeners();
    log("djhfkf :$service");
    if (isBack) {
      route.pop(context);
    }
  }

  getServiceById(context, serviceId) async {
    try {
      await apiServices
          .getApi("${api.serviceRequest}/$serviceId", [], isToken: true,isData: true).then((value) {
        if (value.isSuccess!) {
          log("value ;${value.data}");
          service = JobRequestModel.fromJson(value.data);
          notifyListeners();
        } else {
          notifyListeners();
        }
      });
    } catch (e) {
      log("ERRROEEE getServiceById : $e");
      notifyListeners();
    }
  }

  //on with bottom sheet open
  bidClick(context) {
    showModalBottomSheet(
      isScrollControlled: true,
      isDismissible: true,
      context: context,
      builder: (context1) {
        return const BidAmountSheet();
      },
    ).then((value) {
      log("SSSS");

    });
  }

  bidSend(context)async{
    try {
      showLoading(context);
      notifyListeners();

      var body = {"amount": amountCtrl.text, "service_request_id": service!.id};
      log("bidSend BODY : $body");
      await apiServices
          .postApi(api.bid, body, isToken: true)
          .then((value)async {
            log("VALUE :${value.message} || ${value.isSuccess}");
        hideLoading(context);

        notifyListeners();
        if (value.isSuccess!) {
          await getServiceById(context,service!.id);
          route.pop(context);

        } else {
          route.pop(context);
          route.pop(context);
          await getServiceById(context,service!.id);
          snackBarMessengers(context,
              color: appColor(context).appTheme.red, message: value.message);
        }
      });
    } catch (e) {
      hideLoading(context);
      notifyListeners();
      log("EEEE assignServiceman : $e");
    }
  }

acceptProvider(context,ProviderModel provider){
 /* showDialog(
      context: context,
      builder: (BuildContext context1) {
        return AcceptProviderConfirmation(provider: provider);
      });*/
}
}
