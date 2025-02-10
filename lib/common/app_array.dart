import '../config.dart';

class AppArray {
  var localList = <Locale>[
    const Locale('en'),
    const Locale('ar'),
    const Locale('fr'),
    const Locale('es'),
  ];

  List themeModeList = [
    appFonts.darkTheme,
    appFonts.lightTheme,
    appFonts.systemDefault
  ];

  // language list
  var languageList = [
    {
      "title": appFonts.english,
      "locale": const Locale('en', 'EN'),
      "icon": eImageAssets.en,
      "code": "en"
    },
    {
      "title": appFonts.arabic,
      "locale": const Locale("ar", 'AE'),
      "icon": eImageAssets.ar,
      "code": "ar"
    },
    {
      "title": appFonts.french,
      "locale": const Locale('fr', 'FR'),
      "icon": eImageAssets.fr,
      "code": "fr"
    },
    {
      "title": appFonts.spanish,
      "locale": const Locale("es", 'ES'),
      "icon": eImageAssets.es,
      "code": "es"
    },
  ];

  var joiningList = [
    {"title": appFonts.company, "image": eImageAssets.company},
    // {"title": appFonts.freelancer, "image": eImageAssets.freelancer}
  ];

  List experienceList = [
    appFonts.month,
    appFonts.years,
  ];

  List serviceAvailableAreaList = [];

  List<ValueItem> languageKnown = const [
    ValueItem(label: "english", value: '1'),
    ValueItem(label: 'german', value: '2'),
    ValueItem(label: 'spanish', value: '3'),
    ValueItem(label: 'japanese', value: '4'),
  ];

  var identityList = [
    appFonts.passport,
    appFonts.drivingLicence,
    appFonts.panCard,
    appFonts.aadhaarCard,
    appFonts.bankPassbook,
    appFonts.votingCard,
  ];

  var locationList = [
    "Howthorne - Los angels",
    "Sydney - Denmark",
    "Murfy - California",
    "Pilsburry - New yorke"
  ];

  var dashboardList = [
    {
      "title": appFonts.home,
      "icon": eSvgAssets.homeOut,
      "icon2": eSvgAssets.homeFill
    },
    {
      "title": appFonts.booking,
      "icon": eSvgAssets.bookingOut,
      "icon2": eSvgAssets.bookingFill
    },
    {
      "title": appFonts.wallet,
      "icon": eSvgAssets.wallet,
      "icon2": eSvgAssets.walletFill
    },
    {
      "title": appFonts.profile,
      "icon": eSvgAssets.profileOut,
      "icon2": eSvgAssets.profileFill
    },
  ];

  var socialList = [
    eSvgAssets.serviceChat,
    eSvgAssets.phoneBold,
    eSvgAssets.mailBold
  ];

  var availableServicemanList = [
    {
      "image": eImageAssets.as1,
      "title": "Willie Tanner",
      "service": "Barber",
      "year": "2020",
      "rate": "3.0"
    },
    {
      "image": eImageAssets.as2,
      "title": "Lynn Tanner",
      "service": "Ac repair",
      "year": "2021",
      "rate": "4.0"
    },
    {
      "image": eImageAssets.as3,
      "title": "Dori Doreau",
      "service": "Cook",
      "year": "2020",
      "rate": "3.0"
    },
    {
      "image": eImageAssets.as4,
      "title": "Angela Bower",
      "service": "Carpenter",
      "year": "2019",
      "rate": "3.0"
    },
    {
      "image": eImageAssets.as1,
      "title": "Willie Tanner",
      "service": "Barber",
      "year": "2020",
      "rate": "2.5"
    },
    {
      "image": eImageAssets.as2,
      "title": "Lynn Tanner",
      "service": "Ac repair",
      "year": "2021",
      "rate": "4.5"
    },
  ];

  var recentBookingList = [
    {
      "image": eImageAssets.as1,
      "isExpand": false,
      "name": "Hair spa & color",
      "status": appFonts.pending,
      "price": "15.23",
      "offer": "15% off",
      "date": "10 Aug'23",
      "time": "6:00 PM",
      "serviceman": "1",
      "bookingNumber": "#58961",
      "package_id": null,
      "location": "California - USA",
      "customerList": [
        {"image": eImageAssets.as4, "title": "Nolan Westervelt"}
      ],
      "servicemanLists": [
        {
          "role": appFonts.serviceman,
          "image": eImageAssets.as1,
          "title": "Nolan Westervelt",
          "rate": "3.5",
        }
      ]
    },
    {
      "image": eImageAssets.as2,
      "isExpand": false,
      "name": "Hair spa & color",
      "status": appFonts.pending,
      "price": "15.23",
      "offer": "15% off",
      "date": "10 Aug'23",
      "time": "6:00 PM",
      "serviceman": "1",
      "bookingNumber": "#58961",
      "package_id": null,
      "location": "California - USA",
      "customerList": [
        {"image": eImageAssets.as4, "title": "Nolan Westervelt"}
      ],
      "servicemanLists": []
    },
  ];

  List popularServiceList = [
    {
      "title": "Ac water drop solution",
      "image": eImageAssets.as1,
      "work": "Ac repair",
      "booked": "40",
      "price": "12.44",
      "isStatus": true,
      "rating": "3.0"
    },
    {
      "title": "Ac compressor fitting",
      "image": eImageAssets.as1,
      "work": "Ac repair",
      "booked": "155",
      "price": "12.44",
      "isStatus": true,
      "rating": "4.0"
    },
    {
      "title": "Ac compressor heat solution",
      "image": eImageAssets.as1,
      "work": "Ac repair",
      "booked": "275",
      "price": "12.44",
      "isStatus": true,
      "rating": "3.0"
    },
    {
      "title": "Ac compressor fitting",
      "image": eImageAssets.as1,
      "work": "Ac repair",
      "booked": "215",
      "price": "12.44",
      "isStatus": true,
      "rating": "4.0"
    }
  ];

  var earningList = [
    {
      "title": appFonts.totalEarning,
      "image": eSvgAssets.earning,
      "price": "3,263.03"
    },
    {
      "title": appFonts.totalBooking,
      "image": eSvgAssets.booking,
      "price": "666"
    },
    {"title": appFonts.totalService, "image": eSvgAssets.box, "price": "34"},
    {
      "title": appFonts.totalCategory,
      "image": eSvgAssets.category,
      "price": "60"
    },
    {
      "title": appFonts.totalServiceman,
      "image": eSvgAssets.servicemanIconFill,
      "price": "60"
    }
  ];

  var serviceManEarningList = [
    {
      "title": appFonts.totalEarning,
      "image": eSvgAssets.earning,
      "price": "3,263.03"
    },
    {
      "title": appFonts.totalBooking,
      "image": eSvgAssets.booking,
      "price": "666"
    },
    {"title": appFonts.totalService, "image": eSvgAssets.box, "price": "34"}
  ];

  var chartDataList = [
    {"title": "Cleaning", "per": "35", "color": const Color(0xFF5465FF)},
    {"title": "Carpenter", "per": "18", "color": const Color(0xFFB5BCFA)},
    {"title": "Ac repair ", "per": "25", "color": const Color(0xFF7482FD)},
    {"title": "Salon", "per": "12", "color": const Color(0xFFD5D9F9)},
    {"title": "Painting", "per": "20", "color": const Color(0xFF949FFC)},
  ];

  var historyList = [
    {
      "title": "Painting cancelled #1256",
      "date": "15 Aug, 2023",
      "price": "30.50",
      "status": "Credit"
    },
    {
      "title": "House hold cook #4589",
      "date": "14 Aug, 2023",
      "price": "13.50",
      "status": "Debit"
    },
    {
      "title": "House hold cook #4589",
      "date": "14 Aug, 2023",
      "price": "13.50",
      "status": "Debit"
    },
    {
      "title": "House hold cook #4589",
      "date": "14 Aug, 2023",
      "price": "13.50",
      "status": "Debit"
    },
    {
      "title": "Painting cancelled #1256",
      "date": "15 Aug, 2023",
      "price": "30.50",
      "status": "Credit"
    },
    {
      "title": "House hold cook #4589",
      "date": "14 Aug, 2023",
      "price": "13.50",
      "status": "Debit"
    },
    {
      "title": "Painting cancelled #1256",
      "date": "15 Aug, 2023",
      "price": "30.50",
      "status": "Credit"
    },
  ];

  List allCategories = [
    "All categories",
    "Ac cleaning",
    "Cleaning",
    "Painting",
    "Cooking"
  ];

  List monthList = [
    {"title": "January", "index": 1},
    {"title": "February", "index": 2},
    {"title": "March", "index": 3},
    {"title": "April", "index": 4},
    {"title": "May", "index": 5},
    {"title": "June", "index": 6},
    {"title": "July", "index": 7},
    {"title": "August", "index": 8},
    {"title": "September", "index": 9},
    {"title": "October", "index": 10},
    {"title": "November", "index": 11},
    {"title": "December", "index": 12}
  ];

  var notificationList = [
    {
      "icon": eSvgAssets.user,
      "title": "Reminder !",
      "time": "1 min",
      "message": "You have booked plumber service today at 6:30pm.",
      "isRead": false
    },
    {
      "icon": eSvgAssets.user,
      "title": "Service start",
      "time": "2 min",
      "message": "Jane cooper has started service of cleaning.",
      "isRead": false
    },
    {
      "icon": eSvgAssets.receipt,
      "title": "Add new image",
      "time": "2 min",
      "message": "Add a new carpenter & furnishing category service picture.",
      "image": [
        eImageAssets.notiImage,
        eImageAssets.notiImage,
        eImageAssets.notiImage,
      ],
      "isRead": true
    },
    {
      "icon": eSvgAssets.wallet,
      "title": "Payment update",
      "time": "2 min",
      "message": "Your payment is done of cleaning service.",
      "isRead": true
    },
    {
      "icon": eSvgAssets.receipt,
      "title": "Update status",
      "time": "2 min",
      "message": "Booking status has been changed from pending to accepted.",
      "isRead": true
    },
    {
      "icon": eSvgAssets.clock,
      "title": "Reminder !",
      "time": "1 min",
      "message": "You have booked plumber service today at 6:30pm.",
      "isRead": true
    },
  ];

