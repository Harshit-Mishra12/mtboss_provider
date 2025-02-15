import 'dart:developer';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:fixit_provider/providers/app_pages_provider/audio_call_provider.dart';
import 'package:fixit_provider/providers/app_pages_provider/job_request_providers/job_request_details_provider.dart';
import 'package:fixit_provider/providers/app_pages_provider/job_request_providers/job_request_list_provider.dart';
import 'package:fixit_provider/providers/app_pages_provider/video_call_provider.dart';
import 'package:fixit_provider/providers/common_providers/notification_provider.dart';
import 'package:fixit_provider/screens/app_pages_screens/audio_call/audio_call.dart';
import 'package:fixit_provider/services/environment.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'common/languages/app_language.dart';
import 'common/theme/app_theme.dart';
import 'config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
        name: 'Fixit',
        options: const FirebaseOptions(
            apiKey: "Your api key",
            projectId: "Your project id",
            messagingSenderId: "Your messaging sender id",
            appId: "Your app id"));
  } else {
    await Firebase.initializeApp(
        name: 'Fixit',
        options: const FirebaseOptions(
            storageBucket: "Your storage bucket",
            apiKey: "Your api key",
            projectId: "Your project id",
            messagingSenderId: "Your messaging sender id",
            appId: "Your app id"));
  }
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await initializeAppSettings();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: SharedPreferences.getInstance(),
        builder: (context, AsyncSnapshot<SharedPreferences> snapData) {
          if (snapData.hasData) {
            log("snapData.hasData::${snapData.data!.getString("selectedApi")}");
            // snapData.data!.remove("selectedLocale");
            return MultiProvider(providers: [
              ChangeNotifierProvider(
                  create: (_) => ThemeService(snapData.data!, context)),
              ChangeNotifierProvider(create: (_) => SplashProvider()),
              ChangeNotifierProvider(
                  create: (_) =>
                      LanguageProvider(snapData.data!)..getLanguageTranslate()),
              ChangeNotifierProvider(
                  create: (_) => CurrencyProvider(snapData.data!)),
              ChangeNotifierProvider(create: (_) => LoginAsProvider()),
              ChangeNotifierProvider(create: (_) => LoadingProvider()),
              ChangeNotifierProvider(
                  create: (_) => LoginAsServicemanProvider()),
              ChangeNotifierProvider(create: (_) => ForgetPasswordProvider()),
              ChangeNotifierProvider(create: (_) => VerifyOtpProvider()),
              ChangeNotifierProvider(create: (_) => ResetPasswordProvider()),
              ChangeNotifierProvider(create: (_) => IntroProvider()),
              ChangeNotifierProvider(create: (_) => SignUpCompanyProvider()),
              ChangeNotifierProvider(create: (_) => LocationProvider()),
              ChangeNotifierProvider(create: (_) => DashboardProvider()),
              ChangeNotifierProvider(create: (_) => HomeProvider()),
              ChangeNotifierProvider(create: (_) => EarningHistoryProvider()),
              ChangeNotifierProvider(create: (_) => NotificationProvider()),
              ChangeNotifierProvider(create: (_) => ServiceListProvider()),
              ChangeNotifierProvider(create: (_) => AddNewServiceProvider()),
              ChangeNotifierProvider(create: (_) => ServiceDetailsProvider()),
              ChangeNotifierProvider(create: (_) => ServiceReviewProvider()),
              ChangeNotifierProvider(create: (_) => CategoriesListProvider()),
              ChangeNotifierProvider(create: (_) => ServicemanListProvider()),
              ChangeNotifierProvider(create: (_) => AddServicemenProvider()),
              ChangeNotifierProvider(
                  create: (_) => LatestBLogDetailsProvider()),
              ChangeNotifierProvider(create: (_) => ProfileProvider()),
              ChangeNotifierProvider(create: (_) => ChangePasswordProvider()),
              ChangeNotifierProvider(create: (_) => CompanyDetailProvider()),
              ChangeNotifierProvider(
                  create: (_) => AppSettingProvider(snapData.data!)),
              ChangeNotifierProvider(create: (_) => ProfileDetailProvider()),
              ChangeNotifierProvider(create: (_) => BankDetailProvider()),
              ChangeNotifierProvider(create: (_) => TimeSlotProvider()),
              ChangeNotifierProvider(create: (_) => PackageListProvider()),
              ChangeNotifierProvider(create: (_) => ProviderDetailsProvider()),
              ChangeNotifierProvider(create: (_) => PackageDetailProvider()),
              ChangeNotifierProvider(create: (_) => AddPackageProvider()),
              ChangeNotifierProvider(create: (_) => SelectServiceProvider()),
              ChangeNotifierProvider(create: (_) => BookingDetailsProvider()),
              ChangeNotifierProvider(create: (_) => CommissionInfoProvider()),
              ChangeNotifierProvider(create: (_) => PlanDetailsProvider()),
              ChangeNotifierProvider(create: (_) => CheckoutWebViewProvider()),
              ChangeNotifierProvider(create: (_) => SubscriptionPlanProvider()),
              ChangeNotifierProvider(create: (_) => WalletProvider()),
              ChangeNotifierProvider(create: (_) => BookingProvider()),
              ChangeNotifierProvider(create: (_) => NoInternetProvider()),
              ChangeNotifierProvider(create: (_) => PendingBookingProvider()),
              ChangeNotifierProvider(create: (_) => AcceptedBookingProvider()),
              ChangeNotifierProvider(
                  create: (_) => BookingServicemenListProvider()),
              ChangeNotifierProvider(create: (_) => ChatProvider()),
              ChangeNotifierProvider(create: (_) => AssignBookingProvider()),
              ChangeNotifierProvider(
                  create: (_) => PendingApprovalBookingProvider()),
              ChangeNotifierProvider(create: (_) => OngoingBookingProvider()),
              ChangeNotifierProvider(create: (_) => AddExtraChargesProvider()),
              ChangeNotifierProvider(create: (_) => HoldBookingProvider()),
              ChangeNotifierProvider(create: (_) => CompletedBookingProvider()),
              ChangeNotifierProvider(create: (_) => AddServiceProofProvider()),
              ChangeNotifierProvider(create: (_) => CancelledBookingProvider()),
              ChangeNotifierProvider(create: (_) => ChatHistoryProvider()),
              ChangeNotifierProvider(create: (_) => DeleteDialogProvider()),
              ChangeNotifierProvider(create: (_) => LocationListProvider()),
              ChangeNotifierProvider(create: (_) => ServicemenDetailProvider()),
              ChangeNotifierProvider(create: (_) => NewLocationProvider()),
              ChangeNotifierProvider(create: (_) => IdVerificationProvider()),
              ChangeNotifierProvider(
                  create: (_) => CommissionHistoryProvider()),
              ChangeNotifierProvider(create: (_) => SearchProvider()),
              ChangeNotifierProvider(create: (_) => ViewLocationProvider()),
              ChangeNotifierProvider(create: (_) => CommonApiProvider()),
              ChangeNotifierProvider(create: (_) => UserDataApiProvider()),
              ChangeNotifierProvider(create: (_) => PaymentProvider()),
              ChangeNotifierProvider(create: (_) => PaymentProvider()),
              ChangeNotifierProvider(create: (_) => AudioCallProvider()),
              ChangeNotifierProvider(create: (_) => VideoCallProvider()),
              ChangeNotifierProvider(
                  create: (_) => JobRequestDetailsProvider()),
              ChangeNotifierProvider(create: (_) => JobRequestListProvider()),
            ], child: const RouteToPage());
          } else {
            return MaterialApp(
                theme: AppTheme.fromType(ThemeType.light).themeData,
                darkTheme: AppTheme.fromType(ThemeType.dark).themeData,
                themeMode: ThemeMode.light,
                debugShowCheckedModeBanner: false,
                home: const SplashLayout());
          }
        });
  }
}

