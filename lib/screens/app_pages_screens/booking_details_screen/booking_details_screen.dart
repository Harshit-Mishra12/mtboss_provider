import '../../../config.dart';

class BookingDetailsScreen extends StatelessWidget {
  const BookingDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BookingDetailsProvider>(
      builder: (context1,value,child) {
        return StatefulWrapper(
          onInit: ()=> Future.delayed(const Duration(milliseconds: 50),() => value.onReady(context)),
          child: LoadingComponent(
            child: Scaffold(
                appBar: AppBarCommon(title: appFonts.bookingDetails),
                body:value.bookingModel == null ?Container() : SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    BookingDetailsLayout(data: value.bookingModel)
            
                  ]).padding(horizontal: Insets.i20,bottom: Insets.i10,top: Insets.i5)
                )),
          )
        );
      }
    );
  }
}