  List categoriesList = [
    {
      "id": 1,
      "title": "Ac Repair",
      "slug": "ac Repair",
      "description": null,
      "parent_id": null,
      "meta_title": null,
      "meta_description": null,
      "commission": "12",
      "status": "1",
      "is_featured": "1",
      "category_type": "service",
      "created_by": "1",
      "created_at": "2023-10-04T11:22:08.000000Z",
      "updated_at": "2023-10-04T11:22:08.000000Z",
      "deleted_at": null,
      "media": [
        {
          "id": 1,
          "model_type": "App\\Models\\Category",
          "model_id": "14",
          "uuid": "deb76107-29f2-4a39-81d9-24994e7bdced",
          "collection_name": "image",
          "name": "Icon (6)",
          "file_name": "Icon-(6).png",
          "mime_type": "image/png",
          "disk": "public",
          "conversions_disk": "public",
          "size": "2075",
          "manipulations": [],
          "custom_properties": [],
          "generated_conversions": [],
          "responsive_images": [],
          "order_column": "1",
          "created_at": "2023-10-04T11:22:08.000000Z",
          "updated_at": "2023-10-04T11:22:08.000000Z",
          "original_url": eSvgAssets.ac,
          "preview_url": ""
        }
      ],
      "has_sub_categories": [
        {
          "id": 1,
          "title": "Home Furniture",
          "slug": "home-furniture",
          "description": "Home Furniture",
          "parent_id": "5",
          "meta_title": null,
          "meta_description": null,
          "commission": "1",
          "status": "1",
          "is_featured": "1",
          "category_type": "service",
          "created_by": "1",
          "created_at": "2023-10-04T05:47:42.000000Z",
          "updated_at": "2023-10-04T05:47:42.000000Z",
          "deleted_at": null,
          "media": [
            {
              "id": 1,
              "model_type": "App\\Models\\Category",
              "model_id": "9",
              "uuid": "daa7579d-02cb-43b3-9bf7-eb5f982379ae",
              "collection_name": "image",
              "name": "Carpenter",
              "file_name": "Carpenter.png",
              "mime_type": "image/png",
              "disk": "public",
              "conversions_disk": "public",
              "size": "749",
              "manipulations": [],
              "custom_properties": [],
              "generated_conversions": [],
              "responsive_images": [],
              "order_column": "1",
              "created_at": "2023-10-04T05:47:42.000000Z",
              "updated_at": "2023-10-04T05:47:42.000000Z",
              "original_url": eSvgAssets.carpenter,
              "preview_url": ""
            }
          ]
        },
        {
          "id": 2,
          "title": "Home",
          "slug": "home-furniture",
          "description": "Home Furniture",
          "parent_id": "5",
          "meta_title": null,
          "meta_description": null,
          "commission": "1",
          "status": "1",
          "is_featured": "1",
          "category_type": "service",
          "created_by": "1",
          "created_at": "2023-10-04T05:47:42.000000Z",
          "updated_at": "2023-10-04T05:47:42.000000Z",
          "deleted_at": null,
          "media": [
            {
              "id": 1,
              "model_type": "App\\Models\\Category",
              "model_id": "9",
              "uuid": "daa7579d-02cb-43b3-9bf7-eb5f982379ae",
              "collection_name": "image",
              "name": "Carpenter",
              "file_name": "Carpenter.png",
              "mime_type": "image/png",
              "disk": "public",
              "conversions_disk": "public",
              "size": "749",
              "manipulations": [],
              "custom_properties": [],
              "generated_conversions": [],
              "responsive_images": [],
              "order_column": "1",
              "created_at": "2023-10-04T05:47:42.000000Z",
              "updated_at": "2023-10-04T05:47:42.000000Z",
              "original_url": eSvgAssets.carpenter,
              "preview_url": ""
            }
          ]
        },
        {
          "id": 3,
          "title": "Home Decore",
          "slug": "home-furniture",
          "description": "Home Furniture",
          "parent_id": "5",
          "meta_title": null,
          "meta_description": null,
          "commission": "1",
          "status": "1",
          "is_featured": "1",
          "category_type": "service",
          "created_by": "1",
          "created_at": "2023-10-04T05:47:42.000000Z",
          "updated_at": "2023-10-04T05:47:42.000000Z",
          "deleted_at": null,
          "media": [
            {
              "id": 1,
              "model_type": "App\\Models\\Category",
              "model_id": "9",
              "uuid": "daa7579d-02cb-43b3-9bf7-eb5f982379ae",
              "collection_name": "image",
              "name": "Carpenter",
              "file_name": "Carpenter.png",
              "mime_type": "image/png",
              "disk": "public",
              "conversions_disk": "public",
              "size": "749",
              "manipulations": [],
              "custom_properties": [],
              "generated_conversions": [],
              "responsive_images": [],
              "order_column": "1",
              "created_at": "2023-10-04T05:47:42.000000Z",
              "updated_at": "2023-10-04T05:47:42.000000Z",
              "original_url": eSvgAssets.carpenter,
              "preview_url": ""
            }
          ]
        }
      ]
    },
    {
      "id": 2,
      "title": "Cleaning",
      "slug": "Cleaning",
      "description": null,
      "parent_id": null,
      "meta_title": null,
      "meta_description": null,
      "commission": "12",
      "status": "1",
      "is_featured": "1",
      "category_type": "service",
      "created_by": "1",
      "created_at": "2023-10-04T11:21:38.000000Z",
      "updated_at": "2023-10-04T11:21:38.000000Z",
      "deleted_at": null,
      "media": [
        {
          "id": 1,
          "model_type": "App\\Models\\Category",
          "model_id": "13",
          "uuid": "9d3857fc-df30-47d2-8955-44ac81a2d500",
          "collection_name": "image",
          "name": "Icon (5)",
          "file_name": "Icon-(5).png",
          "mime_type": "image/png",
          "disk": "public",
          "conversions_disk": "public",
          "size": "1578",
          "manipulations": [],
          "custom_properties": [],
          "generated_conversions": [],
          "responsive_images": [],
          "order_column": "1",
          "created_at": "2023-10-04T11:21:38.000000Z",
          "updated_at": "2023-10-04T11:21:38.000000Z",
          "original_url": eSvgAssets.cleaning,
          "preview_url": ""
        }
      ],
      "has_sub_categories": [
        {
          "id": 1,
          "title": "Home Furniture",
          "slug": "home-furniture",
          "description": "Home Furniture",
          "parent_id": "5",
          "meta_title": null,
          "meta_description": null,
          "commission": "1",
          "status": "1",
          "is_featured": "1",
          "category_type": "service",
          "created_by": "1",
          "created_at": "2023-10-04T05:47:42.000000Z",
          "updated_at": "2023-10-04T05:47:42.000000Z",
          "deleted_at": null,
          "media": [
            {
              "id": 1,
              "model_type": "App\\Models\\Category",
              "model_id": "9",
              "uuid": "daa7579d-02cb-43b3-9bf7-eb5f982379ae",
              "collection_name": "image",
              "name": "Carpenter",
              "file_name": "Carpenter.png",
              "mime_type": "image/png",
              "disk": "public",
              "conversions_disk": "public",
              "size": "749",
              "manipulations": [],
              "custom_properties": [],
              "generated_conversions": [],
              "responsive_images": [],
              "order_column": "1",
              "created_at": "2023-10-04T05:47:42.000000Z",
              "updated_at": "2023-10-04T05:47:42.000000Z",
              "original_url": eSvgAssets.carpenter,
              "preview_url": ""
            }
          ]
        },
        {
          "id": 2,
          "title": "Home",
          "slug": "home-furniture",
          "description": "Home Furniture",
          "parent_id": "5",
          "meta_title": null,
          "meta_description": null,
          "commission": "1",
          "status": "1",
          "is_featured": "1",
          "category_type": "service",
          "created_by": "1",
          "created_at": "2023-10-04T05:47:42.000000Z",
          "updated_at": "2023-10-04T05:47:42.000000Z",
          "deleted_at": null,
          "media": [
            {
              "id": 1,
              "model_type": "App\\Models\\Category",
              "model_id": "9",
              "uuid": "daa7579d-02cb-43b3-9bf7-eb5f982379ae",
              "collection_name": "image",
              "name": "Carpenter",
              "file_name": "Carpenter.png",
              "mime_type": "image/png",
              "disk": "public",
              "conversions_disk": "public",
              "size": "749",
              "manipulations": [],
              "custom_properties": [],
              "generated_conversions": [],
              "responsive_images": [],
              "order_column": "1",
              "created_at": "2023-10-04T05:47:42.000000Z",
              "updated_at": "2023-10-04T05:47:42.000000Z",
              "original_url": eSvgAssets.carpenter,
              "preview_url": ""
            }
          ]
        },
        {
          "id": 3,
          "title": "Home Decore",
          "slug": "home-furniture",
          "description": "Home Furniture",
          "parent_id": "5",
          "meta_title": null,
          "meta_description": null,
          "commission": "1",
          "status": "1",
          "is_featured": "1",
          "category_type": "service",
          "created_by": "1",
          "created_at": "2023-10-04T05:47:42.000000Z",
          "updated_at": "2023-10-04T05:47:42.000000Z",
          "deleted_at": null,
          "media": [
            {
              "id": 1,
              "model_type": "App\\Models\\Category",
              "model_id": "9",
              "uuid": "daa7579d-02cb-43b3-9bf7-eb5f982379ae",
              "collection_name": "image",
              "name": "Carpenter",
              "file_name": "Carpenter.png",
              "mime_type": "image/png",
              "disk": "public",
              "conversions_disk": "public",
              "size": "749",
              "manipulations": [],
              "custom_properties": [],
              "generated_conversions": [],
              "responsive_images": [],
              "order_column": "1",
              "created_at": "2023-10-04T05:47:42.000000Z",
              "updated_at": "2023-10-04T05:47:42.000000Z",
              "original_url": eSvgAssets.carpenter,
              "preview_url": ""
            }
          ]
        }
      ]
    },
    {
      "id": 3,
      "title": "Painter",
      "slug": "painter",
      "description": null,
      "parent_id": null,
      "meta_title": null,
      "meta_description": null,
      "commission": "10",
      "status": "1",
      "is_featured": "1",
      "category_type": "service",
      "created_by": "1",
      "created_at": "2023-10-04T11:20:52.000000Z",
      "updated_at": "2023-10-04T11:20:52.000000Z",
      "deleted_at": null,
      "media": [
        {
          "id": 1,
          "model_type": "App\\Models\\Category",
          "model_id": "12",
          "uuid": "a78b22ed-6fa2-4091-afb5-2b7ccb5f7a57",
          "collection_name": "image",
          "name": "Icon (4)",
          "file_name": "Icon-(4).png",
          "mime_type": "image/png",
          "disk": "public",
          "conversions_disk": "public",
          "size": "1368",
          "manipulations": [],
          "custom_properties": [],
          "generated_conversions": [],
          "responsive_images": [],
          "order_column": "1",
          "created_at": "2023-10-04T11:20:52.000000Z",
          "updated_at": "2023-10-04T11:20:52.000000Z",
          "original_url": eSvgAssets.painter,
          "preview_url": ""
        }
      ],
      "has_sub_categories": [
        {
          "id": 1,
          "title": "Home Furniture",
          "slug": "home-furniture",
          "description": "Home Furniture",
          "parent_id": "5",
          "meta_title": null,
          "meta_description": null,
          "commission": "1",
          "status": "1",
          "is_featured": "1",
          "category_type": "service",
          "created_by": "1",
          "created_at": "2023-10-04T05:47:42.000000Z",
          "updated_at": "2023-10-04T05:47:42.000000Z",
          "deleted_at": null,
          "media": [
            {
              "id": 1,
              "model_type": "App\\Models\\Category",
              "model_id": "9",
              "uuid": "daa7579d-02cb-43b3-9bf7-eb5f982379ae",
              "collection_name": "image",
              "name": "Carpenter",
              "file_name": "Carpenter.png",
              "mime_type": "image/png",
              "disk": "public",
              "conversions_disk": "public",
              "size": "749",
              "manipulations": [],
              "custom_properties": [],
              "generated_conversions": [],
              "responsive_images": [],
              "order_column": "1",
              "created_at": "2023-10-04T05:47:42.000000Z",
              "updated_at": "2023-10-04T05:47:42.000000Z",
              "original_url": eSvgAssets.carpenter,
              "preview_url": ""
            }
          ]
        },
        {
          "id": 2,
          "title": "Home",
          "slug": "home-furniture",
          "description": "Home Furniture",
          "parent_id": "5",
          "meta_title": null,
          "meta_description": null,
          "commission": "1",
          "status": "1",
          "is_featured": "1",
          "category_type": "service",
          "created_by": "1",
          "created_at": "2023-10-04T05:47:42.000000Z",
          "updated_at": "2023-10-04T05:47:42.000000Z",
          "deleted_at": null,
          "media": [
            {
              "id": 1,
              "model_type": "App\\Models\\Category",
              "model_id": "9",
              "uuid": "daa7579d-02cb-43b3-9bf7-eb5f982379ae",
              "collection_name": "image",
              "name": "Carpenter",
              "file_name": "Carpenter.png",
              "mime_type": "image/png",
              "disk": "public",
              "conversions_disk": "public",
              "size": "749",
              "manipulations": [],
              "custom_properties": [],
              "generated_conversions": [],
              "responsive_images": [],
              "order_column": "1",
              "created_at": "2023-10-04T05:47:42.000000Z",
              "updated_at": "2023-10-04T05:47:42.000000Z",
              "original_url": eSvgAssets.carpenter,
              "preview_url": ""
            }
          ]
        },
        {
          "id": 3,
          "title": "Home Decore",
          "slug": "home-furniture",
          "description": "Home Furniture",
          "parent_id": "5",
          "meta_title": null,
          "meta_description": null,
          "commission": "1",
          "status": "1",
          "is_featured": "1",
          "category_type": "service",
          "created_by": "1",
          "created_at": "2023-10-04T05:47:42.000000Z",
          "updated_at": "2023-10-04T05:47:42.000000Z",
          "deleted_at": null,
          "media": [
            {
              "id": 1,
              "model_type": "App\\Models\\Category",
              "model_id": "9",
              "uuid": "daa7579d-02cb-43b3-9bf7-eb5f982379ae",
              "collection_name": "image",
              "name": "Carpenter",
              "file_name": "Carpenter.png",
              "mime_type": "image/png",
              "disk": "public",
              "conversions_disk": "public",
              "size": "749",
              "manipulations": [],
              "custom_properties": [],
              "generated_conversions": [],
              "responsive_images": [],
              "order_column": "1",
              "created_at": "2023-10-04T05:47:42.000000Z",
              "updated_at": "2023-10-04T05:47:42.000000Z",
              "original_url": eSvgAssets.carpenter,
              "preview_url": ""
            }
          ]
        }
      ]
    },
    {
      "id": 4,
      "title": "Electrician",
      "slug": "electrician",
      "description": null,
      "parent_id": null,
      "meta_title": null,
      "meta_description": null,
      "commission": "10",
      "status": "1",
      "is_featured": "1",
      "category_type": "service",
      "created_by": "1",
      "created_at": "2023-10-04T06:36:29.000000Z",
      "updated_at": "2023-10-04T06:36:29.000000Z",
      "deleted_at": null,
      "media": [
        {
          "id": 1,
          "model_type": "App\\Models\\Category",
          "model_id": "11",
          "uuid": "c059cfa8-f5a1-49e4-be06-d5290541c1db",
          "collection_name": "image",
          "name": "Icon (3)",
          "file_name": "Icon-(3).png",
          "mime_type": "image/png",
          "disk": "public",
          "conversions_disk": "public",
          "size": "2128",
          "manipulations": [],
          "custom_properties": [],
          "generated_conversions": [],
          "responsive_images": [],
          "order_column": "1",
          "created_at": "2023-10-04T06:56:48.000000Z",
          "updated_at": "2023-10-04T06:56:48.000000Z",
          "original_url": eSvgAssets.electrician,
          "preview_url": ""
        }
      ],
      "has_sub_categories": [
        {
          "id": 1,
          "title": "Home Furniture",
          "slug": "home-furniture",
          "description": "Home Furniture",
          "parent_id": "5",
          "meta_title": null,
          "meta_description": null,
          "commission": "1",
          "status": "1",
          "is_featured": "1",
          "category_type": "service",
          "created_by": "1",
          "created_at": "2023-10-04T05:47:42.000000Z",
          "updated_at": "2023-10-04T05:47:42.000000Z",
          "deleted_at": null,
          "media": [
            {
              "id": 1,
              "model_type": "App\\Models\\Category",
              "model_id": "9",
              "uuid": "daa7579d-02cb-43b3-9bf7-eb5f982379ae",
              "collection_name": "image",
              "name": "Carpenter",
              "file_name": "Carpenter.png",
              "mime_type": "image/png",
              "disk": "public",
              "conversions_disk": "public",
              "size": "749",
              "manipulations": [],
              "custom_properties": [],
              "generated_conversions": [],
              "responsive_images": [],
              "order_column": "1",
              "created_at": "2023-10-04T05:47:42.000000Z",
              "updated_at": "2023-10-04T05:47:42.000000Z",
              "original_url": eSvgAssets.carpenter,
              "preview_url": ""
            }
          ]
        },
        {
          "id": 2,
          "title": "Home",
          "slug": "home-furniture",
          "description": "Home Furniture",
          "parent_id": "5",
          "meta_title": null,
          "meta_description": null,
          "commission": "1",
          "status": "1",
          "is_featured": "1",
          "category_type": "service",
          "created_by": "1",
          "created_at": "2023-10-04T05:47:42.000000Z",
          "updated_at": "2023-10-04T05:47:42.000000Z",
          "deleted_at": null,
          "media": [
            {
              "id": 1,
              "model_type": "App\\Models\\Category",
              "model_id": "9",
              "uuid": "daa7579d-02cb-43b3-9bf7-eb5f982379ae",
              "collection_name": "image",
              "name": "Carpenter",
              "file_name": "Carpenter.png",
              "mime_type": "image/png",
              "disk": "public",
              "conversions_disk": "public",
              "size": "749",
              "manipulations": [],
              "custom_properties": [],
              "generated_conversions": [],
              "responsive_images": [],
              "order_column": "1",
              "created_at": "2023-10-04T05:47:42.000000Z",
              "updated_at": "2023-10-04T05:47:42.000000Z",
              "original_url": eSvgAssets.carpenter,
              "preview_url": ""
            }
          ]
        },
        {
          "id": 3,
          "title": "Home Decore",
          "slug": "home-furniture",
          "description": "Home Furniture",
          "parent_id": "5",
          "meta_title": null,
          "meta_description": null,
          "commission": "1",
          "status": "1",
          "is_featured": "1",
          "category_type": "service",
          "created_by": "1",
          "created_at": "2023-10-04T05:47:42.000000Z",
          "updated_at": "2023-10-04T05:47:42.000000Z",
          "deleted_at": null,
          "media": [
            {
              "id": 1,
              "model_type": "App\\Models\\Category",
              "model_id": "9",
              "uuid": "daa7579d-02cb-43b3-9bf7-eb5f982379ae",
              "collection_name": "image",
              "name": "Carpenter",
              "file_name": "Carpenter.png",
              "mime_type": "image/png",
              "disk": "public",
              "conversions_disk": "public",
              "size": "749",
              "manipulations": [],
              "custom_properties": [],
              "generated_conversions": [],
              "responsive_images": [],
              "order_column": "1",
              "created_at": "2023-10-04T05:47:42.000000Z",
              "updated_at": "2023-10-04T05:47:42.000000Z",
              "original_url": eSvgAssets.carpenter,
              "preview_url": ""
            }
          ]
        }
      ]
    },
    {
      "id": 5,
      "title": "Cooking",
      "slug": "cooking",
      "description": "Cooking",
      "parent_id": null,
      "meta_title": null,
      "meta_description": null,
      "commission": "3",
      "status": "1",
      "is_featured": "1",
      "category_type": "service",
      "created_by": "1",
      "created_at": "2023-09-25T13:18:33.000000Z",
      "updated_at": "2023-09-25T13:18:33.000000Z",
      "deleted_at": null,
      "media": [
        {
          "id": 1,
          "model_type": "App\\Models\\Category",
          "model_id": "6",
          "uuid": "404ad8c1-dd6e-4219-8fc8-8bbfd7ba2d4f",
          "collection_name": "image",
          "name": "Cooking",
          "file_name": "Cooking.png",
          "mime_type": "image/png",
          "disk": "public",
          "conversions_disk": "public",
          "size": "2035",
          "manipulations": [],
          "custom_properties": [],
          "generated_conversions": [],
          "responsive_images": [],
          "order_column": "1",
          "created_at": "2023-10-04T06:56:07.000000Z",
          "updated_at": "2023-10-04T06:56:07.000000Z",
          "original_url": eSvgAssets.cooking,
          "preview_url": ""
        }
      ],
      "has_sub_categories": [
        {
          "id": 1,
          "title": "Fast Food Cooking",
          "slug": "fast-food-cooking",
          "description": "Fast Food Cooking",
          "parent_id": "6",
          "meta_title": null,
          "meta_description": null,
          "commission": "2",
          "status": "1",
          "is_featured": "1",
          "category_type": "service",
          "created_by": "1",
          "created_at": "2023-10-04T05:48:35.000000Z",
          "updated_at": "2023-10-04T05:48:35.000000Z",
          "deleted_at": null,
          "media": [
            {
              "id": 1,
              "model_type": "App\\Models\\Category",
              "model_id": "10",
              "uuid": "eb1077c0-18b5-4d5b-992f-035fe96aefd1",
              "collection_name": "image",
              "name": "Cooking",
              "file_name": "Cooking.png",
              "mime_type": "image/png",
              "disk": "public",
              "conversions_disk": "public",
              "size": "640",
              "manipulations": [],
              "custom_properties": [],
              "generated_conversions": [],
              "responsive_images": [],
              "order_column": "1",
              "created_at": "2023-10-04T05:48:35.000000Z",
              "updated_at": "2023-10-04T05:48:35.000000Z",
              "original_url": eSvgAssets.cooking,
              "preview_url": ""
            }
          ]
        },
        {
          "id": 2,
          "title": "Fast Food Cooking",
          "slug": "fast-food-cooking",
          "description": "Fast Food Cooking",
          "parent_id": "6",
          "meta_title": null,
          "meta_description": null,
          "commission": "2",
          "status": "1",
          "is_featured": "1",
          "category_type": "service",
          "created_by": "1",
          "created_at": "2023-10-04T05:48:35.000000Z",
          "updated_at": "2023-10-04T05:48:35.000000Z",
          "deleted_at": null,
          "media": [
            {
              "id": 1,
              "model_type": "App\\Models\\Category",
              "model_id": "10",
              "uuid": "eb1077c0-18b5-4d5b-992f-035fe96aefd1",
              "collection_name": "image",
              "name": "Cooking",
              "file_name": "Cooking.png",
              "mime_type": "image/png",
              "disk": "public",
              "conversions_disk": "public",
              "size": "640",
              "manipulations": [],
              "custom_properties": [],
              "generated_conversions": [],
              "responsive_images": [],
              "order_column": "1",
              "created_at": "2023-10-04T05:48:35.000000Z",
              "updated_at": "2023-10-04T05:48:35.000000Z",
              "original_url": eSvgAssets.cooking,
              "preview_url": ""
            }
          ]
        },
        {
          "id": 3,
          "title": "Fast Food Cooking",
          "slug": "fast-food-cooking",
          "description": "Fast Food Cooking",
          "parent_id": "6",
          "meta_title": null,
          "meta_description": null,
          "commission": "2",
          "status": "1",
          "is_featured": "1",
          "category_type": "service",
          "created_by": "1",
          "created_at": "2023-10-04T05:48:35.000000Z",
          "updated_at": "2023-10-04T05:48:35.000000Z",
          "deleted_at": null,
          "media": [
            {
              "id": 1,
              "model_type": "App\\Models\\Category",
              "model_id": "10",
              "uuid": "eb1077c0-18b5-4d5b-992f-035fe96aefd1",
              "collection_name": "image",
              "name": "Cooking",
              "file_name": "Cooking.png",
              "mime_type": "image/png",
              "disk": "public",
              "conversions_disk": "public",
              "size": "640",
              "manipulations": [],
              "custom_properties": [],
              "generated_conversions": [],
              "responsive_images": [],
              "order_column": "1",
              "created_at": "2023-10-04T05:48:35.000000Z",
              "updated_at": "2023-10-04T05:48:35.000000Z",
              "original_url": eSvgAssets.cooking,
              "preview_url": ""
            }
          ]
        }
      ]
    },
    {
      "id": 6,
      "title": "Carpenter",
      "slug": "carpenter",
      "description": "Carpenter",
      "parent_id": null,
      "meta_title": null,
      "meta_description": null,
      "commission": "2",
      "status": "1",
      "is_featured": "1",
      "category_type": "service",
      "created_by": "1",
      "created_at": "2023-09-25T13:17:35.000000Z",
      "updated_at": "2023-09-25T13:17:35.000000Z",
      "deleted_at": null,
      "media": [
        {
          "id": 1,
          "model_type": "App\\Models\\Category",
          "model_id": "5",
          "uuid": "6cbe2cef-74da-41c9-868a-69802544abd7",
          "collection_name": "image",
          "name": "Icon (2)",
          "file_name": "Icon-(2).png",
          "mime_type": "image/png",
          "disk": "public",
          "conversions_disk": "public",
          "size": "1952",
          "manipulations": [],
          "custom_properties": [],
          "generated_conversions": [],
          "responsive_images": [],
          "order_column": "1",
          "created_at": "2023-10-04T06:55:37.000000Z",
          "updated_at": "2023-10-04T06:55:37.000000Z",
          "original_url": eSvgAssets.carpenter,
          "preview_url": ""
        }
      ],
      "has_sub_categories": [
        {
          "id": 1,
          "title": "Home Furniture",
          "slug": "home-furniture",
          "description": "Home Furniture",
          "parent_id": "5",
          "meta_title": null,
          "meta_description": null,
          "commission": "1",
          "status": "1",
          "is_featured": "1",
          "category_type": "service",
          "created_by": "1",
          "created_at": "2023-10-04T05:47:42.000000Z",
          "updated_at": "2023-10-04T05:47:42.000000Z",
          "deleted_at": null,
          "media": [
            {
              "id": 1,
              "model_type": "App\\Models\\Category",
              "model_id": "9",
              "uuid": "daa7579d-02cb-43b3-9bf7-eb5f982379ae",
              "collection_name": "image",
              "name": "Carpenter",
              "file_name": "Carpenter.png",
              "mime_type": "image/png",
              "disk": "public",
              "conversions_disk": "public",
              "size": "749",
              "manipulations": [],
              "custom_properties": [],
              "generated_conversions": [],
              "responsive_images": [],
              "order_column": "1",
              "created_at": "2023-10-04T05:47:42.000000Z",
              "updated_at": "2023-10-04T05:47:42.000000Z",
              "original_url": eSvgAssets.carpenter,
              "preview_url": ""
            }
          ]
        },
        {
          "id": 2,
          "title": "Home",
          "slug": "home-furniture",
          "description": "Home Furniture",
          "parent_id": "5",
          "meta_title": null,
          "meta_description": null,
          "commission": "1",
          "status": "1",
          "is_featured": "1",
          "category_type": "service",
          "created_by": "1",
          "created_at": "2023-10-04T05:47:42.000000Z",
          "updated_at": "2023-10-04T05:47:42.000000Z",
          "deleted_at": null,
          "media": [
            {
              "id": 1,
              "model_type": "App\\Models\\Category",
              "model_id": "9",
              "uuid": "daa7579d-02cb-43b3-9bf7-eb5f982379ae",
              "collection_name": "image",
              "name": "Carpenter",
              "file_name": "Carpenter.png",
              "mime_type": "image/png",
              "disk": "public",
              "conversions_disk": "public",
              "size": "749",
              "manipulations": [],
              "custom_properties": [],
              "generated_conversions": [],
              "responsive_images": [],
              "order_column": "1",
              "created_at": "2023-10-04T05:47:42.000000Z",
              "updated_at": "2023-10-04T05:47:42.000000Z",
              "original_url": eSvgAssets.carpenter,
              "preview_url": ""
            }
          ]
        },
        {
          "id": 3,
          "title": "Home Decore",
          "slug": "home-furniture",
          "description": "Home Furniture",
          "parent_id": "5",
          "meta_title": null,
          "meta_description": null,
          "commission": "1",
          "status": "1",
          "is_featured": "1",
          "category_type": "service",
          "created_by": "1",
          "created_at": "2023-10-04T05:47:42.000000Z",
          "updated_at": "2023-10-04T05:47:42.000000Z",
          "deleted_at": null,
          "media": [
            {
              "id": 1,
              "model_type": "App\\Models\\Category",
              "model_id": "9",
              "uuid": "daa7579d-02cb-43b3-9bf7-eb5f982379ae",
              "collection_name": "image",
              "name": "Carpenter",
              "file_name": "Carpenter.png",
              "mime_type": "image/png",
              "disk": "public",
              "conversions_disk": "public",
              "size": "749",
              "manipulations": [],
              "custom_properties": [],
              "generated_conversions": [],
              "responsive_images": [],
              "order_column": "1",
              "created_at": "2023-10-04T05:47:42.000000Z",
              "updated_at": "2023-10-04T05:47:42.000000Z",
              "original_url": eSvgAssets.carpenter,
              "preview_url": ""
            }
          ]
        }
      ]
    },
  ];

