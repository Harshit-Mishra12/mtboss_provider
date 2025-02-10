import 'dart:developer';

import 'package:fixit_provider/config.dart';

import '../../widgets/year_dialog.dart';

class BookingProvider with ChangeNotifier {
  TextEditingController searchCtrl = TextEditingController();
  FocusNode searchFocus = FocusNode();
  FocusNode categoriesFocus = FocusNode();

  String? month;
  List<BookingModel> bookingList = [];
  List freelancerBookingList = [];
  List selectedCategoryList = [];
  bool isExpand = false, isAssignMe = false, isSearchData = false;
  int selectIndex = 0;
  int? statusIndex;
  dynamic slotChosenValue;
  DateTime? slotSelectedDay;
  double widget1Opacity = 0.0;
  DateTime slotSelectedYear = DateTime.now();
  dynamic chosenValue;
  DateTime? selectedDay;
  DateTime selectedYear = DateTime.now();
  final ValueNotifier<DateTime> focusedDay = ValueNotifier(DateTime.now());
  CalendarFormat calendarFormat = CalendarFormat.month;
  int demoInt = 0;
  PageController pageController = PageController();
  TextEditingController categoryCtrl = TextEditingController();
  RangeSelectionMode rangeSelectionMode = RangeSelectionMode
      .toggledOn; // Can be toggled on/off by longpressing a date
  DateTime? rangeStart;
  DateTime? rangeEnd;
  DateTime currentDate = DateTime.now();
  String showYear = 'Select Year';
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  FocusNode reasonFocus = FocusNode();
  TextEditingController reasonCtrl = TextEditingController();

  onReady(context) {
    notifyListeners();
    onInit();
    notifyListeners();
  }

  clearTap(context, {isBack = true}) {
    statusIndex = null;
    selectedCategoryList = [];
    rangeEnd = null;
    rangeStart = null;
    selectIndex = 0;
    notifyListeners();

    if (isBack) {
      route.pop(context, arg: "clear");
    }
  }

  String totalCountFilter() {
    int count = 0;

    if (selectedCategoryList.isNotEmpty) {
      count++;
    }
    if (rangeStart != null || rangeEnd != null) {
      count++;
    }
    if (statusIndex != null) {
      count++;
    }

    return count.toString();
  }

  onRejectBooking(context, id) {
    showDialog(
        context: context,
        builder: (context1) => AppAlertDialogCommon(
            isField: true,
            validator: (value) => validation.commonValidation(context, value),
            focusNode: reasonFocus,
            controller: reasonCtrl,
            title: appFonts.reasonOfRejectBooking,
            singleText: appFonts.send,
            globalKey: formKey,
            singleTap: () {
              if (formKey.currentState!.validate()) {
                final bookingProvider =
                    Provider.of<PendingBookingProvider>(context, listen: false);

                bookingProvider.updateStatus(context, id,
                    isCancel: true, isBack: true);
              }
              notifyListeners();
            })).then((value) {
      reasonCtrl.text = "";
      notifyListeners();
    });
  }

