import 'dart:developer';

import '../../../config.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer3<WalletProvider, HomeProvider, UserDataApiProvider>(
        builder: (context1, value, homeVal, user, child) {
      return StatefulWrapper(
          onInit: () => Future.delayed(
              const Duration(milliseconds: 50), () => value.onReady(context)),
          child: Scaffold(
              appBar: AppBar(
                  leadingWidth: 0,
                  centerTitle: false,
                  title: Text(language(context, appFonts.wallet),
                      style: appCss.dmDenseBold18
                          .textColor(appColor(context).appTheme.darkText)),
                  actions: [
                    CommonArrow(
                        arrow: eSvgAssets.add,
                        onTap: () => value.onTapAdd(context)),
                    CommonArrow(
                            arrow: eSvgAssets.notification,
                            onTap: () => route.pushNamed(
                                context, routeName.notification))
                        .paddingSymmetric(horizontal: Insets.i20)
                  ]),
              body: isServiceman == true
                  ? value.servicemanWalletModel == null
                      ? const CommonEmpty()
                      : RefreshIndicator(
                          onRefresh: () async {
                            return user.getServicemanWalletList(context);
                          },
                          child: ListView(children: [
                            WalletBalanceLayout(
                                onTap: () => homeVal.onWithdraw(context)),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                          language(
                                              context, appFonts.paymentHistory),
                                          style: appCss.dmDenseBold18.textColor(
                                              appColor(context)
                                                  .appTheme
                                                  .darkText))
                                      .paddingOnly(
                                          top: Insets.i20, bottom: Insets.i15),
                                  if (value.servicemanWalletModel!.transactions!
                                      .data!.isEmpty)
                                    const CommonEmpty(),
                                  if (value.servicemanWalletModel!.transactions!
                                      .data!.isNotEmpty)
                                    ...value.servicemanWalletModel!
                                        .transactions!.data!
                                        .asMap()
                                        .entries
                                        .map((e) => PaymentHistoryLayout(
                                            data: e.value,
                                            onTap: () => route.pushNamed(
                                                context,
                                                routeName.completedBooking,
                                                arg: e.value.bookingId)))
                                ]).paddingSymmetric(horizontal: Insets.i20)
                          ]).paddingOnly(bottom: Insets.i100),
                        )
                  : value.providerWalletModel == null
                      ? const CommonEmpty()
                      : RefreshIndicator(
                          onRefresh: () async {
                            return user.getWalletList(context);
                          },
                          child: ListView(children: [
                            WalletBalanceLayout(
                                onTap: () => homeVal.onWithdraw(context)),
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                          language(
                                              context, appFonts.paymentHistory),
                                          style: appCss.dmDenseBold18.textColor(
                                              appColor(context)
                                                  .appTheme
                                                  .darkText))
                                      .paddingOnly(
                                          top: Insets.i20, bottom: Insets.i15),
                                  if (value.providerWalletModel!.transactions!
                                      .data!.isEmpty)
                                    const CommonEmpty(),
                                  if (value.providerWalletModel!.transactions!
                                      .data!.isNotEmpty)
                                    ...value.providerWalletModel!.transactions!
                                        .data!
                                        .asMap()
                                        .entries
                                        .map((e) => PaymentHistoryLayout(
                                            data: e.value,
                                            onTap: () => route.pushNamed(
                                                context,
                                                routeName.completedBooking,
                                                arg: e.value.bookingId)))
                                ]).paddingSymmetric(horizontal: Insets.i20)
                          ]).paddingOnly(bottom: Insets.i100),
                        )));
    });
  }
}
