import 'package:fixit_provider/screens/app_pages_screens/custom_job_request/job_request_list/layouts/job_request_list_card.dart';

import '../../../../config.dart';

class AllCategoriesLayout extends StatelessWidget {
  const AllCategoriesLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer4<HomeProvider, DashboardProvider, UserDataApiProvider,
            BookingProvider>(
        builder: (context, value, dashCtrl, userApi, booking, child) {
      return Column(
        children: [
          if (servicemanList.isNotEmpty)
            if (isFreelancer != true)
              HeadingRowCommon(
                      isViewAllShow: servicemanList.length >= 4,
                      title: appFonts.availableServiceman,
                      onTap: () =>
                          route.pushNamed(context, routeName.servicemanList))
                  .padding(
                      horizontal: Insets.i20,
                      top: Insets.i25,
                      bottom: Insets.i15),
          if (servicemanList.isNotEmpty)
            if (isFreelancer != true)
              GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: servicemanList.length >= 4
                          ? servicemanList.getRange(0, 4).length
                          : servicemanList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisExtent: 228,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 15),
                      itemBuilder: (context, index) {
                        return AvailableServiceLayout(
                            onTap: () => route.pushNamed(
                                    context, routeName.servicemanDetail, arg: {
                                  'detail': servicemanList[index].id
                                }).then((e) => value.notifyListeners()),
                            data: servicemanList[index]);
                      })
                  .paddingOnly(
                      left: Insets.i20, right: Insets.i20, bottom: Insets.i25),
          if (booking.bookingList.isNotEmpty)
            if (!isServiceman)
              Column(children: [
                HeadingRowCommon(
                    isViewAllShow: booking.bookingList.length >= 10,
                    title: appFonts.recentBooking,
                    onTap: () => value.onTapIndexOne(dashCtrl)),
                const VSpace(Sizes.s15),
                booking.bookingList.length > 2
                    ? Column(children: [
                        ...booking.bookingList
                            .getRange(0, 2)
                            .toList()
                            .asMap()
                            .entries
                            .map((e) => BookingLayout(
                                data: e.value,
                                onTap: () =>
                                    value.onTapBookings(e.value, context)))
                      ])
                    : Column(children: [
                        ...booking.bookingList.toList().asMap().entries.map(
                            (e) => BookingLayout(
                                data: e.value,
                                onTap: () =>
                                    value.onTapBookings(e.value, context)))
                      ])
              ])
                  .padding(
                      horizontal: Insets.i20,
                      top: Insets.i25,
                      bottom: Insets.i10)
                  .decorated(color: appColor(context).appTheme.whiteBg),
          const VSpace(Sizes.s25),
          // Column(children: [
          //   HeadingRowCommon(
          //       isViewAllShow: booking.bookingList.length >= 10,
          //       title: appFonts.recentBooking,
          //       onTap: () => value.onTapIndexOne(dashCtrl)),
          //   const VSpace(Sizes.s15),
          //   booking.bookingList.length > 2
          //       ? Column(children: [
          //           ...booking.bookingList
          //               .getRange(0, 2)
          //               .toList()
          //               .asMap()
          //               .entries
          //               .map((e) => BookingLayout(
          //                   data: e.value,
          //                   onTap: () => value.onTapBookings(e.value, context)))
          //         ])
          //       : Column(children: [
          //           ...booking.bookingList.toList().asMap().entries.map((e) =>
          //               BookingLayout(
          //                   data: e.value,
          //                   onTap: () => value.onTapBookings(e.value, context)))
          //         ])
          // ])
          //     .padding(
          //         horizontal: Insets.i20, top: Insets.i25, bottom: Insets.i10)
          //     .decorated(color: appColor(context).appTheme.whiteBg),
          // const VSpace(Sizes.s25),
          if (jobRequestList.isNotEmpty)
            Column(
              children: [
                HeadingRowCommon(
                        isViewAllShow: jobRequestList.length >= 4,
                        title: appFonts.customJobRequest,
                        onTap: () =>
                            route.pushNamed(context, routeName.jobRequestList))
                    .paddingSymmetric(horizontal: Insets.i20),
                const VSpace(Sizes.s15),
                jobRequestList.length > 3
                    ? Column(children: [
                        ...jobRequestList
                            .getRange(0, 3)
                            .toList()
                            .asMap()
                            .entries
                            .map((e) => JobRequestListCard(
                                  data: e.value,
                                ).paddingSymmetric(horizontal: Insets.i20))
                      ])
                    : Column(children: [
                        ...jobRequestList
                            .toList()
                            .asMap()
                            .entries
                            .map((e) => JobRequestListCard(
                                  data: e.value,
                                ).paddingSymmetric(horizontal: Insets.i20))
                      ]),
              ],
            ),
          const VSpace(Sizes.s25),
          if (popularServiceList.isNotEmpty)
            HeadingRowCommon(
                    isViewAllShow: popularServiceList.length >= 10,
                    title: appFonts.popularService,
                    onTap: () => route.pushNamed(
                        context, routeName.popularServiceScreen))
                .paddingSymmetric(horizontal: Insets.i20),
          if (popularServiceList.isNotEmpty) const VSpace(Sizes.s15),
          popularServiceList.length > 2
              ? Column(children: [
                  ...popularServiceList
                      .getRange(0, 2)
                      .toList()
                      .asMap()
                      .entries
                      .map((e) => FeaturedServicesLayout(
                          data: e.value,
                          onToggle: (val) => userApi.updateActiveStatusService(
                              context, e.value.id, val, e.key),
                          onTap: () => route.pushNamed(
                                  context, routeName.serviceDetails, arg: {
                                "detail": e.value.id
                              })).paddingSymmetric(horizontal: Insets.i20))
                ])
              : Column(children: [
                  ...popularServiceList.toList().asMap().entries.map((e) =>
                      FeaturedServicesLayout(
                          data: e.value,
                          onToggle: (val) => userApi.updateActiveStatusService(
                              context, e.value.id, val, e.key),
                          onTap: () => route.pushNamed(
                                  context, routeName.serviceDetails, arg: {
                                "detail": e.value.id
                              })).paddingSymmetric(horizontal: Insets.i20))
                ]),
          const VSpace(Sizes.s10),
          if (appSettingModel!.activation!.blogsEnable == "1")
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (blogList.isNotEmpty)
                  HeadingRowCommon(
                          title: appFonts.latestBlog,
                          isViewAllShow: blogList.length >= 10,
                          onTap: () => route.pushNamed(
                              context, routeName.latestBlogViewAll))
                      .paddingSymmetric(horizontal: Insets.i20),
                SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: blogList.length > 2
                        ? Row(
                                children: firstTwoBlogList
                                    .asMap()
                                    .entries
                                    .map((e) => LatestBlogLayout(data: e.value))
                                    .toList())
                            .paddingOnly(left: Insets.i20)
                        : Row(
                                children: blogList
                                    .asMap()
                                    .entries
                                    .map((e) => LatestBlogLayout(data: e.value))
                                    .toList())
                            .paddingOnly(left: Insets.i20))
              ],
            )
        ],
      );
    });
  }
}
