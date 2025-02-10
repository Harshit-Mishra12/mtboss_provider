import '../config.dart';

class ReviewListWithTitle extends StatelessWidget {
  final List<Reviews>? reviews;

  const ReviewListWithTitle({super.key, this.reviews});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        HeadingRowCommon(
                isViewAllShow: reviews!.length >= 10,
                title: appFonts.review,
                onTap: () => route.pushNamed(context, routeName.serviceReview))
            .paddingOnly(bottom: Insets.i12),
        ...reviews!.asMap().entries.map((e) =>
            ServiceReviewLayout(data: e.value, index: e.key, list: reviews!)),
      ],
    );
  }
}
