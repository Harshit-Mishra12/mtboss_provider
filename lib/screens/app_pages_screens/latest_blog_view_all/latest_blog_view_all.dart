import '../../../config.dart';

class LatestBlogViewAll extends StatelessWidget {
  const LatestBlogViewAll({super.key});

  @override
  Widget build(BuildContext context) {
    final value = Provider.of<DashboardProvider>(context, listen: true);

    return Scaffold(
        appBar: AppBarCommon(title: appFonts.latestBlog),
        body: SingleChildScrollView(
            child: Container(
                alignment: Alignment.center,
                child: Column(
                        children: blogList
                            .asMap()
                            .entries
                            .map((e) =>
                                LatestBlogLayout(data: e.value, rPadding: 0)
                                    .width(MediaQuery.of(context).size.width))
                            .toList())
                    .paddingSymmetric(horizontal: Insets.i20))));
  }
}