  var bookingCategoriesList = [
    {"title": appFonts.acRepair, "icon": eSvgAssets.ac},
    {"title": appFonts.cleaning, "icon": eSvgAssets.cleaning},
    {"title": appFonts.carpenter, "icon": eSvgAssets.carpenter},
    {"title": appFonts.cooking, "icon": eSvgAssets.cooking},
    {"title": appFonts.electrician, "icon": eSvgAssets.electrician},
    {"title": appFonts.painter, "icon": eSvgAssets.painter},
    {"title": appFonts.plumber, "icon": eSvgAssets.plumber},
  ];

  var durationList = [
    "Hours",
    "Minutes",
  ];

  var taxList = [
    "GST(18%)",
    "VAT(20%)",
  ];

  List priceList = [
    {"title": appFonts.onlyPrice, "isSelect": false},
    {"title": appFonts.priceWithDiscount, "isSelect": true}
  ];

  var reviewList = [
    {
      "image": eImageAssets.as1,
      "name": "Kurt Bates",
      "service": "Cleaning service",
      "rate": "4.0",
      "review":
          "“I just love their service & the staff nature for work, I’d like to hire them again”",
      "time": "12 min ago",
    },
    {
      "image": eImageAssets.as1,
      "name": "Jane Cooper",
      "service": "Painting service",
      "rate": "4.0",
      "review":
          "This provider has the best staff who assist us until the service is complete. Thank you!",
      "time": "15 days ago",
    },
    {
      "image": eImageAssets.as1,
      "name": "Lorri Warf",
      "service": "Ac cleaning",
      "rate": "4.0",
      "review": "“I love their work with ease, Thank you !”",
      "time": "28 days ago",
    },
  ];

