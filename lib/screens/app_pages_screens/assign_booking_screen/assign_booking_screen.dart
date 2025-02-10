import '../../../config.dart';
import '../../bottom_screens/booking_screen/booking_shimmer/booking_detail_shimmer.dart';

class AssignBookingScreen extends StatelessWidget {
  const AssignBookingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AssignBookingProvider>(builder: (context1, value, child) {
      return PopScope(
        canPop: true,
        onPopInvoked: (didPop) {
          value.onBack(context, false);
          if (didPop) return;
        },
        child: StatefulWrapper(
            onInit: () => Future.delayed(
                const Duration(milliseconds: 50), () => value.onReady(context)),
            child: LoadingComponent(
                child: value.bookingModel == null
                    ? const BookingDetailShimmer()
                    : Scaffold(
                        appBar: AppBarCommon(
                            onTap: () => value.onBack(context, true),
                            title: isFreelancer
                                ? appFonts.acceptedBooking
                                : appFonts.assignBooking),
                        body: RefreshIndicator(
                            onRefresh: () async {
                              value.onRefresh(context);
                            },
                            child: const AssignBookingBodyWidget())))),
      );
    });
  }
}
