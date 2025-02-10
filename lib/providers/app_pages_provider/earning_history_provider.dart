import 'dart:developer';

import 'package:fixit_provider/config.dart';
import '../../widgets/date_time_picker.dart';
import '../../widgets/year_dialog.dart';

class EarningHistoryProvider with ChangeNotifier {
  String? countryValue ;

  DateTime? selectedDay;
  DateTime selectedYear = DateTime.now();
  final ValueNotifier<DateTime> focusedDay = ValueNotifier(DateTime.now());
  CalendarFormat calendarFormat = CalendarFormat.month;
  int demoInt = 0;
  PageController pageController = PageController();
  dynamic chosenValue;
  DateTime? rangeStart;
  DateTime? rangeEnd;
  DateTime currentDate = DateTime.now();
  RangeSelectionMode rangeSelectionMode = RangeSelectionMode
      .toggledOn;
  String showYear = 'Select Year';

  selectYear(context) async {
    showDialog(
        context: context,
        builder: (BuildContext context3) {
          return  YearAlertDialog(
              selectedDate: selectedYear,
              onChanged: (DateTime dateTime) {
                selectedYear = dateTime;
                showYear = "${dateTime.year}";
                focusedDay.value = DateTime.utc(
                    selectedYear.year,
                    chosenValue["index"],
                    focusedDay.value.day + 0);
                onDaySelected(
                    focusedDay.value,
                    focusedDay.value);
                notifyListeners();
                route.pop(context);
                log("YEAR CHANGE : ${ focusedDay.value}");
              }
          );
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

  onCalendarCreate(controller) {
    pageController = controller;
  }

  onRangeSelect(start, end, focusedDay) {
    selectedDay = null;
    currentDate = focusedDay;
    rangeStart = start;
    rangeEnd = end;
    rangeSelectionMode = RangeSelectionMode.toggledOn;
    notifyListeners();
  }

  onChangeCountry(val) {
    countryValue = val;
    notifyListeners();
  }

  onTapCalender(context){
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context3) {
          return const DateTimePicker();
        });
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
    if( focusedDay.value.month != DateTime.january || focusedDay.value.year != DateTime.now().year) {
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
    notifyListeners();
  }

}