  var servicesImageList = [
    eImageAssets.servicesImage,
    eImageAssets.s1,
    eImageAssets.s2
  ];

  var reviewRating = [
    {
      "star": appFonts.star5,
      "percentage": "84",
    },
    {
      "star": appFonts.star4,
      "percentage": "9",
    },
    {
      "star": appFonts.star3,
      "percentage": "4",
    },
    {
      "star": appFonts.star2,
      "percentage": "2",
    },
    {
      "star": appFonts.star1,
      "percentage": "1",
    },
  ];

  List reviewLowHighList = [
    {"id": "0", "title": appFonts.all},
    {"id": "1", "title": appFonts.lowestRate},
    {"id": "2", "title": appFonts.highestRate}
  ];

  List categoryList = [
    {
      "icon": eSvgAssets.cleaning,
      "isCheck": false,
      "title": appFonts.cleaning,
    },
    {
      "icon": eSvgAssets.ac,
      "isCheck": false,
      "title": appFonts.acRepair,
    },
    {
      "icon": eSvgAssets.carpenter,
      "isCheck": false,
      "title": appFonts.carpenter,
    },
    {
      "icon": eSvgAssets.cooking,
      "isCheck": false,
      "title": appFonts.cooking,
    },
    {
      "icon": eSvgAssets.electrician,
      "isCheck": false,
      "title": appFonts.electrician,
    },
    {
      "icon": eSvgAssets.painter,
      "isCheck": false,
      "title": appFonts.painter,
    },
    {
      "icon": eSvgAssets.plumber,
      "isCheck": false,
      "title": appFonts.plumber,
    },
  ];

  var servicemanFilterList = [
    appFonts.category,
    appFonts.statusMember,
  ];

  var filterCategoriesList = [
    {"title": appFonts.acRepair, "icon": eSvgAssets.ac},
    {"title": appFonts.cleaning, "icon": eSvgAssets.cleaning},
    {"title": appFonts.carpenter, "icon": eSvgAssets.carpenter},
    {"title": appFonts.cooking, "icon": eSvgAssets.cooking},
    {"title": appFonts.electrician, "icon": eSvgAssets.electrician},
    {"title": appFonts.painter, "icon": eSvgAssets.painter},
    {"title": appFonts.plumber, "icon": eSvgAssets.plumber},
  ];

  var jobExperienceList = [
    appFonts.highestExperience,
    appFonts.lowestExperience,
  ];

  var languagesList = [appFonts.english, appFonts.spanish, appFonts.chines];

  var expertiseList = [
    appFonts.acRepair,
    appFonts.carpenter,
    appFonts.cleaning,
  ];

  var selectList = [
    {"image": eSvgAssets.gallery, "title": appFonts.chooseFromGallery},
    {"image": eSvgAssets.cameraFill, "title": appFonts.openCamera}
  ];

  List blogList = [
    {
      "id": 2,
      "title": "Man trimming his beard at a..",
      "slug": "man-trimming-his-beard-at-a",
      "description":
          "Many people with their very own houses worry about air conditioning repair prices, as well as wonder in case their homeowner’s insurance covers this region.",
      "content":
          "<p>Many people with their very own houses worry about air conditioning repair prices, as well as wonder in case their homeowner’s insurance covers this region.</p><p>Whether you’ve a natural disaster, fire, or another calamity, as well as your air conditioning gets destroyed or damaged along with the home, then you’re covered by your insurance.</p><p>In lots of cases where it is only the air conditioner that’s broken, or has a problem, in that case your homeowner insurance does not insure the repair costs.</p>",
      "meta_title": "Man trimming his beard at a..",
      "meta_description":
          "Many people with their very own houses worry about air conditioning repair prices, as well as wonder in case their homeowner’s insurance covers this region.",
      "is_featured": "1",
      "status": "1",
      "created_by_id": "1",
      "created_at": "23",
      "updated_at": "2023-10-07T07:01:28.000000Z",
      "deleted_at": null,
      "media": [
        {
          "id": 38,
          "model_type": "App\\Models\\Blog",
          "model_id": "2",
          "uuid": "938c2680-a24e-42c7-bb5e-b5802f9056b7",
          "collection_name": "image",
          "name": "Image (1)",
          "file_name": "Image-(1).png",
          "mime_type": "image/png",
          "disk": "public",
          "conversions_disk": "public",
          "size": "388047",
          "manipulations": [],
          "custom_properties": [],
          "generated_conversions": [],
          "responsive_images": [],
          "order_column": "1",
          "created_at": "2023-10-07T07:01:29.000000Z",
          "updated_at": "2023-10-07T07:01:29.000000Z",
          "original_url": eImageAssets.bg3,
          "preview_url": ""
        }
      ],
      "categories": [
        {
          "id": 15,
          "title": "Hair cutting",
          "slug": "hair-cutting",
          "description": "Hair cutting",
          "parent_id": null,
          "meta_title": null,
          "meta_description": null,
          "commission": null,
          "status": "1",
          "is_featured": "0",
          "category_type": "blog",
          "created_by": "1",
          "created_at": "2023-10-07T06:59:44.000000Z",
          "updated_at": "2023-10-07T06:59:44.000000Z",
          "deleted_at": null,
          "pivot": {"blog_id": "2", "category_id": "15"},
          "media": []
        }
      ],
      "created_by": {
        "id": 1,
        "name": "admin",
        "email": "admin@example.com",
        "system_reserve": "1",
        "served": null,
        "phone": null,
        "code": null,
        "provider_id": null,
        "status": "1",
        "is_featured": "0",
        "is_verified": "0",
        "type": null,
        "email_verified_at": "2023-09-08T16:55:09.000000Z",
        "fcm_token": null,
        "experience_interval": null,
        "experience_duration": null,
        "created_by": null,
        "created_at": "2023-09-08T16:55:09.000000Z",
        "updated_at": "2023-10-18T13:03:42.000000Z",
        "deleted_at": null,
        "company_name": null,
        "company_email": null,
        "company_phone": null,
        "company_code": null,
        "description": null,
        "review_ratings": null,
        "primary_address": null,
        "media": [],
        "wallet": null,
        "known_languages": [],
        "expertise": [],
        "reviews": []
      },
      "tags": [
        {
          "id": 2,
          "name": "Top rated",
          "slug": "top-rated",
          "type": "blog",
          "description": "Top rated",
          "created_by_id": "1",
          "status": 1,
          "created_at": "2023-10-07T07:00:10.000000Z",
          "updated_at": "2023-10-07T07:00:10.000000Z",
          "deleted_at": null,
          "pivot": {"blog_id": "2", "tag_id": "2"}
        }
      ]
    },
    {
      "id": 1,
      "title": "Switchboard an a electrical issue",
      "slug": "switchboard-an-a-electrical-issue",
      "description": "Wooden partition",
      "content":
          "<p>Whether you’ve a natural disaster, fire, or another calamity, as well as your air conditioning gets destroyed or damaged along with the home, then you’re covered by your insurance.<br><br>In lots of cases where it is only the air conditioner that’s broken, or has a problem, in that case your homeowner insurance does not insure the repair costs.<br><br>With regards to air conditioning repair, there’s another kind of insurance that home owners can purchase.<br><br>This insurance was advertised in the media and could be obtained on-line, or you could also ask your agent insurance agent about it.</p>",
      "meta_title": "Wooden partition",
      "meta_description":
          "Whether you’ve a natural disaster, fire, or another calamity, as well as your air conditioning gets destroyed or damaged along with the home, then you’re covered by your insurance.",
      "is_featured": "1",
      "status": "1",
      "created_by_id": "1",
      "created_at": "24",
      "updated_at": "2023-10-06T04:21:26.000000Z",
      "deleted_at": null,
      "media": [
        {
          "id": 8,
          "model_type": "App\\Models\\Blog",
          "model_id": "1",
          "uuid": "1fad52b3-f304-45c9-8541-fc4f8b686f1d",
          "collection_name": "image",
          "name": "service-provider",
          "file_name": "service-provider.png",
          "mime_type": "image/png",
          "disk": "public",
          "conversions_disk": "public",
          "size": "87619",
          "manipulations": [],
          "custom_properties": [],
          "generated_conversions": [],
          "responsive_images": [],
          "order_column": "1",
          "created_at": "2023-09-09T08:44:33.000000Z",
          "updated_at": "2023-09-09T08:44:33.000000Z",
          "original_url": eImageAssets.bg1,
          "preview_url": ""
        }
      ],
      "categories": [
        {
          "id": 2,
          "title": "Wooden partition",
          "slug": "wooden-partition",
          "description": "Wooden partition",
          "parent_id": null,
          "meta_title": null,
          "meta_description": null,
          "commission": null,
          "status": "1",
          "is_featured": "0",
          "category_type": "blog",
          "created_by": "1",
          "created_at": "2023-09-09T08:44:25.000000Z",
          "updated_at": "2023-09-09T08:44:25.000000Z",
          "deleted_at": null,
          "pivot": {"blog_id": "1", "category_id": "2"},
          "media": [
            {
              "id": 7,
              "model_type": "App\\Models\\Category",
              "model_id": "2",
              "uuid": "ee817878-b9da-4bf2-9877-a057a5232af8",
              "collection_name": "image",
              "name": "service-provider",
              "file_name": "service-provider.png",
              "mime_type": "image/png",
              "disk": "public",
              "conversions_disk": "public",
              "size": "87619",
              "manipulations": [],
              "custom_properties": [],
              "generated_conversions": [],
              "responsive_images": [],
              "order_column": "1",
              "created_at": "2023-09-09T08:44:25.000000Z",
              "updated_at": "2023-09-09T08:44:25.000000Z",
              "original_url": eImageAssets.bg2,
              "preview_url": ""
            }
          ]
        }
      ],
      "created_by": {
        "id": 1,
        "name": "admin",
        "email": "admin@example.com",
        "system_reserve": "1",
        "served": null,
        "phone": null,
        "code": null,
        "provider_id": null,
        "status": "1",
        "is_featured": "0",
        "is_verified": "0",
        "type": null,
        "email_verified_at": "2023-09-08T16:55:09.000000Z",
        "fcm_token": null,
        "experience_interval": null,
        "experience_duration": null,
        "created_by": null,
        "created_at": "2023-09-08T16:55:09.000000Z",
        "updated_at": "2023-10-18T13:03:42.000000Z",
        "deleted_at": null,
        "company_name": null,
        "company_email": null,
        "company_phone": null,
        "company_code": null,
        "description": null,
        "review_ratings": null,
        "primary_address": null,
        "media": [],
        "wallet": null,
        "known_languages": [],
        "expertise": [],
        "reviews": []
      },
      "tags": [
        {
          "id": 1,
          "name": "Wooden partition",
          "slug": "wooden-partition",
          "type": "blog",
          "description": "Wooden partition",
          "created_by_id": "1",
          "status": 1,
          "created_at": "2023-09-09T08:44:59.000000Z",
          "updated_at": "2023-09-09T08:44:59.000000Z",
          "deleted_at": null,
          "pivot": {"blog_id": "1", "tag_id": "1"}
        }
      ]
    }
  ];

