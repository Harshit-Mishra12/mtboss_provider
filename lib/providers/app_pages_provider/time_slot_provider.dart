import 'dart:developer';

import 'package:fixit_provider/config.dart';

class TimeSlotProvider with ChangeNotifier {
  TextEditingController hourGap = TextEditingController();
  FocusNode hourGapFocus = FocusNode();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  CarouselSliderController hourCtrl = CarouselSliderController();
  CarouselSliderController mnCtrl = CarouselSliderController();
  CarouselSliderController amPmCtrl = CarouselSliderController();
  int scrollDayIndex = 0;
  int scrollMinIndex = 0;
  int scrollHourIndex = 0;

  TimeSlotModel? timeSlot;
  int indexs = 0;
  FixedExtentScrollController? controller1, controller2, controller3;

  String? gapValue;

  //timeslot availability status change
  onToggle(index, val) {
    appArray.timeSlotList[index].status = val == true ? "1" : "0";
    notifyListeners();
  }

  //duration unit selection
  durationUnitSelection(val) {
    gapValue = val;
    notifyListeners();
  }

  //am and pm selection
  onDayScroll(index) {
    scrollDayIndex = index;
    notifyListeners();
  }

// time selection bottom sheet
  selectTimeBottomSheet(context, TimeSlots val, index, type) {
    scrollHourIndex = val.startTime == null
        ? 0
        : type == "start"
            ? int.parse(val.startTime!.split(":")[0])
            : int.parse(val.endTime!.split(":")[0]);
    scrollMinIndex = val.startTime == null
        ? 0
        : type == "start"
            ? int.parse(val.startTime!.split(":")[1].toString().split(" ")[0])
            : int.parse(val.endTime!.split(":")[1].toString().split(" ")[0]);
    scrollDayIndex = val.startTime == null
        ? 0
        : ((val.startTime!.toString().contains("AM") ||
                    val.startTime!.toString().contains("PM")) &&
                (val.endTime!.toString().contains("AM") ||
                    val.endTime!.toString().contains("PM")))
            ? type == "start"
                ? (val.startTime!.split(" ")[1] == "AM" ? 0 : 1)
                : val.endTime!.split(" ")[1] == "AM"
                    ? 0
                    : 1
            : 0;
    controller1 = FixedExtentScrollController();
    controller2 = FixedExtentScrollController();
    controller3 = FixedExtentScrollController();

    notifyListeners();
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context2) {
          return StatefulBuilder(builder: (context, setState) {
            return SelectTimeSheet(
                onTap: () => onAddTime(val, index, context, type), type: type);
          });
        });
  }

  //page init data fetch and set in keys
  fetchData() {
    if (controller1 != null && controller1!.hasClients) {
      controller1!.animateToItem(scrollHourIndex,
          duration: const Duration(milliseconds: 50), curve: Curves.linear);
    }

    if (controller2 != null && controller2!.hasClients) {
      controller2!.animateToItem(scrollMinIndex,
          duration: const Duration(milliseconds: 50), curve: Curves.linear);
    }

    if (controller3 != null && controller3!.hasClients) {
      controller3!.animateToItem(scrollDayIndex,
          duration: const Duration(milliseconds: 50), curve: Curves.linear);
    }

    notifyListeners();
  }

  //select time in array
  onAddTime(val, index, context, type) {
    int hr = scrollHourIndex;
    int mn = scrollMinIndex;
    String amPm = scrollDayIndex == 0 ? "AM" : "PM";

    if (type == "start") {
      appArray.timeSlotList[index].startTime =
          "${hr.toString()}:${mn < 10 ? '0$mn' : mn.toString()} $amPm";
    } else {
      appArray.timeSlotList[index].endTime =
          "${hr.toString()}:${mn < 10 ? '0$mn' : mn.toString()} $amPm";
    }

    notifyListeners();
    route.pop(context);
  }

  // hour selection
  onHourChange(index) {
    scrollHourIndex = index;
    notifyListeners();
  }

  // minute selection
  onMinChange(index) {
    scrollMinIndex = index;
    notifyListeners();
  }

  //AM or PM selection
  onAmPmChange(index) {
    scrollDayIndex = index;
    notifyListeners();
  }

  //fetch time slot from api
  onUpdateHour(context) {
    if (formKey.currentState!.validate()) {
      if (gapValue != null) {
        timeSlotAddApi(context);
      } else {
        snackBarMessengers(context,
            message: language(context, appFonts.pleaseSelectDurationUnit));
      }
    }
  }

  //fetch time slot api
  fetchSlotTime(context) async {
    showLoading(context);
    notifyListeners();
    try {
      await apiServices
          .getApi("${api.providerTimeSlot}/${userModel!.id}", [],
              isData: true, isToken: true)
          .then((value) async {
        if (value.isSuccess!) {
          if (value.data == 0) {
            log("value.data::${value.data}");
            gapValue = "Hours";
            hourGap.text = "";
            appArray.timeSlotList = appArray.newTimeSlotList;
          } else {
            log("value.data::${value.data}");
            timeSlot = TimeSlotModel.fromJson(value.data);
            appArray.timeSlotList.asMap().entries.forEach((e) {
              int index = timeSlot!.timeSlots!.indexWhere((element) =>
                  element.day!.toLowerCase() == e.value.day!.toLowerCase());
              if (index >= 0) {
                appArray.timeSlotList[e.key].status =
                    timeSlot!.timeSlots![index].status;
                appArray.timeSlotList[e.key].startTime =
                    timeSlot!.timeSlots![index].startTime;
                appArray.timeSlotList[e.key].endTime =
                    timeSlot!.timeSlots![index].endTime;
              } else {
                appArray.timeSlotList[e.key].status = "0";
              }
            });

            gapValue = timeSlot!.timeUnit! == "hours" ? "Hours" : "Minutes";
            hourGap.text = timeSlot!.gap!;
          }
        } else {
          gapValue = "Hours";
          hourGap.text = "";
          appArray.timeSlotList = appArray.newTimeSlotList;
        }
        hideLoading(context);
        notifyListeners();
      });
    } catch (e) {
      appArray.timeSlotList = appArray.newTimeSlotList;
      hideLoading(context);
      notifyListeners();
    }
  }

  //time slot add
  timeSlotAddApi(context) async {
    try {
      showLoading(context);
      notifyListeners();

      List timeSlotList = [];
      for (var d in appArray.timeSlotList) {
        timeSlotList.add(d.toJson());
        notifyListeners();
      }

      var body = {
        "time_slots": timeSlotList,
        "gap": hourGap.text,
        "time_unit": gapValue!.toLowerCase()
      };

      log("HHHH :$body");
      if (timeSlot != null && timeSlot!.id != null) {
        await apiServices
            .putApi(api.updateProviderTimeSlot, body, isToken: true)
            .then((value) async {
          hideLoading(context);
          notifyListeners();

          if (value.isSuccess!) {
            /* showDialog(
                context: context,
                builder: (context) => AlertDialogCommon(
                    title: appFonts.updateSuccessfully,
                    height: Sizes.s140,
                    image: eGifAssets.successGif,
                    subtext: language(context, appFonts.hurrayUpdateHour),
                    bText1: language(context, appFonts.okay),
                    b1OnTap: () => route.pop(context)));*/
            snackBarMessengers(context,
                message: value.message,
                color: appColor(context).appTheme.primary);
            notifyListeners();
          } else {}
        });
      } else {
        await apiServices
            .postApi(api.providerTimeSlot, body, isToken: true)
            .then((value) async {
          hideLoading(context);
          notifyListeners();

          if (value.isSuccess!) {
            /*showDialog(
                context: context,
                builder: (context) => AlertDialogCommon(
                    title: appFonts.updateSuccessfully,
                    height: Sizes.s140,
                    image: eGifAssets.successGif,
                    subtext: language(context, appFonts.hurrayUpdateHour),
                    bText1: language(context, appFonts.okay),
                    b1OnTap: () => route.pop(context)));
*/
            snackBarMessengers(context,
                message: value.message,
                color: appColor(context).appTheme.primary);
            notifyListeners();
          } else {}
        });
      }
    } catch (e) {
      log("Time slot::$e");
      hideLoading(context);
      notifyListeners();
    }
  }
}
