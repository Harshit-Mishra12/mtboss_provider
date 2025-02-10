
import 'package:camera/camera.dart';

import '../config.dart';

bool isFreelancer = false,isLogin = false,isServiceman =false,isSubscription =false;

List<CameraDescription> cameras = [];
UserModel? userModel;

PrimaryAddress? userPrimaryAddress;

ProviderModel? provider;

String? currentAddress, street;

LatLng? position;

int? setPrimaryAddress;

SubscriptionModel? userSubscribe;

ActiveSubscription? activeSubscription;

StatisticModel? statisticModel;

BankDetailModel? bankDetailModel;

List<Services> popularServiceList =[];

List<Services> allServices =[];

List<ServicePackageModel> servicePackageList =[];

List<ProviderDocumentModel> providerDocumentList =[];

List<NotificationModel> notificationList = [];

List<DocumentModel> notUpdateDocumentList =[];

List<PrimaryAddress> addressList =[];

List<Services> allServiceList =[];

List<Reviews> reviewList =[];

List<JobRequestModel> jobRequestList =[];

RevenueModel? revenueModel;

CommissionHistoryModel? commissionList;

TotalEarningModel? totalEarningModel;