  var profileList = [
    {
      "title": appFonts.companyInfo,
      "data": [
        {
          "icon": eSvgAssets.buildings,
          "title":
              isFreelancer ? appFonts.serviceLocation : appFonts.companyDetails,
          "isArrow": true
        },
        {
          "icon": eSvgAssets.bank,
          "title": appFonts.bankDetails,
          "isArrow": true
        },
        {
          "icon": eSvgAssets.identity,
          "title": appFonts.idVerification,
          "isArrow": true
        },
        {
          "icon": eSvgAssets.serviceIcon,
          "title": appFonts.services,
          "isArrow": true
        },
        {
          "icon": eSvgAssets.servicemanIcon,
          "title": appFonts.serviceman,
          "isArrow": true
        }
      ],
    },
    {
      "title": appFonts.otherDetails,
      "data": [
        {
          "icon": eSvgAssets.calender,
          "title": appFonts.timeSlots,
          "isArrow": true
        },
        {
          "icon": eSvgAssets.commission,
          "title": appFonts.commissionDetails,
          "isArrow": true
        },
        {
          "icon": eSvgAssets.gift,
          "title": appFonts.myPackages,
          "isArrow": true
        },
        {
          "icon": eSvgAssets.starOut,
          "title": appFonts.myReview,
          "isArrow": true
        },
        {
          "icon": eSvgAssets.crown,
          "title": appFonts.subscriptionPlan,
          "isArrow": true
        },
      ]
    },
    {
      "title": appFonts.alertZone,
      "data": [
        {
          "icon": eSvgAssets.delete,
          "title": appFonts.deleteAccount,
          "isArrow": false
        },
        {"icon": eSvgAssets.logout, "title": appFonts.logOut, "isArrow": false}
      ]
    },
  ];

  var profileListAsServiceman = [
    {
      "title": appFonts.companyInfo,
      "data": [
        {
          "icon": eSvgAssets.buildings,
          "title":
              isFreelancer ? appFonts.serviceLocation : appFonts.companyDetails,
          "isArrow": true
        },
        {
          "icon": eSvgAssets.bank,
          "title": appFonts.bankDetails,
          "isArrow": true
        },
        {
          "icon": eSvgAssets.identity,
          "title": appFonts.idVerification,
          "isArrow": true
        },
      ],
    },
    {
      "title": appFonts.otherDetails,
      "data": [
        {
          "icon": eSvgAssets.commission,
          "title": appFonts.commissionDetails,
          "isArrow": true
        },
        {
          "icon": eSvgAssets.starOut,
          "title": appFonts.myReview,
          "isArrow": true
        },
      ]
    },
    {
      "title": appFonts.alertZone,
      "data": [
        {
          "icon": eSvgAssets.delete,
          "title": appFonts.deleteAccount,
          "isArrow": false
        },
        {"icon": eSvgAssets.logout, "title": appFonts.logOut, "isArrow": false}
      ]
    },
  ];

  var profileListAsFreelance = [
    {
      "title": appFonts.companyInfo,
      "data": [
        {
          "icon": eSvgAssets.buildings,
          "title": appFonts.serviceLocation,
          "isArrow": true
        },
        {
          "icon": eSvgAssets.bank,
          "title": appFonts.bankDetails,
          "isArrow": true
        },
        {
          "icon": eSvgAssets.identity,
          "title": appFonts.idVerification,
          "isArrow": true
        },
        {
          "icon": eSvgAssets.serviceIcon,
          "title": appFonts.services,
          "isArrow": true
        },
        {
          "icon": eSvgAssets.gift,
          "title": appFonts.myPackages,
          "isArrow": true
        },
      ],
    },
    {
      "title": appFonts.otherDetails,
      "data": [
        {
          "icon": eSvgAssets.calender,
          "title": appFonts.timeSlots,
          "isArrow": true
        },
        {
          "icon": eSvgAssets.commission,
          "title": appFonts.commissionDetails,
          "isArrow": true
        },
        {
          "icon": eSvgAssets.starOut,
          "title": appFonts.myReview,
          "isArrow": true
        },
        {
          "icon": eSvgAssets.crown,
          "title": appFonts.subscriptionPlan,
          "isArrow": true
        }
      ]
    },
    {
      "title": appFonts.alertZone,
      "data": [
        {
          "icon": eSvgAssets.delete,
          "title": appFonts.deleteAccount,
          "isArrow": false
        },
        {"icon": eSvgAssets.logout, "title": appFonts.logOut, "isArrow": false}
      ]
    },
  ];

  //app setting
  List appSetting(isTheme) => [
        {
          'title': isTheme ? appFonts.lightTheme : appFonts.darkTheme,
          'icon': eSvgAssets.dark
        },
        {'title': appFonts.updateNotification, 'icon': eSvgAssets.notification},
        {'title': appFonts.changeCurrency, 'icon': eSvgAssets.currency},
        {'title': appFonts.changeLanguage, 'icon': eSvgAssets.translate},
        {'title': appFonts.changePassword, 'icon': eSvgAssets.lock}
      ];

  var currencyList = [
    {
      'title': appFonts.usDollar,
      'icon': eSvgAssets.usCurrency,
      "code": "USD",
      "symbol": "\$",
      'USD': 1,
      'INR': 83.24,
      'POU': 0.83,
      'EUR': 0.96,
    },
    {
      'title': appFonts.euro,
      'icon': eSvgAssets.euroCurrency,
      "code": "EUR",
      "symbol": '€',
      'USD': 1.05,
      'INR': 87.10,
      'POU': 0.87,
      'EUR': 1,
    },
    {
      'title': appFonts.inr,
      'icon': eSvgAssets.inCurrency,
      "code": "INR",
      "symbol": '₹',
      'USD': 0.012,
      'INR': 1,
      'POU': 0.010,
      'EUR': 0.011,
    },
    {
      'title': appFonts.pound,
      'icon': eSvgAssets.ukCurrency,
      "code": "POU",
      "symbol": "£",
      'USD': 1.22,
      'INR': 101.74,
      'POU': 1,
      'EUR': 1.15,
    }
  ];

  var companyDetailList = [
    {
      "icon": eSvgAssets.phone,
      "title": appFonts.phone,
      "subtitle": "+91 25623 25623"
    },
    {
      "icon": eSvgAssets.locationOut,
      "title": "2118 Thornridge Cir. Syracuse, Connecticut - 35624, USA.",
      "subtitle": ""
    },
    {
      "icon": eSvgAssets.timer,
      "title": appFonts.experience,
      "subtitle": "2 years of experience"
    },
    {
      "icon": eSvgAssets.service,
      "title": appFonts.noOfCompletedService,
      "subtitle": "234"
    },
  ];

  var serviceRangeList = [
    {
      "title": "Howthorne - Los angels,",
      "subtitle": "USA - 90250",
      "isSwitch": true,
    },
    {
      "title": "Aberdeen - Scotland",
      "subtitle": "USA - 744104",
      "isSwitch": true,
    },
    {
      "title": "Dundee - Scotland",
      "subtitle": "USA - 01382",
      "isSwitch": true,
    },
  ];

  var areaList = [
    "Bapu nagar",
    "Nikol",
    "Hiravadi",
    "Naroda",
    "Kalupur",
    "Navrangpura",
  ];

  var countryList = [
    "India",
    "UAE",
    "Australia",
    "South Africa",
    "China",
    "Russia"
  ];
  var countryObjectList = [
    {"id": 0, "title": "India"},
    {"id": 1, "title": "UAE"},
    {"id": 2, "title": "Australia"},
    {"id": 3, "title": "South Africa"},
    {"id": 4, "title": "China"},
    {"id": 5, "title": "Russia"},
  ];

  var branchList = [
    "Sarthana",
    "Adajan",
    "Hirabag",
    "Puna",
    "Saroli",
    "Mini bazar",
  ];

  var documentsList = [
    {
      "title": appFonts.drivingLicence,
      "image": eImageAssets.dl,
      "status": appFonts.requestPending
    },
    {
      "title": appFonts.panCard,
      "image": eImageAssets.panCard,
      "status": appFonts.requestForUpdate
    },
    {
      "title": appFonts.aadhaarCard,
      "image": eImageAssets.aadharCard,
      "status": appFonts.requestForUpdate
    },
    {
      "title": appFonts.votingCard,
      "image": eImageAssets.voterCard,
      "status": appFonts.requestForUpdate
    },
  ];

  var pendingDocumentList = [appFonts.passport, appFonts.bankPassbook];

  var timeSlotStartAtList = [appFonts.days, appFonts.startsAt, appFonts.endAt];

  List<TimeSlots> timeSlotList = [
    TimeSlots(day: 'MONDAY', startTime: "00:00", endTime: "00:00", status: "1"),
    TimeSlots(
        day: 'TUESDAY', startTime: "00:00", endTime: "00:00", status: "1"),
    TimeSlots(
        day: 'WEDNESDAY', startTime: "00:00", endTime: "00:00", status: "1"),
    TimeSlots(
        day: 'THURSDAY', startTime: "00:00", endTime: "00:00", status: "1"),
    TimeSlots(day: 'FRIDAY', startTime: "00:00", endTime: "00:00", status: "1"),
    TimeSlots(
        day: 'SATURDAY', startTime: "00:00", endTime: "00:00", status: "1"),
    TimeSlots(day: 'SUNDAY', startTime: "00:00", endTime: "00:00", status: "1"),
  ];