class RouteToPage extends StatefulWidget {
  const RouteToPage({super.key});

  @override
  State<RouteToPage> createState() => _RouteToPageState();
}

class _RouteToPageState extends State<RouteToPage> {
  @override
  void initState() {
    // TODO: implement initState

    CustomNotificationController().initNotification(context);

    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeService>(builder: (context, theme, child) {
      return Consumer<LanguageProvider>(builder: (context, lang, child) {
        final provider = Provider.of<LanguageProvider>(context, listen: true);

        return MaterialApp(
          title: 'Fixit Provider',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.fromType(ThemeType.light).themeData,
          darkTheme: AppTheme.fromType(ThemeType.dark).themeData,
          locale: provider.locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            AppLocalizationDelagate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate
          ],
          themeMode: theme.theme,
          initialRoute: "/",
          routes: appRoute.route,
          builder: (context, child) {
            return Directionality(
              textDirection: lang.locale?.languageCode == 'ar'
                  ? TextDirection.rtl
                  : TextDirection.ltr,
              child: child!,
            );
          },
        );
      });
    });
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "Your api key",
          projectId: "Your project id",
          messagingSenderId: "Your messaging sender id",
          appId: "Your app id"));
  AndroidNotificationChannel channel = AndroidNotificationChannel(
    'Astrologically Partner local notifications',
    'High Importance Notifications for Astrologically',
    description: 'This channel is used for important notifications.',
    playSound: true,
    importance: Importance.high,
    sound: (message.data['title'] != 'Incoming Audio Call...' ||
            message.data['title'] != 'Incoming Video Call...')
        ? null
        : const RawResourceAndroidNotificationSound('callsound'),
  );

  showNotification(message);
}
