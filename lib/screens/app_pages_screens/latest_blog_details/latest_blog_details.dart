import '../../../config.dart';

class LatestBlogDetailsScreen extends StatelessWidget {
  const LatestBlogDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LatestBLogDetailsProvider>(
        builder: (context1, value, child) {
      return StatefulWrapper(
          onInit: () => Future.delayed(const Duration(milliseconds: 100),() => value.onReady(context)),
          child: Scaffold(
              appBar: AppBarCommon(title: appFonts.latestBlog),
              body: SingleChildScrollView(
                  child: Column(children: [
                SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: value.data != null
                            ? const BlogDetailsLayout()
                            : Container())
                    .decorated(
                        color: appColor(context).appTheme.whiteBg,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 3,
                              spreadRadius: 2,
                              color: appColor(context)
                                  .appTheme
                                  .darkText
                                  .withOpacity(0.06))
                        ],
                        borderRadius: BorderRadius.circular(AppRadius.r8),
                        border: Border.all(
                            color: appColor(context).appTheme.stroke))
                    .padding(vertical: Insets.i15, horizontal: Insets.i20)
              ]))));
    });
  }
}