  List<TimeSlots> newTimeSlotList = [
    TimeSlots(day: 'MONDAY', startTime: "00:00", endTime: "00:00", status: "1"),
    TimeSlots(
        day: 'TUESDAY', startTime: "00:00", endTime: "00:00", status: "1"),
    TimeSlots(
        day: 'WEDNESDAY', startTime: "00:00", endTime: "00:00", status: "1"),
    TimeSlots(
        day: 'THURSDAY', startTime: "00:00", endTime: "00:00", status: "1"),
    TimeSlots(day: 'FRIDAY', startTime: "00:00", endTime: "00:00", status: "1"),
    TimeSlots(
        day: 'SATURDAY', startTime: "00:00", endTime: "00:00", status: "1"),
    TimeSlots(day: 'SUNDAY', startTime: "00:00", endTime: "00:00", status: "1"),
  ];

  List<String> hourList = List.generate(12, (index) {
    int horIndex = index + 1;
    return horIndex.toString();
  });

  List<String> minList = List.generate(60, (index) {
    int minIndex = index + 1;

    return minIndex.toString();
  });

  var amPmList = ["AM", "PM"];

  var packageList = [
    {
      "title": "Cleaning service",
      "image": eImageAssets.package,
      "price": "32.08",
      "startDate": "12 Oct, 2023",
      "expiryDate": "12 Nov, 2023",
      "serviceIncluded": "3",
      "status": true,
      "description": "This package is very usefully and very cheap",
      "disclaimer":
          "Once you buy this package then you can not cancelled this package",
      "image_list": [
        {"title": appFonts.acRepair, "icon": eImageAssets.pg1, "id": 1},
      ]
    },
    {
      "title": "Cleaning service",
      "image": eImageAssets.package,
      "price": "32.08",
      "startDate": "12 Oct, 2023",
      "expiryDate": "12 Nov, 2023",
      "serviceIncluded": "3",
      "status": true,
      "description": "This package is very usefully and very cheap",
      "disclaimer":
          "Once you buy this package then you can not cancelled this package",
      "image_list": [
        {"title": appFonts.acRepair, "icon": eImageAssets.pg1, "id": 1},
      ]
    },
    {
      "title": "Cleaning service",
      "image": eImageAssets.package,
      "price": "32.08",
      "startDate": "12 Oct, 2023",
      "expiryDate": "12 Nov, 2023",
      "serviceIncluded": "3",
      "status": true,
      "description": "This package is very usefully and very cheap",
      "disclaimer":
          "Once you buy this package then you can not cancelled this package",
      "image_list": [
        {"title": appFonts.acRepair, "icon": eImageAssets.pg1, "id": 1},
      ]
    },
  ];

  var packageDetailList = {
    "package": "Cleaning service package",
    "price": "32.08",
    "start_date": "12 Oct, 2023",
    "end_date": "12 Oct, 2023",
    "req_servicemen": "3",
    "description":
        "As a service member, I believe I am capable of problem solving. I too face a variety of obstacles at work and must develop effective solutions to ensure client satisfaction.",
    "provider": {
      "name": "Kurt Bates",
      "media": [
        {
          "originalUrl": eImageAssets.as2,
        }
      ],
      "reviewRating": "3"
    },
    "includedServices": [
      {
        "title": "Ac cleaning service",
        "price": "23.00",
        "reviewRating": "2.5",
        "duration": "30min",
        "requiredServicemen": "2",
        "description": "Foamjet tachnology removes dust 2x deeper.",
        "media": [
          {
            "originalUrl": eImageAssets.as3,
          },
        ],
      },
      {
        "title": "Bathroom cleaning",
        "price": "23.00",
        "reviewRating": "2.5",
        "duration": "30min",
        "requiredServicemen": "2",
        "description": "Get the best and most durable wooden furniture.",
        "media": [
          {
            "originalUrl": eImageAssets.as1,
          },
        ],
      },
    ]
  };

  var selectServiceList = [
    {
      "title": "Ac Service",
      "image": eImageAssets.as2,
    },
    {
      "title": "Ac Service",
      "image": eImageAssets.as2,
    },
    {
      "title": "Ac Service",
      "image": eImageAssets.as2,
    },
    {
      "title": "Ac Service",
      "image": eImageAssets.as2,
    },
    {
      "title": "Ac Service",
      "image": eImageAssets.as2,
    },
    {
      "title": "Ac Service",
      "image": eImageAssets.as2,
    },
  ];

  var serviceList = [
    {"title": appFonts.acRepair, "icon": eImageAssets.pg1, "id": 1},
    {"title": appFonts.cleaning, "icon": eImageAssets.pg2, "id": 2},
    {"title": appFonts.carpenter, "icon": eImageAssets.pg3, "id": 3},
    {"title": appFonts.cooking, "icon": eImageAssets.pg4, "id": 4},
    {"title": appFonts.electrician, "icon": eImageAssets.pg1, "id": 5},
    {"title": appFonts.painter, "icon": eImageAssets.pg2, "id": 6},
    {"title": appFonts.acRepair, "icon": eImageAssets.pg3, "id": 7},
    {"title": appFonts.cleaning, "icon": eImageAssets.pg4, "id": 8}
  ];

  var commissionHistoryList = [
    {
      "bookingId": "032",
      "date": "6 Oct, 2023",
      "amount": "50.78",
      "admin_commission": "10.17",
      "servicemen_commission": "25.39",
      "platform_fees": "15.23",
      "your_commission": "15.23"
    },
    {
      "bookingId": "032",
      "date": "6 Oct, 2023",
      "amount": "50.78",
      "admin_commission": "10.17",
      "servicemen_commission": "25.39",
      "platform_fees": "15.23",
      "your_commission": "15.23"
    },
    {
      "bookingId": "032",
      "date": "6 Oct, 2023",
      "amount": "50.78",
      "admin_commission": "10.17",
      "servicemen_commission": "25.39",
      "platform_fees": "15.23",
      "your_commission": "15.23"
    },
    {
      "bookingId": "032",
      "date": "6 Oct, 2023",
      "amount": "50.78",
      "admin_commission": "10.17",
      "servicemen_commission": "25.39",
      "platform_fees": "15.23",
      "your_commission": "15.23"
    },
    {
      "bookingId": "032",
      "date": "6 Oct, 2023",
      "amount": "50.78",
      "admin_commission": "10.17",
      "servicemen_commission": "25.39",
      "platform_fees": "15.23",
      "your_commission": "15.23"
    },
  ];

  var bookingDetailsList = {
    "package": "Cleaning service package",
    "booking_id": "032",
    "date": "12 Oct, 2023",
    "address": "2118 Thorn ridge Cir. Syracuse, Connecticut - 35624, USA.",
    "time": "6:00 PM",
    "description":
        "Our expert technicians will thoroughly clean and disinfect your air conditioning system, ensuring optimal performance.",
    "customerDetails": {
      "title": "Zain Dorwart",
      "email": "kurtbsted56@gmail.com",
      "phone": "+25 632 256 4562",
      "location": "3891 Ranchview Dr. Richardson, California - 62639, USA.",
      "media": [
        {"originalUrl": eImageAssets.as1}
      ]
    },
    "serviceMenDetails": [
      {
        "name": "Kurt Bates",
        "media": [
          {"originalUrl": eImageAssets.as1}
        ]
      },
      {
        "name": "Dr. Bonnie Barstow",
        "media": [
          {"originalUrl": eImageAssets.as1}
        ]
      },
    ],
    "commission_history": {
      "total_received_amount": "50.78",
      "admin_commission": "10.70",
      "servicemen_commission": "25.39",
      "platform_fees": "15.23",
      "your_commission": "15.23",
    }
  };

  var benefits = [
    "service",
    "servicemen",
    "serviceLocation",
    "packages",
  ];

  List planList(isMonth) => [
        {
          "price": "15",
          "type": isMonth ? "month" : "year",
          "plan_type": "Standard plan",
          "benefits": [
            "Add up to 10 service",
            "Add up to 10 servicemen",
            "Add up to 6 service location",
            "Add up to 6 service in packages",
          ]
        },
        {
          "price": "10",
          "type": isMonth ? "month" : "year",
          "plan_type": "Regular plan",
          "benefits": [
            "Add up to 8 service",
            "Add up to 8 servicemen",
            "Add up to 4 service location",
            "Add up to 4 service in packages",
          ]
        },
        {
          "price": "25",
          "type": isMonth ? "month" : "year",
          "plan_type": "Premium plan",
          "benefits": [
            "Add up to 12 service",
            "Add up to 12 servicemen",
            "Add up to 8 service location",
            "Add up to 4 service in packages",
          ]
        },
      ];

  var commissionInfoList = [
    {
      "title": "Ac Repair",
      "commission": "30",
      "media": [
        {"original_url": eSvgAssets.ac}
      ]
    },
    {
      "title": "Cleaning",
      "commission": "20",
      "media": [
        {"original_url": eSvgAssets.cleaning}
      ]
    },
    {
      "title": "Carpenter",
      "commission": "10",
      "media": [
        {"original_url": eSvgAssets.carpenter}
      ]
    },
    {
      "title": "Cooking",
      "commission": "15",
      "media": [
        {"original_url": eSvgAssets.cooking}
      ]
    },
    {
      "title": "Plumber",
      "commission": "5",
      "media": [
        {"original_url": eSvgAssets.plumber}
      ]
    },
    {
      "title": "Salon",
      "commission": "4",
      "media": [
        {"original_url": eSvgAssets.salon}
      ]
    },
  ];

  var commissionDetailList = [
    {"title": "Installation", "commission": "8"},
    {"title": "Hanging", "commission": "5"},
    {"title": "Servicing", "commission": "4"},
    {"title": "Platform Fees", "commission": "2"},
    {"title": "Window Cleaning", "commission": "8"},
  ];

  var subscriptionPlanList = {
    "title": appFonts.try7Days,
    "subtext": appFonts.getFreeTrial,
    "benefits": [
      appFonts.addUpTo3Service,
      appFonts.addUpTo3Servicemen,
      appFonts.addUpTo3ServiceLocation,
      appFonts.addUpTo3ServicePackages
    ]
  };

  var paymentHistoryList = [
    {
      "title": "Chimney sweeping",
      "booking_id": "032",
      "price": "21.78",
      "payment_id": "1368",
      "method_type": "Cash",
      "status": "Paid",
      "customer": {
        "image": eImageAssets.es,
        "title": "Giana Francie",
      }
    },
    {
      "title": "Chimney sweeping",
      "booking_id": "032",
      "price": "21.78",
      "payment_id": "1368",
      "method_type": "Cash",
      "status": "Advance paid",
      "customer": {
        "image": eImageAssets.es,
        "title": "Giana Francie",
      }
    },
    {
      "title": "Chimney sweeping",
      "booking_id": "032",
      "price": "21.78",
      "payment_id": "1368",
      "method_type": "Cash",
      "status": "Paid",
      "customer": {"image": eImageAssets.es, "title": "Giana Francie"}
    },
    {
      "title": "Chimney sweeping",
      "booking_id": "032",
      "price": "21.78",
      "payment_id": "1368",
      "method_type": "Cash",
      "status": "Paid",
      "customer": {
        "image": eImageAssets.es,
        "title": "Giana Francie",
      }
    }
  ];

  var paymentGatewayList = [
    {
      "id": 0,
      "image": eSvgAssets.razorpay,
      "title": appFonts.razorpay,
    },
    {
      "id": 1,
      "image": eSvgAssets.stripe,
      "title": appFonts.stripe,
    }
  ];

