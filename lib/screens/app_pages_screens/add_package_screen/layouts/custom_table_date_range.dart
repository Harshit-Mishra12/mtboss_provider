import 'package:intl/intl.dart';

import '../../../../config.dart';

class CustomTableDateRange extends StatelessWidget {
  const CustomTableDateRange({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AddPackageProvider>(builder: (context1, value, child) {
      return TableCalendar(
              rowHeight: 40,
              headerVisible: false,
              daysOfWeekVisible: true,
              pageJumpingEnabled: true,
              pageAnimationEnabled: false,
              rangeSelectionMode: RangeSelectionMode.toggledOn,
              lastDay: DateTime.utc(DateTime.now().year + 100, 3, 14),
              firstDay: DateTime.utc(
                  DateTime.now().year, DateTime.january, DateTime.now().day),
              onDaySelected: value.onDaySelected,
              focusedDay: value.focusedDay.value,
              rangeStartDay: value.rangeStart,
              rangeEndDay: value.rangeEnd,
              availableGestures: AvailableGestures.none,
              calendarFormat: value.calendarFormat,
              startingDayOfWeek: StartingDayOfWeek.monday,
              onRangeSelected: (start, end, focusedDay) =>
                  value.onRangeSelect(start, end, focusedDay),
              headerStyle: const HeaderStyle(
                  leftChevronVisible: false,
                  formatButtonVisible: false,
                  rightChevronVisible: false),
              onPageChanged: (dayFocused) => value.onPageCtrl(dayFocused),
              onCalendarCreated: (controller) =>
                  value.onCalendarCreate(controller),
              selectedDayPredicate: (day) {
                return isSameDay(value.focusedDay.value, day);
              },
              daysOfWeekStyle: DaysOfWeekStyle(
                  dowTextFormatter: (date, locale) =>
                      DateFormat.E(locale).format(date)[0],
                  weekdayStyle: appCss.dmDenseBold14
                      .textColor(appColor(context).appTheme.primary),
                  weekendStyle: appCss.dmDenseBold14
                      .textColor(appColor(context).appTheme.primary)),
              calendarStyle: CalendarStyle(
                  rangeHighlightColor:
                      appColor(context).appTheme.primary.withOpacity(0.10),
                  rangeEndDecoration: BoxDecoration(
                      color: appColor(context).appTheme.primary,
                      shape: BoxShape.circle),
                  defaultTextStyle: appCss.dmDenseLight14
                      .textColor(appColor(context).appTheme.darkText),
                  withinRangeTextStyle: appCss.dmDenseLight14
                      .textColor(appColor(context).appTheme.primary),
                  rangeStartTextStyle: appCss.dmDenseLight14
                      .textColor(appColor(context).appTheme.whiteColor),
                  rangeEndTextStyle: appCss.dmDenseLight14.textColor(appColor(context).appTheme.whiteColor),
                  rangeStartDecoration: BoxDecoration(color: appColor(context).appTheme.primary, shape: BoxShape.circle),
                  todayTextStyle: appCss.dmDenseMedium14.textColor(appColor(context).appTheme.primary),
                  todayDecoration: BoxDecoration(color: appColor(context).appTheme.primary.withOpacity(.10), shape: BoxShape.circle)))
          .paddingAll(Insets.i20)
          .boxShapeExtension(color: appColor(context).appTheme.fieldCardBg)
          .paddingSymmetric(horizontal: Insets.i20);
    });
  }
}
