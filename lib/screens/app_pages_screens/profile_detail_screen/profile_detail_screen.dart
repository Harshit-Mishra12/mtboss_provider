import '../../../config.dart';


class ProfileDetailScreen extends StatelessWidget {
  const ProfileDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileDetailProvider>(builder: (context1, value, child) {
      return PopScope(
        canPop: true,
        onPopInvoked: (didPop) {
          value.onBack(context, false);
          if(didPop) return;
        },
        child: StatefulWrapper(
          onInit: ()=> Future.delayed(DurationsDelay.ms150).then((_) => value.getArgument(context)),
          child: LoadingComponent(
            child: Scaffold(
                appBar: AppBar(
                    centerTitle: true,
                    leading: CommonArrow(
                        arrow: rtl(context) ? eSvgAssets.arrowRight : eSvgAssets.arrowLeft,
                        onTap: () => value.onBack(context, true)).paddingAll(Insets.i8),
                    title: Text(language(context, appFonts.profileDetails),
                        style: appCss.dmDenseBold18
                            .textColor(appColor(context).appTheme.darkText))),
                body: SingleChildScrollView(
                    child: Column(children: [
                  const VSpace(Sizes.s20),
                  Stack(children: [
                    const FieldsBackground(),
                    Column(children: [
                      Stack(alignment: Alignment.bottomCenter, children: [
                        Image.asset(eImageAssets.servicemanBg,
                                width: MediaQuery.of(context).size.width,
                                height: Sizes.s60)
                            .paddingOnly(bottom: Insets.i45),
                        Stack(alignment: Alignment.bottomRight, children: [
                          ProfilePicCommon(

                              image: value.imageFile,
                              imageUrl: userModel != null && userModel!.media !=  null && userModel!.media!.isNotEmpty &&
                                   userModel!.media![0].originalUrl != null
                                      ? userModel!.media![0].originalUrl!
                                      : null
                                  ),
                          SizedBox(
                                  child: SvgPicture.asset(eSvgAssets.edit,
                                          height: Sizes.s14)
                                      .paddingAll(Insets.i7))
                              .decorated(
                                  color: appColor(context).appTheme.stroke,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: appColor(context).appTheme.primary))
                              .inkWell(onTap: () => value.showLayout(context))
                        ])
                      ]),
                      const VSpace(Sizes.s40),
                      const TextFieldLayout()
                    ]).paddingSymmetric(vertical: Insets.i20)
                  ]),
                  const VSpace(Sizes.s40),
                  ButtonCommon(title: appFonts.update,onTap: ()=> value.onUpdate(context)).marginOnly(bottom: Insets.i20)
                ]).paddingSymmetric(horizontal: Insets.i20))),
          ),
        ),
      );
    });
  }
}