  onAssignTap(context, BookingModel? bookingModel) {
    log("bookingModel!.requiredServicemen::${bookingModel!.requiredServicemen}");

    if (isFreelancer) {
      showDialog(
          context: context,
          builder: (context1) => AppAlertDialogCommon(
              height: Sizes.s145,
              title: appFonts.assignToMe,
              firstBText: appFonts.cancel,
              secondBText: appFonts.yes,
              image: eImageAssets.assignMe,
              subtext: appFonts.areYouSureYourself,
              secondBTap: () {
                assignServiceman(context, [userModel!.id], bookingModel.id);
              },
              firstBTap: () {
                // log("firstBTap  Booking Provider");
                route.pop(context);
              }));
    } else {
      if ((bookingModel.requiredServicemen ?? 1) > 1) {
        log("DDDD ");
        route.pushNamed(context, routeName.bookingServicemenList, arg: {
          "servicemen": bookingModel.requiredServicemen ?? 1,
          "data": bookingModel
        }).then((e) {
          log(" :$e");
          if (e != null) {
            List<ServicemanModel> serMan = e;
            List ids = [];
            for (var d in serMan) {
              ids.add(d.id);
            }
            log("SSS :$ids");

            assignServiceman(context, ids, bookingModel.id);
          }
        });
      } else {
        log("bookingModel!.requiredServicemen::${bookingModel.requiredServicemen}");
        showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context1) {
              return SelectServicemenSheet(
                  arguments: bookingModel.requiredServicemen ?? 1);
            });
      }
    }
  }

  //assign serviceman
  assignServiceman(context, List val, id) async {
    try {
      showLoading(context);
      notifyListeners();

      var body = {"booking_id": id, "servicemen_ids": val};
      log("ASSSIGN BODY : $body");
      await apiServices
          .postApi(api.assignBooking, body, isToken: true)
          .then((value) {
        hideLoading(context);

        notifyListeners();
        if (value.isSuccess!) {
          final common =
              Provider.of<UserDataApiProvider>(context, listen: false);
          common.getBookingHistory(context);
          if (selectIndex == 0) {
            route.pushNamed(context, routeName.assignBooking, arg: id);
          } else {
            route.pushNamed(context, routeName.assignBooking, arg: id);
          }
        } else {
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

  onAcceptBooking(context, id) async {
    final bookingProvider =
        Provider.of<PendingBookingProvider>(context, listen: false);
    showLoading(context);
    notifyListeners();
    await bookingProvider.updateStatus(context, id);
    hideLoading(context);
    notifyListeners();
  }

  onTapBookings(BookingModel data, context) {
    final dash = Provider.of<UserDataApiProvider>(context, listen: false);
    log("data.bookingStatus!.slug :${data.bookingStatus!.slug}");

    if (data.bookingStatus != null) {
      if (data.bookingStatus!.slug == appFonts.pending) {
        //route.pushNamed(context, routeName.packageBookingScreen);
        route
            .pushNamed(context, routeName.pendingBooking, arg: data.id)
            .then((e) {
          dash.getBookingHistory(context);
        });
      } else if (data.bookingStatus!.slug == appFonts.accepted) {
        if (isFreelancer) {
          route
              .pushNamed(context, routeName.assignBooking, arg: data.id)
              .then((e) {
            dash.getBookingHistory(context);
          });
        } else {
          route
              .pushNamed(context, routeName.acceptedBooking, arg: data.id)
              .then((e) {
            dash.getBookingHistory(context);
          });
        }
        /* {"amount": "0", "assign_me": data.providerId.toString() == userModel!.id.toString()? true: false}*/
      } else if (data.bookingStatus!.slug == appFonts.pendingApproval) {
        route
            .pushNamed(context, routeName.pendingApprovalBooking, arg: data.id)
            .then((e) {
          dash.getBookingHistory(context);
        });
      } else if (data.bookingStatus!.slug == appFonts.hold) {
        route.pushNamed(context, routeName.holdBooking, arg: data.id).then((e) {
          dash.getBookingHistory(context);
        });
      } else if (data.bookingStatus!.slug == appFonts.onHold) {
        route.pushNamed(context, routeName.holdBooking, arg: data.id).then((e) {
          dash.getBookingHistory(context);
        });
      } else if (data.bookingStatus!.slug == appFonts.onGoing.toLowerCase() ||
          data.bookingStatus!.slug == appFonts.ontheway ||
          data.bookingStatus!.slug == appFonts.startAgain) {
        route
            .pushNamed(context, routeName.ongoingBooking, arg: data.id)
            .then((e) {
          dash.getBookingHistory(context);
        });
      } else if (data.bookingStatus!.slug == appFonts.completed) {
        route
            .pushNamed(context, routeName.completedBooking, arg: data.id)
            .then((e) {
          dash.getBookingHistory(context);
        });
      } else if (data.bookingStatus!.slug == appFonts.assigned) {
        route
            .pushNamed(context, routeName.assignBooking, arg: data.id)
            .then((e) {
          dash.getBookingHistory(context);
        });
      } else if (data.bookingStatus!.slug == appFonts.cancel) {
        route
            .pushNamed(context, routeName.cancelledBooking, arg: data.id)
            .then((e) {
          dash.getBookingHistory(context);
        });
      }
    } else {
      route
          .pushNamed(context, routeName.pendingBooking, arg: data.id)
          .then((e) {
        dash.getBookingHistory(context);
      });
    }
  }

  /*onTapBookings(data,context){
    if(data.status == appFonts.pending) {
      //route.pushNamed(context, routeName.packageBookingScreen);
      if(data.servicemanLists.isNotEmpty) {
        route.pushNamed(context, routeName.pendingBooking,arg: true);
      } else {
        route.pushNamed(context, routeName.pendingBooking,arg: false);
      }
    } else if(data.status == appFonts.accepted) {
      if(isFreelancer) {
        route.pushNamed(context, routeName.assignBooking);
      } else {
        if(data.assignMe == "Yes") {
          route.pushNamed(context, routeName.acceptedBooking,arg: {"amount": "0","assign_me": true});
        } else {
          route.pushNamed(context, routeName.acceptedBooking,arg: {"amount": "0","assign_me": false});
        }

      }
    } else if(data.status == appFonts.pendingApproval) {
      route.pushNamed(context, routeName.pendingApprovalBooking);
    } else if(data.status == appFonts.ongoing) {
      if(data.servicemanLists.isNotEmpty) {
        route.pushNamed(context, routeName.ongoingBooking,arg: {
          "bool": false
        });
      } else {
        route.pushNamed(context, routeName.ongoingBooking,arg: {
          "bool": true
        });
      }
    } else if(data.status == appFonts.hold) {
      route.pushNamed(context, routeName.holdBooking);
    } else if(data.status == appFonts.completed) {
      route.pushNamed(context, routeName.completedBooking);
    } else if(data.status == appFonts.cancelled) {
      route.pushNamed(context, routeName.cancelledBooking);
    } else if(data.status == appFonts.assigned) {
      if(data.servicemanLists.isNotEmpty) {
        route.pushNamed(context, routeName.assignBooking,arg: {
          "bool": true
        });
      } else {
        route.pushNamed(context, routeName.assignBooking,arg: {
          "bool": false
        });
      }
    }
  }*/

  onTapSwitch(val, context) async {
    isAssignMe = val;
    showLoading(context);
    notifyListeners();
    notifyListeners();
    if (isAssignMe) {
      final userApi = Provider.of<UserDataApiProvider>(context, listen: false);

      await userApi.getBookingHistory(context);
      hideLoading(context);

      log("list :${bookingList.length}");
      bookingList = bookingList
          .where((element) =>
              element.servicemen != null &&
              (element.servicemen!
                  .where((e) => e.id.toString() == userModel!.id.toString())
                  .isNotEmpty))
          .toList();
      notifyListeners();
    } else {
      final userApi = Provider.of<UserDataApiProvider>(context, listen: false);

      await userApi.getBookingHistory(context);
    }
    hideLoading(context);
    notifyListeners();
  }

  onTapMonth(val) {
    month = val;
    notifyListeners();
  }

  onRangeSelect(start, end, focusedDay) {
    selectedDay = null;
    currentDate = focusedDay;
    rangeStart = start;
    rangeEnd = end;
    rangeSelectionMode = RangeSelectionMode.toggledOn;
    notifyListeners();
  }

  selectYear(context) async {
    showDialog(
        context: context,
        builder: (BuildContext context3) {
          return YearAlertDialog(
              selectedDate: selectedYear,
              onChanged: (DateTime dateTime) {
                selectedYear = dateTime;
                showYear = "${dateTime.year}";
                focusedDay.value = DateTime.utc(selectedYear.year,
                    chosenValue["index"], focusedDay.value.day + 0);
                onDaySelected(focusedDay.value, focusedDay.value);
                notifyListeners();
                route.pop(context);
              });
        });
  }

  onDropDownChange(choseVal) {
    notifyListeners();
    chosenValue = choseVal;

    notifyListeners();
    int index = choseVal['index'];
    focusedDay.value =
        DateTime.utc(focusedDay.value.year, index, focusedDay.value.day + 0);
    onDaySelected(focusedDay.value, focusedDay.value);
  }

  onRightArrow() {
    pageController.nextPage(
        duration: const Duration(microseconds: 200), curve: Curves.bounceIn);
    final newMonth = focusedDay.value.add(const Duration(days: 30));
    focusedDay.value = newMonth;
    int index = appArray.monthList
        .indexWhere((element) => element['index'] == focusedDay.value.month);
    chosenValue = appArray.monthList[index];
    selectedYear = DateTime.utc(focusedDay.value.year, focusedDay.value.month,
        focusedDay.value.day + 0);
    notifyListeners();
  }

  onLeftArrow() {
    if (focusedDay.value.month != DateTime.january ||
        focusedDay.value.year != DateTime.now().year) {
      pageController.previousPage(
          duration: const Duration(microseconds: 200), curve: Curves.bounceIn);
      final newMonth = focusedDay.value.subtract(const Duration(days: 30));
      focusedDay.value = newMonth;
      int index = appArray.monthList
          .indexWhere((element) => element['index'] == focusedDay.value.month);
      chosenValue = appArray.monthList[index];
      selectedYear = DateTime.utc(focusedDay.value.year, focusedDay.value.month,
          focusedDay.value.day + 0);
    }
    notifyListeners();
  }

  void onDaySelected(DateTime selectDay, DateTime fDay) {
    notifyListeners();
    focusedDay.value = selectDay;
  }

  onPageCtrl(dayFocused) {
    focusedDay.value = dayFocused;
    demoInt = dayFocused.year;
    notifyListeners();
  }

  onInit() {
    focusedDay.value = DateTime.utc(focusedDay.value.year,
        focusedDay.value.month, focusedDay.value.day + 0);
    onDaySelected(focusedDay.value, focusedDay.value);
    DateTime dateTime = DateTime.now();
    int index = appArray.monthList
        .indexWhere((element) => element['index'] == dateTime.month);
    chosenValue = appArray.monthList[index];
    Future.delayed(const Duration(milliseconds: 500), () {
      widget1Opacity = 1;
      notifyListeners();
    });
    notifyListeners();
  }

  onCalendarCreate(controller) {
    pageController = controller;
  }

  onCategoryChange(context, id) {
    if (!selectedCategoryList.contains(id)) {
      selectedCategoryList.add(id);
    } else {
      selectedCategoryList.remove(id);
    }

    notifyListeners();
  }

  onStatus(index) {
    statusIndex = index;
    notifyListeners();
  }

  onFilter(index) {
    selectIndex = index;
    notifyListeners();
  }

  onExpand(data) {
    data.isExpand = !data.isExpand;
    notifyListeners();
  }

  onTapFilter(context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return const BookingFilterLayout();
      },
    );
  }
}