  var bookingList = [
    {
      "bookingNumber": "#58961",
      "image": eImageAssets.b1,
      "package_id": null,
      "isExpand": false,
      "required_servicemen": 2,
      "name": "Cleaning of bathroom",
      "price": "25.23",
      "offer": "10% off",
      "status": appFonts.pending,
      "assign_me": "No",
      "dateTime": "6 Sep, 2023 - 6:00 pm",
      "payment": "Not paid yet",
      "location": "California - USA",
      "customerList": [
        {
          "image": eImageAssets.c1,
          "title": "Arlene McCoy",
          "rate": "3.5",
        }
      ],
      "servicemanLists": []
    },
    {
      "bookingNumber": "#58961",
      "image": eImageAssets.b1,
      "package_id": null,
      "isExpand": false,
      "required_servicemen": 1,
      "name": "Cleaning of bathroom",
      "price": "25.23",
      "offer": "10% off",
      "status": appFonts.pending,
      "assign_me": "No",
      "dateTime": "6 Sep, 2023 - 6:00 pm",
      "payment": "Not paid yet",
      "location": "California - USA",
      "customerList": [
        {
          "image": eImageAssets.c2,
          "title": "Arlene McCoy",
          "rate": "3.5",
        }
      ],
      "servicemanLists": [
        {
          "image": eImageAssets.c3,
          "title": "Kate Tanner",
          "rate": "4.0",
        }
      ]
    },
    {
      "bookingNumber": "#58961",
      "image": eImageAssets.b2,
      "package_id": "122",
      "isExpand": false,
      "required_servicemen": 3,
      "name": "House hold cook",
      "price": "25.23",
      "offer": "10% off",
      "status": appFonts.pendingApproval,
      "assign_me": "No",
      "dateTime": "6 Sep, 2023 - 6:00 pm",
      "payment": "Not paid yet",
      "location": "California - USA",
      "customerList": [
        {
          "image": eImageAssets.c4,
          "title": "Arlene McCoy",
          "rate": "3.5",
        }
      ],
      "servicemanLists": [
        {
          "image": eImageAssets.c5,
          "title": "Kate Tanner",
          "rate": "4.0",
        }
      ]
    },
    {
      "bookingNumber": "#25636",
      "image": eImageAssets.b3,
      "package_id": null,
      "isExpand": false,
      "required_servicemen": 2,
      "name": "Full body massage",
      "price": "30.25",
      "offer": "10% off",
      "status": appFonts.accepted,
      "assign_me": "No",
      "dateTime": "8 Aug, 2023 - 5:20 am",
      "location": "California - USA",
      "payment": "Not paid yet",
      "customerList": [
        {
          "image": eImageAssets.c6,
          "title": "Kierra Lubin",
          "rate": "3.0",
        }
      ],
      "servicemanLists": [
        {
          "image": eImageAssets.c7,
          "title": "Kate Tanner",
          "rate": "4.0",
        }
      ]
    },
    {
      "bookingNumber": "#25636",
      "image": eImageAssets.b3,
      "package_id": null,
      "isExpand": false,
      "required_servicemen": 2,
      "name": "Full body massage",
      "price": "30.25",
      "offer": "10% off",
      "status": appFonts.accepted,
      "assign_me": "Yes",
      "dateTime": "8 Aug, 2023 - 5:20 am",
      "location": "California - USA",
      "payment": "Not paid yet",
      "customerList": [
        {
          "image": eImageAssets.c3,
          "title": "Kierra Lubin",
          "rate": "3.0",
        }
      ],
      "servicemanLists": []
    },
    {
      "bookingNumber": "#85962",
      "image": eImageAssets.b5,
      "package_id": null,
      "isExpand": false,
      "required_servicemen": 1,
      "name": "Hair spa & color",
      "price": "15.23",
      "offer": "15% off",
      "status": appFonts.ongoing,
      "assign_me": "No",
      "dateTime": "10 Aug, 2023 - 2:05 pm",
      "location": "California - USA",
      "payment": "Not paid yet",
      "customerList": [
        {
          "image": eImageAssets.c8,
          "title": "Kierra Lubin",
          "rate": "3.0",
        }
      ],
      "servicemanLists": [
        {
          "image": eImageAssets.c9,
          "title": "Nolan Westervelt",
          "rate": "3.5",
        },
        {
          "image": eImageAssets.c10,
          "title": "Kate Tanner",
          "rate": "3.5",
        },
      ]
    },
    {
      "bookingNumber": "#85962",
      "image": eImageAssets.b5,
      "package_id": null,
      "isExpand": false,
      "required_servicemen": 1,
      "name": "Hair spa & color",
      "price": "15.23",
      "offer": "15% off",
      "status": appFonts.ongoing,
      "assign_me": "Yes",
      "dateTime": "10 Aug, 2023 - 2:05 pm",
      "location": "California - USA",
      "payment": "Not paid yet",
      "customerList": [
        {
          "image": eImageAssets.c11,
          "title": "Kierra Lubin",
          "rate": "3.0",
        }
      ],
      "servicemanLists": []
    },
    {
      "bookingNumber": "#56236",
      "image": eImageAssets.b7,
      "package_id": null,
      "isExpand": false,
      "required_servicemen": 2,
      "name": "Furnishing & carpentry",
      "price": "40.26",
      "offer": "12% off",
      "status": appFonts.completed,
      "assign_me": "No",
      "dateTime": "15 Aug, 2023 - 10:55 am",
      "payment": "Paid in advance",
      "location": "California - USA",
      "customerList": [
        {
          "image": eImageAssets.c2,
          "title": "Kierra Lubin",
          "rate": "3.0",
        }
      ],
      "servicemanLists": [
        {
          "image": eImageAssets.c3,
          "title": "Nolan Westervelt",
          "rate": "3.5",
        },
        {
          "image": eImageAssets.as1,
          "title": "Kate Tanner",
          "rate": "3.5",
        },
      ]
    },
    {
      "bookingNumber": "#15263",
      "image": eImageAssets.b8,
      "package_id": null,
      "required_servicemen": 3,
      "isExpand": false,
      "name": "Chimney sweeping",
      "price": "21.78",
      "status": appFonts.cancelled,
      "assign_me": "No",
      "location": "California - USA",
      "dateTime": "20 Aug, 2023 - 4:25pm",
      "customerList": [
        {
          "image": eImageAssets.c5,
          "title": "Kierra Lubin",
          "rate": "3.0",
        }
      ],
      "servicemanLists": []
    },
    {
      "bookingNumber": "#15263",
      "image": eImageAssets.b6,
      "package_id": null,
      "isExpand": false,
      "required_servicemen": 1,
      "name": "Cloth washing service",
      "price": "21.78",
      "status": appFonts.hold,
      "assign_me": "No",
      "payment": "Paid",
      "location": "California - USA",
      "dateTime": "20 Aug, 2023 - 4:25pm",
      "customerList": [
        {
          "image": eImageAssets.c8,
          "title": "Kierra Lubin",
          "rate": "3.0",
        }
      ],
      "servicemanLists": [
        {
          "image": eImageAssets.c9,
          "title": "Kierra Lubin",
          "rate": "3.0",
        }
      ]
    },
    {
      "bookingNumber": "#15263",
      "image": eImageAssets.b4,
      "package_id": null,
      "isExpand": false,
      "required_servicemen": 2,
      "name": "Security guard",
      "price": "21.78",
      "status": appFonts.assigned,
      "assign_me": "No",
      "payment": "Paid in advance",
      "dateTime": "20 Aug, 2023 - 4:25pm",
      "location": "California - USA",
      "customerList": [
        {
          "image": eImageAssets.c10,
          "title": "Kierra Lubin",
          "rate": "3.0",
        }
      ],
      "servicemanLists": [
        {
          "image": eImageAssets.c11,
          "title": "Kierra Lubin",
          "rate": "3.0",
        }
      ]
    },
    {
      "bookingNumber": "#15263",
      "image": eImageAssets.b4,
      "package_id": null,
      "required_servicemen": 2,
      "isExpand": false,
      "name": "Security guard",
      "price": "21.78",
      "status": appFonts.assigned,
      "assign_me": "Yes",
      "payment": "Paid in advance",
      "dateTime": "20 Aug, 2023 - 4:25pm",
      "location": "California - USA",
      "customerList": [
        {
          "image": eImageAssets.c10,
          "title": "Kierra Lubin",
          "rate": "3.0",
        }
      ],
      "servicemanLists": []
    },
  ];

  var bookingFilterList = [
    appFonts.status,
    appFonts.date,
    appFonts.category,
  ];

  var bookingStatusList = [
    "All booking",
    'Pending booking',
    "Accepted booking",
    "Assigned booking",
    "Servicemen’s pending approval booking",
    "Ongoing booking",
    "Hold booking",
  ];

  var bookingStatus = [
    {
      "status": "s",
      "time": "2:30 am",
      "date": "Today",
      "title": "Changes in schedule",
      "subtext": "You have change time for service."
    },
    {
      "status": "s",
      "time": "2:30 am",
      "date": "Today",
      "title": "Changes in schedule",
      "subtext": "You have change time for service."
    },
    {
      "status": appFonts.ongoing,
      "time": "2:30 am",
      "date": "Today",
      "title": "Changes in schedule",
      "subtext": "You have change time for service."
    },
    {
      "status": appFonts.accepted,
      "time": "2:30 am",
      "date": "Today",
      "title": "Changes in schedule",
      "subtext": "You have change time for service."
    },
    {
      "status": appFonts.pending,
      "time": "2:30 am",
      "date": "Today",
      "title": "Changes in schedule",
      "subtext": "You have change time for service."
    },
  ];

  var pendingBookingDetailList = {
    "image": eImageAssets.b1,
    "status": "Pending",
    "assign_me": "No",
    "package_id": null,
    "bookingId": "#85962",
    "title": "Cleaning of bathroom",
    "rate": "3.5",
    "date": "6 Sep, 2023",
    "time": "6:00 PM",
    "location": "2118 Thorn ridge Cir. Syracuse, Connecticut - 35624, USA.",
    "description":
        "Our expert technicians will thoroughly clean and disinfect your air conditioning system, ensuring optimal performance.",
    "customer": {
      "image": eImageAssets.c2,
      "title": "Kierra Lubin",
    },
    "servicemanList": [],
  };

  var pendingBookingDetailWithList = {
    "image": eImageAssets.b1,
    "status": "Pending",
    "assign_me": "Yes",
    "package_id": null,
    "bookingId": "#85962",
    "title": "Cleaning of bathroom",
    "rate": "3.5",
    "date": "6 Sep, 2023",
    "time": "6:00 PM",
    "location": "2118 Thorn ridge Cir. Syracuse, Connecticut - 35624, USA.",
    "description":
        "Our expert technicians will thoroughly clean and disinfect your air conditioning system, ensuring optimal performance.",
    "customer": {
      "image": eImageAssets.c1,
      "title": "Kierra Lubin",
    },
    "servicemanList": [
      {
        "image": eImageAssets.c2,
        "title": "Kierra Lubing",
        "rate": 3.5,
      }
    ],
  };

  var acceptBookingDetailList = {
    "image": eImageAssets.b3,
    "status": "Accepted",
    "assign_me": "Yes",
    "package_id": null,
    "bookingId": "#85962",
    "title": "Full body massage",
    "rate": "3.5",
    "date": "6 Sep, 2023",
    'required_servicemen': 3,
    "time": "6:00 PM",
    "location": "2118 Thorn ridge Cir. Syracuse, Connecticut - 35624, USA.",
    "description":
        "Our expert technicians will thoroughly clean and disinfect your air conditioning system, ensuring optimal performance.",
    "customer": {"image": eImageAssets.c4, "title": "Kierra Lubin"},
    "servicemanList": []
  };

  var acceptBookingDetailWithList = {
    "image": eImageAssets.b3,
    "status": "Accepted",
    "assign_me": "No",
    "package_id": null,
    "bookingId": "#85962",
    "title": "Full body massage",
    "rate": "3.5",
    "date": "6 Sep, 2023",
    'required_servicemen': 3,
    "time": "6:00 PM",
    "location": "2118 Thorn ridge Cir. Syracuse, Connecticut - 35624, USA.",
    "description":
        "Our expert technicians will thoroughly clean and disinfect your air conditioning system, ensuring optimal performance.",
    "customer": {"image": eImageAssets.c5, "title": "Kierra Lubin"},
    "servicemanList": []
  };

  var selectServicemenList = [appFonts.assignToMe, appFonts.assignToOther];

  var ratingList = [
    {
      "rate": "5 rate",
      "icon": eSvgAssets.star5,
    },
    {
      "rate": "4 rate",
      "icon": eSvgAssets.star4,
    },
    {
      "rate": "3 rate",
      "icon": eSvgAssets.star3,
    },
    {
      "rate": "2 rate",
      "icon": eSvgAssets.star2,
    },
    {
      "rate": "1 rate",
      "icon": eSvgAssets.star1,
    },
  ];

  var chatList = [
    {
      "type": "receiver",
      "message": "Hello ! How can i help you ?",
    },
    {
      "type": "source",
      "message": "Hello ! When will you arrive ?",
    },
    {
      "type": "receiver",
      "message": "I’ll be there soon.",
    },
    {
      "type": "source",
      "message": "Okay !! Thank you.",
    }
  ];

  var optionList = [appFonts.call, appFonts.clearChat];

  var assignBookingDetailList = {
    "image": eImageAssets.b4,
    "status": "Assigned",
    "assign_me": "Yes",
    "package_id": null,
    "bookingId": "#85962",
    "title": "Security guard",
    "rate": "3.5",
    "date": "6 Sep, 2023",
    "time": "6:00 PM",
    "location": "2118 Thorn ridge Cir. Syracuse, Connecticut - 35624, USA.",
    "description":
        "Our expert technicians will thoroughly clean and disinfect your air conditioning system, ensuring optimal performance.",
    "customer": {"image": eImageAssets.c7, "title": "Kierra Lubing"},
    "servicemanList": []
  };

  var assignBookingDetailWithList = {
    "image": eImageAssets.b4,
    "status": "Assigned",
    "assign_me": "No",
    "package_id": null,
    "bookingId": "#85962",
    "title": "Security guard",
    "rate": "3.5",
    "date": "6 Sep, 2023",
    "time": "6:00 PM",
    "location": "2118 Thorn ridge Cir. Syracuse, Connecticut - 35624, USA.",
    "description":
        "Our expert technicians will thoroughly clean and disinfect your air conditioning system, ensuring optimal performance.",
    "customer": {"image": eImageAssets.c7, "title": "Kierra Lubing"},
    "servicemanList": [
      {
        "image": eImageAssets.c3,
        "title": "Kierra Lubing",
        "rate": 3.5,
      }
    ]
  };

  var pendingApprovalBookingList = {
    "image": eImageAssets.b2,
    "status": "Pending approval",
    "assign_me": "No",
    "bookingId": "#85962",
    "package_id": "122",
    "title": "House hold cook",
    "rate": "3.5",
    "date": "6 Sep, 2023",
    "time": "6:00 PM",
    "location": "2118 Thorn ridge Cir. Syracuse, Connecticut - 35624, USA.",
    "description":
        "Our expert technicians will thoroughly clean and disinfect your air conditioning system, ensuring optimal performance.",
    "customer": {"image": eImageAssets.c8, "title": "Kierra Lubin"},
    "servicemanList": [
      {
        "image": eImageAssets.c9,
        "title": "Kierra Lubin",
        "rate": 3.5,
      }
    ]
  };

  var ongoingBookingList = {
    "image": eImageAssets.b5,
    "status": "Ongoing",
    "assign_me": "No",
    "bookingId": "#85962",
    "package_id": null,
    "title": "Hair spa & color",
    "rate": "3.5",
    "date": "6 Sep, 2023",
    "time": "6:00 PM",
    "location": "2118 Thorn ridge Cir. Syracuse, Connecticut - 35624, USA.",
    "description":
        "Our expert technicians will thoroughly clean and disinfect your air conditioning system, ensuring optimal performance.",
    "customer": {"image": eImageAssets.c10, "title": "Kierra Lubin"},
    "servicemanList": [
      {
        "image": eImageAssets.c11,
        "title": "Kierra Lubin",
        "rate": 2.5,
      }
    ]
  };

  var ongoingBookingWithList = {
    "image": eImageAssets.b5,
    "status": "Ongoing",
    "assign_me": "Yes",
    "bookingId": "#85962",
    "package_id": null,
    "title": "Hair spa & color",
    "rate": "3.5",
    "date": "6 Sep, 2023",
    "time": "6:00 PM",
    "location": "2118 Thorn ridge Cir. Syracuse, Connecticut - 35624, USA.",
    "description":
        "Our expert technicians will thoroughly clean and disinfect your air conditioning system, ensuring optimal performance.",
    "customer": {"image": eImageAssets.c10, "title": "Kierra Lubin"},
    "servicemanList": []
  };

  var holdBookingList = {
    "image": eImageAssets.b6,
    "status": "Hold",
    "assign_me": "No",
    "bookingId": "#85962",
    "package_id": null,
    "title": "Cloth washing service",
    "rate": "3.5",
    "date": "6 Sep, 2023",
    "time": "6:00 PM",
    "location": "2118 Thorn ridge Cir. Syracuse, Connecticut - 35624, USA.",
    "description":
        "Our expert technicians will thoroughly clean and disinfect your air conditioning system, ensuring optimal performance.",
    "customer": {"image": eImageAssets.c1, "title": "Kierra Lubin"},
    "servicemanList": [
      {
        "image": eImageAssets.c2,
        "title": "Kierra Lubin",
        "rate": 1.5,
      }
    ]
  };

  var completedBookingList = {
    "image": eImageAssets.b7,
    "status": "Completed",
    "assign_me": "No",
    "bookingId": "#85962",
    "package_id": null,
    "title": "Furnishing & carpentry",
    "rate": "3.5",
    "date": "6 Sep, 2023",
    "time": "6:00 PM",
    "location": "2118 Thorn ridge Cir. Syracuse, Connecticut - 35624, USA.",
    "description":
        "Our expert technicians will thoroughly clean and disinfect your air conditioning system, ensuring optimal performance.",
    "customer": {
      "title": "Zain Dorwart",
      "email": "kurtbsted56@gmail.com",
      "phone": "+25 632 256 4562",
      "location": "3891 Ranchview Dr. Richardson, California - 62639, USA.",
      "media": [
        {"originalUrl": eImageAssets.c2}
      ]
    },
    "servicemanList": [
      {
        "image": eImageAssets.c8,
        "title": "Kierra Lubin",
        "rate": 5.0,
      }
    ]
  };

  var cancelledBookingList = {
    "image": eImageAssets.b8,
    "status": "Cancelled",
    "assign_me": "No",
    "bookingId": "#85962",
    "package_id": null,
    "title": "Chimney sweeping",
    "rate": "3.5",
    "date": "6 Sep, 2023",
    "time": "6:00 PM",
    "location": "2118 Thorn ridge Cir. Syracuse, Connecticut - 35624, USA.",
    "description":
        "Our expert technicians will thoroughly clean and disinfect your air conditioning system, ensuring optimal performance.",
    "customer": {
      "title": "Zain Dorwart",
      "email": "kurtbsted56@gmail.com",
      "phone": "+25 632 256 4562",
      "location": "3891 Ranchview Dr. Richardson, California - 62639, USA.",
      "media": [
        {"originalUrl": eImageAssets.c5}
      ]
    },
    "servicemanList": []
  };

  var chatHistoryList = [
    {
      "image": eImageAssets.as3,
      "title": "Arlene McCoy",
      "message": "Hello",
      "time": "2:30 pm"
    },
    {
      "image": eImageAssets.as2,
      "title": "Arlene McCoy",
      "message": "Hello",
      "time": "2:30 pm"
    },
    {
      "image": eImageAssets.as1,
      "title": "Arlene McCoy",
      "message": "Hello",
      "time": "2:30 pm"
    },
    {
      "image": eImageAssets.as4,
      "title": "Arlene McCoy",
      "message": "Hello",
      "time": "2:30 pm"
    },
    {
      "image": eImageAssets.as2,
      "title": "Arlene McCoy",
      "message": "Hello",
      "time": "2:30 pm"
    },
    {
      "image": eImageAssets.as4,
      "title": "Arlene McCoy",
      "message": "Hello",
      "time": "2:30 pm"
    },
    {
      "image": eImageAssets.as1,
      "title": "Arlene McCoy",
      "message": "Hello",
      "time": "2:30 pm"
    },
    {
      "image": eImageAssets.as3,
      "title": "Arlene McCoy",
      "message": "Hello",
      "time": "2:30 pm"
    },
  ];

  var chatHistoryOptionList = [appFonts.refresh, appFonts.clearChat];

  var dashBoardList = [
    {
      "image": eSvgAssets.colorFilter,
      "title": appFonts.addNewService,
    },
    {
      "image": eSvgAssets.userTagFill,
      "title": appFonts.addNewServicemen,
    },
  ];

  var freelancerBookingList = [
    {
      "bookingNumber": "#58961",
      "image": eImageAssets.b1,
      "package_id": null,
      "required_servicemen": 2,
      "isExpand": false,
      "name": "Cleaning of bathroom",
      "price": "25.23",
      "offer": "10% off",
      "status": appFonts.pending,
      "dateTime": "6 Sep, 2023 - 6:00 pm",
      "payment": "Not paid yet",
      "location": "California - USA",
      "customerList": [
        {
          "image": eImageAssets.c1,
          "title": "Arlene McCoy",
          "rate": "3.5",
        }
      ],
      "servicemanLists": []
    },
    {
      "bookingNumber": "#25636",
      "image": eImageAssets.b2,
      "package_id": null,
      "isExpand": false,
      "required_servicemen": 2,
      "name": "Full body massage",
      "price": "30.25",
      "offer": "10% off",
      "status": appFonts.accepted,
      "location": "California - USA",
      "dateTime": "8 Aug, 2023 - 5:20 am",
      "payment": "Not paid yet",
      "customerList": [
        {
          "image": eImageAssets.c4,
          "title": "Kierra Lubin",
          "rate": "3.0",
        }
      ],
      "servicemanLists": []
    },
    {
      "bookingNumber": "#85962",
      "image": eImageAssets.b5,
      "package_id": null,
      "isExpand": false,
      "name": "Hair spa & color",
      "price": "15.23",
      "offer": "15% off",
      "required_servicemen": 2,
      "status": appFonts.ongoing,
      "location": "California - USA",
      "dateTime": "10 Aug, 2023 - 2:05 pm",
      "payment": "Not paid yet",
      "customerList": [
        {
          "image": eImageAssets.c7,
          "title": "Kierra Lubin",
          "rate": "3.0",
        }
      ],
      "servicemanLists": []
    },
    {
      "bookingNumber": "#56236",
      "image": eImageAssets.b7,
      "package_id": null,
      "isExpand": false,
      "required_servicemen": 2,
      "name": "Furnishing & carpentry",
      "price": "40.26",
      "offer": "12% off",
      "status": appFonts.completed,
      "location": "California - USA",
      "dateTime": "15 Aug, 2023 - 10:55 am",
      "payment": "Paid in advance",
      "customerList": [
        {
          "image": eImageAssets.c10,
          "title": "Kierra Lubin",
          "rate": "3.0",
        }
      ],
      "servicemanLists": []
    },
    {
      "bookingNumber": "#15263",
      "image": eImageAssets.b8,
      "package_id": null,
      "isExpand": false,
      "required_servicemen": 2,
      "name": "Chimney sweeping",
      "price": "21.78",
      "status": appFonts.cancelled,
      "location": "California - USA",
      "dateTime": "20 Aug, 2023 - 4:25pm",
      "customerList": [
        {
          "image": eImageAssets.c11,
          "title": "Kierra Lubin",
          "rate": "3.0",
        }
      ],
      "servicemanLists": []
    },
  ];

  List<XFile> serviceImageList = [];

  List<XFile> servicemanDocImageList = [];

  var servicemenExperienceList = [
    appFonts.allServicemen,
    appFonts.highestExperience,
    appFonts.lowestExperience,
    appFonts.highestServed,
    appFonts.lowestServed
  ];

  var data = [
    {
      "title": "roles",
      "isCheck": false,
      "permissionList": {
        "isIndex": false,
        "isCreate": false,
        "isEdit": false,
        "isDelete": false
      }
    },
    {
      "title": "users",
      "isCheck": false,
      "permissionList": {
        "isIndex": false,
        "isCreate": false,
        "isEdit": false,
        "isDelete": false
      }
    }
  ];

  List<ChartData> weekData = [
    /*  ChartData('M', 12),
    ChartData('T', 15),
    ChartData('W', 30),
    ChartData('TH', 6.4),
    ChartData('F', 14),
    ChartData('S', 7),
    ChartData('S', 9),*/
  ];

  List<ChartData> monthData = [
    /* ChartData('Ja', 12),
    ChartData('Fe', 15),
    ChartData('Ma', 30),
    ChartData('Ap', 6.4),
    ChartData('May', 14),
    ChartData('Ju', 7),
    ChartData('Jl', 16),
    ChartData('Au', 19),
    ChartData('Se', 10),
    ChartData('Oc', 15),
    ChartData('No', 10),
    ChartData('De', 9),*/
  ];

  List<ChartData> yearData = [
    /* ChartData('2016', 12),
    ChartData('2017', 15),
    ChartData('2018', 30),
    ChartData('2019', 6.4),
    ChartData('2020', 14),
    ChartData('2021', 7),
    ChartData('2022', 16),
    ChartData('2023', 19),
    ChartData('Se', 10),
    ChartData('2024', 15)*/
  ];

  List<ChartDataColor> earningChartData = [];

  List serviceType = [
    {"title": appFonts.userSite, "val": "fixed"},
    {"title": appFonts.providerSite, "val": "provider_site"},
    {"title": appFonts.remotely, "val": "remotely"}
  ];
}
