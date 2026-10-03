// import 'dart:async';
// import 'dart:developer';
// // import 'package:blue_thermal_printer/blue_thermal_printer.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
// import 'package:permission_handler/permission_handler.dart';
// // import 'package:permission_handler/permission_handler.dart';
// import 'package:provider/provider.dart';
// import 'package:bus_ticket_register/common/color_palette.dart';
// import 'package:bus_ticket_register/common/common_button.dart';
// import 'package:bus_ticket_register/common/common_functions.dart';
// import 'package:bus_ticket_register/common/extension.dart';
// import 'package:bus_ticket_register/common/select_card.dart';
// import 'package:bus_ticket_register/providers/billing_provider.dart';
// import 'package:bus_ticket_register/providers/home_provider.dart';
// // import 'package:bus_ticket_register/screens/home/quick_bill.dart';
// import 'package:bus_ticket_register/screens/login/login.dart';
// import 'package:bus_ticket_register/services/app_config.dart';
// import 'package:bus_ticket_register/services/helpers.dart';
// import 'package:bus_ticket_register/services/provider_helper_class.dart';
// import 'package:bus_ticket_register/services/shared_preference_helper.dart';
// import 'package:bus_ticket_register/widgets/print_service.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:url_launcher/url_launcher.dart';

// class Home extends StatefulWidget {
//   const Home({super.key});
//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   List<String> titleCards = [
//     "Billing",
//     "Bill List",
//     'Pooja Summary',
//     'Counter Wise Summary',
//   ];
//   // BlueThermalPrinter printer = BlueThermalPrinter.instance;
//   // List<BluetoothDevice> devices = [];
//   // BluetoothDevice? selectedDevice;

//   final _drawerController = ZoomDrawerController();
//   @override
//   void initState() {
//     // devices.clear();
//     // WidgetsBinding.instance.addPostFrameCallback((_) => _getDevices());
//     final home = context.read<BillingProvider>();
//     home.version?.data![0].androidVersion != AppConfig.version
//         ? null
//         : getCounterID();
//     _init();
//     super.initState();
//   }

//   String status = 'Starting...';

//   Future<void> _init() async {
//     // 1. Request permissions
//     setState(() => status = 'Requesting permissions...');
//     await [
//       Permission.bluetooth,
//       Permission.bluetoothConnect,
//       Permission.bluetoothScan,
//       Permission.locationWhenInUse,
//     ].request();

//     // 2. Auto-connect to InnerPrinter
//     setState(() => status = 'Connecting to InnerPrinter...');
//     final connected = await PrinterService.autoConnect();

//     setState(
//       () => status = connected
//           ? '✅ Printer connected!'
//           : '⚠️ InnerPrinter not found.\nMake sure it is paired in Bluetooth settings.',
//     );
//   }

//   Future<Uint8List> assetImageToUint8List(String assetPath) async {
//     ByteData data = await rootBundle.load(assetPath);
//     return data.buffer.asUint8List();
//   }

//   // Future<void> _getDevices() async {
//   //   bool? connect = await printer.isConnected;
//   //   if (connect == true) {
//   //     await printer.disconnect();
//   //   }

//   //   List<BluetoothDevice> devicesList = await printer.getBondedDevices();

//   //   setState(() {
//   //     devices = devicesList;
//   //   });
//   //   await _connectToPrinter();
//   //   bool? conect = await printer.isConnected;
//   //   if (conect == true) {
//   //     Helpers.successToast("Bluetooth device connected successfully");
//   //   } else {
//   //     Helpers.successToast("Please check printer is available");
//   //   }
//   // }

//   // Future<void> _connectToPrinter() async {
//   //   selectedDevice = devices.firstWhere(
//   //     (device) => device.name == 'CN811-UB',
//   //     orElse: () => BluetoothDevice('not found', ''),
//   //   );
//   //   if (selectedDevice?.name == 'CN811-UB') {
//   //     await printer.connect(selectedDevice!);

//   //     Helpers.successToast("Bluetooth device connected successfully");
//   //   }
//   // }
//   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<BillingProvider>(
//       builder: (context, home, child) => Scaffold(
//         bottomSheet: home.version?.data![0].androidVersion != AppConfig.version
//             ? BottomSheet(
//                 onClosing: () {},
//                 builder: (BuildContext context) {
//                   return Container(
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         boxShadow: [
//                           BoxShadow(
//                               color: Colors.grey,
//                               blurRadius: 20.r,
//                               offset: const Offset(0, 5))
//                         ],
//                       ),
//                       height: 320.h,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Column(
//                             children: [
//                               Row(
//                                 children: [
//                                   SizedBox(
//                                       height: 25.h,
//                                       width: 25.w,
//                                       child: SvgPicture.asset(
//                                         "assets/image/google_play.svg",
//                                         fit: BoxFit.contain,
//                                       )),
//                                   8.horizontalSpace,
//                                   Text(
//                                     "Google Play",
//                                     style: TextStyle(
//                                         color: Colors.blueGrey,
//                                         fontSize: 14.sp,
//                                         fontWeight: FontWeight.w500),
//                                   ),
//                                 ],
//                               ),
//                               25.verticalSpace,
//                               Row(
//                                 children: [
//                                   Text(
//                                     "Update available",
//                                     style: TextStyle(
//                                         color: Colors.black,
//                                         fontSize: 17.sp,
//                                         fontWeight: FontWeight.w700),
//                                   ),
//                                 ],
//                               ),
//                               15.verticalSpace,
//                               Row(
//                                 children: [
//                                   Text(
//                                     "To use this app, download the latest version",
//                                     style: TextStyle(
//                                         color: Colors.grey,
//                                         fontSize: 11.sp,
//                                         fontWeight: FontWeight.w400),
//                                   ),
//                                 ],
//                               ),
//                               10.verticalSpace,
//                               Row(
//                                 crossAxisAlignment: CrossAxisAlignment.center,
//                                 children: [
//                                   Container(
//                                     height: 50.h,
//                                     width: 55.w,
//                                     decoration: BoxDecoration(
//                                       image: const DecorationImage(
//                                           image: AssetImage(
//                                               "assets/image/icon.png"),
//                                           fit: BoxFit.cover),
//                                       color: HexColor("#791AB1"),
//                                     ),
//                                   ),
//                                   15.horizontalSpace,
//                                   Column(
//                                     children: [
//                                       Text(
//                                         "PUNNYAM",
//                                         style: TextStyle(
//                                             color: Colors.black,
//                                             fontSize: 14.sp,
//                                             fontWeight: FontWeight.w600),
//                                       ),
//                                     ],
//                                   )
//                                 ],
//                               )
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               CommonButton(
//                                 onPressed: () async {
//                                   await launchUrl(Uri.parse(
//                                       "https://play.google.com/store/apps/details?id=com.punnyam.staff"));
//                                 },
//                                 width: 150.w,
//                                 title: "Update",
//                               ),
//                             ],
//                           )
//                         ],
//                       ).horizontalPadding(25.w).verticalPadding(30.h));
//                 },
//               )
//             : null,
//         resizeToAvoidBottomInset: false,
//         key: scaffoldKey,
//         appBar: AppBar(
//             toolbarHeight: 0,
//             elevation: 0,
//             systemOverlayStyle: SystemUiOverlayStyle(
//               statusBarColor: ColorPalette.orange,
//               statusBarIconBrightness: Brightness.dark,
//               statusBarBrightness: Brightness.light,
//             )),
//         backgroundColor: ColorPalette.orange,
//         body: Consumer<BillingProvider>(builder: (context, provider, _) {
//           return IgnorePointer(
//             ignoring:
//                 provider.version?.data![0].androidVersion == AppConfig.version
//                     ? false
//                     : true,
//             child: RefreshIndicator(
//               onRefresh: () async {},
//               child: ZoomDrawer(
//                 controller: _drawerController,
//                 style: DrawerStyle.defaultStyle,
//                 menuScreen: Container(
//                   width: double.maxFinite,
//                   color: ColorPalette.orange,
//                   child: ListView(
//                     padding: const EdgeInsets.all(0),
//                     children: [
//                       DrawerHeader(
//                         decoration: BoxDecoration(
//                           color: ColorPalette.orange,
//                         ), //BoxDecoration
//                         child: UserAccountsDrawerHeader(
//                           decoration: BoxDecoration(color: ColorPalette.orange),
//                           accountName: Text(
//                             "User",
//                             style: TextStyle(fontSize: 18.sp),
//                           ),
//                           accountEmail: const Text("online"),
//                           currentAccountPictureSize: const Size.square(50),
//                           currentAccountPicture: const CircleAvatar(
//                               // backgroundColor: Color.fromARGB(255, 165, 255, 137),
//                               backgroundColor: Colors.white,
//                               child: Icon(Icons.person)
//                               // Text(
//                               //   "A",
//                               //   style:
//                               //       TextStyle(fontSize: 30.0, color: ColorPalette.orange),
//                               // ), //Text
//                               ), //circleAvatar
//                         ), //UserAccountDrawerHeader
//                       ), //DrawerHeader

//                       ListTile(
//                         leading: const Icon(Icons.logout, color: Colors.white),
//                         title: const Text(
//                           'Logout',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         onTap: () async {
//                           final model = context.read<BillingProvider>();
//                           // final prefs = await SharedPreferences.getInstance();
//                           // prefs.clear();
//                           await SharedPreferenceHelper.clearWholeData();
//                           await model.logoutclear();

//                           CommonFunctions.afterInit(() =>
//                               Navigator.pushAndRemoveUntil(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => const Login()),
//                                   (route) => false));
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//                 mainScreen:
//                     Consumer<HomeProvider>(builder: (context, provider, _) {
//                   return Container(
//                     color: Colors.white,
//                     child: Column(
//                       children: [
//                         // TextButton(
//                         //   child: Text("Select Counter"),
//                         //   onPressed: () async {
//                         //     await printer.printCustom(
//                         //         "________________________________________", 1, 1);
//                         //     await printer.printCustom(
//                         //         "========================================", 1, 1);
//                         //   },
//                         // ),

//                         Stack(
//                           children: [
//                             Image.asset(
//                               'assets/image/dashboard_bg.png',
//                               width: double.maxFinite,
//                               fit: BoxFit.contain,
//                             ),
//                             Positioned(
//                               top: 45.h,
//                               left: 20.w,
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   InkWell(
//                                     onTap: provider.loaderState ==
//                                             LoaderState.loading
//                                         ? null
//                                         : () {
//                                             _drawerController.open!();
//                                           },
//                                     child: SizedBox(
//                                         height: 30.w,
//                                         width: 30.w,
//                                         child: Center(
//                                             child: Image.asset(
//                                                 'assets/image/menu.png'))),
//                                   ),
//                                   SizedBox(
//                                     height: 10.h,
//                                   ),
//                                   Text(
//                                     'Dashboard',
//                                     style: TextStyle(
//                                         color: Colors.white, fontSize: 21.sp),
//                                   ),
//                                   Text(
//                                     'Online Pooja Booking',
//                                     style: TextStyle(
//                                         color: Colors.white, fontSize: 14.sp),
//                                   ),
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                         // 5.verticalSpace,
//                         provider.loaderState == LoaderState.loading
//                             ? const Center(child: CircularProgressIndicator())
//                             : Expanded(
//                                 child: Column(
//                                   children: [
//                                     Expanded(
//                                       child: SizedBox(
//                                         // color: Colors.red,
//                                         height:
//                                             MediaQuery.of(context).size.height *
//                                                 .48,
//                                         child: GridView.count(
//                                             physics:
//                                                 const BouncingScrollPhysics(),
//                                             padding: EdgeInsets.symmetric(
//                                                 horizontal: 20.w),
//                                             crossAxisCount: 2,
//                                             crossAxisSpacing: 5.w,
//                                             mainAxisSpacing: 5.w,
//                                             children: List.generate(
//                                                 titleCards.length, (index) {
//                                               return Center(
//                                                 child: SelectCard(
//                                                   title: titleCards[index],
//                                                   onTap: () {
//                                                     provider.navigationSwitch(
//                                                       context,
//                                                       index,
//                                                     );
//                                                   },
//                                                 ),
//                                               );
//                                             })),
//                                       ),
//                                     ),
//                                     // 8.verticalSpace,
//                                     // InkWell(
//                                     //   onTap: () {
//                                     //     final home = context.read<HomeProvider>();
//                                     //     home.data.clear();
//                                     //     Navigator.of(context).push(MaterialPageRoute(
//                                     //       builder: (context) =>
//                                     //           const QuickBillScreen(),
//                                     //     ));
//                                     //   },
//                                     //   child: Container(
//                                     //     height: 65.h,
//                                     //     width:
//                                     //         MediaQuery.of(context).size.width / 1.18,
//                                     //     decoration: BoxDecoration(
//                                     //         borderRadius: BorderRadius.circular(25.r),
//                                     //         gradient: LinearGradient(colors: [
//                                     //           ColorPalette.primaryColor,
//                                     //           ColorPalette.orange
//                                     //         ])),
//                                     //     child: Center(
//                                     //         child: Text(
//                                     //       "Quick Bill",
//                                     //       style: TextStyle(
//                                     //           color: Colors.white, fontSize: 18.sp),
//                                     //     )),
//                                     //   ),
//                                     // ),
//                                   ],
//                                 ),
//                               ),
//                       ],
//                     ),
//                   );
//                 }),
//                 borderRadius: 24.0,
//                 showShadow: true,
//                 angle: -12.0,
//                 drawerShadowsBackgroundColor: Colors.grey.shade300,
//                 slideWidth: MediaQuery.of(context).size.width * .65,
//                 openCurve: Curves.fastOutSlowIn,
//                 closeCurve: Curves.bounceIn,
//               ),
//             ),
//           );
//         }),
//       ),
//     );
//   }

//   String? _chosenValue;
//   String? selectedCounterID;
//   void _showCounters() {
//     Future.microtask(
//       () {
//         context.read<HomeProvider>().getCounter().then((value) {
//           showDialog<bool>(
//             barrierDismissible: false,
//             context: context,
//             builder: (BuildContext context) {
//               return Consumer<BillingProvider>(builder: (context, provider, _) {
//                 return IgnorePointer(
//                   ignoring: provider.version?.data![0].androidVersion ==
//                           AppConfig.version
//                       ? false
//                       : true,
//                   child: StatefulBuilder(
//                     builder: (BuildContext context, StateSetter setState) {
//                       return PopScope(
//                         canPop: false,
//                         child: Consumer<HomeProvider>(
//                             builder: (context, provider, _) {
//                           return AlertDialog(
//                             title: const Text("Choose Counter"),
//                             content: Column(
//                                 mainAxisSize: MainAxisSize.min,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: <Widget>[
//                                   const Text("Please select a counter."),
//                                   SingleChildScrollView(
//                                       scrollDirection: Axis.horizontal,
//                                       child: DropdownButton<String>(
//                                         hint: const Text('Select your option'),
//                                         value: _chosenValue,
//                                         underline: Container(),
//                                         items: provider.counterName
//                                             .map((String value) {
//                                           return DropdownMenuItem<String>(
//                                             value: value,
//                                             child: Text(
//                                               value,
//                                               style: const TextStyle(
//                                                   fontWeight: FontWeight.w500),
//                                             ),
//                                           );
//                                         }).toList(),
//                                         onChanged: (value) async {
//                                           final SharedPreferences prefs =
//                                               await SharedPreferences
//                                                   .getInstance();

//                                           setState(() {
//                                             _chosenValue = value;
//                                             for (int i = 0;
//                                                 i < provider.counterName.length;
//                                                 i++) {
//                                               if (provider.counterName[i] ==
//                                                   _chosenValue) {
//                                                 selectedCounterID =
//                                                     provider.counterId[i];
//                                                 log(selectedCounterID
//                                                     .toString());
//                                                 prefs.setString(
//                                                     "counterid",
//                                                     selectedCounterID
//                                                         .toString());
//                                               }
//                                             }
//                                           });
//                                         },
//                                       )),
//                                 ]),
//                             actions: <Widget>[
//                               TextButton(
//                                 child: const Text("SAVE"),
//                                 onPressed: () async {
//                                   final home = context.read<HomeProvider>();
//                                   final billingProvider =
//                                       context.read<BillingProvider>();

//                                   if ((selectedCounterID != null)) {
//                                     await SharedPreferenceHelper.saveCounterID(
//                                             selectedCounterID ?? "")
//                                         .then((value) async {
//                                       await home.getquickbill();
//                                       await billingProvider.getStars();
//                                       await billingProvider.getgothra();
//                                       await billingProvider.getrashi();

//                                       billingProvider.getPaymentModes(context,
//                                           onFailure: () => Helpers.successToast(
//                                               'Error occurred while fetching payment modes ....!'));

//                                       Navigator.of(context).pop();
//                                     });
//                                   } else {
//                                     Helpers.successToast(
//                                         "Should Select Counter");
//                                   }
//                                 },
//                               ),
//                             ],
//                           );
//                         }),
//                       );
//                     },
//                   ),
//                 );
//               });
//             },
//           );
//         });
//       },
//     );
//   }

//   getCounterID() async {
//     String id = await SharedPreferenceHelper.getCounterID();
//     if (id == '') {
//       _showCounters();
//     }
//   }
// }




import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:bus_ticket_register/common/common_button.dart';
import 'package:bus_ticket_register/common/common_functions.dart';
import 'package:bus_ticket_register/common/extension.dart';
import 'package:bus_ticket_register/providers/billing_provider.dart';
import 'package:bus_ticket_register/providers/home_provider.dart';
import 'package:bus_ticket_register/screens/login/login.dart';
import 'package:bus_ticket_register/services/app_config.dart';
import 'package:bus_ticket_register/services/helpers.dart';
import 'package:bus_ticket_register/services/provider_helper_class.dart';
import 'package:bus_ticket_register/services/shared_preference_helper.dart';
import 'package:bus_ticket_register/widgets/print_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Same palette as Splash and Login.
  static const Color _navy = Color(0xFF0B2A5B);
  static const Color _blue = Color(0xFF1E5AA8);
  static const Color _accent = Color(0xFFFFC107);

  // Order must stay the same: navigationSwitch() works by index.
  List<String> titleCards = [
    "Ticket Billing",
    "Ticket List",
    'Ticket Summary',
    'Counter Wise Summary',
  ];

  final List<IconData> _cardIcons = const [
    Icons.confirmation_number_rounded,
    Icons.receipt_long_rounded,
    Icons.route_rounded,
    Icons.point_of_sale_rounded,
  ];

  final List<Color> _cardColors = const [
    Color(0xFF1E5AA8),
    Color(0xFFF59E0B),
    Color(0xFF0E9F8E),
    Color(0xFF6D4AD8),
  ];

  final _drawerController = ZoomDrawerController();
  @override
  void initState() {
    final home = context.read<BillingProvider>();
    home.version?.data![0].androidVersion != AppConfig.version
        ? null
        : getCounterID();
    _init();
    super.initState();
  }

  String status = 'Starting...';

  Future<void> _init() async {
    // 1. Request permissions
    setState(() => status = 'Requesting permissions...');
    await [
      Permission.bluetooth,
      Permission.bluetoothConnect,
      Permission.bluetoothScan,
      Permission.locationWhenInUse,
    ].request();

    // 2. Auto-connect to InnerPrinter
    setState(() => status = 'Connecting to InnerPrinter...');
    final connected = await PrinterService.autoConnect();

    setState(
      () => status = connected
          ? '✅ Printer connected!'
          : '⚠️ InnerPrinter not found.\nMake sure it is paired in Bluetooth settings.',
    );
  }

  Future<Uint8List> assetImageToUint8List(String assetPath) async {
    ByteData data = await rootBundle.load(assetPath);
    return data.buffer.asUint8List();
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  // ---------------------------------------------------------------- UI parts

  Widget _buildHeader(HomeProvider provider) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_navy, _blue],
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(32.r)),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 26.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(14.r),
                    onTap: provider.loaderState == LoaderState.loading
                        ? null
                        : () {
                            _drawerController.open!();
                          },
                    child: Container(
                      height: 42.w,
                      width: 42.w,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      child: Icon(Icons.menu_rounded,
                          color: Colors.white, size: 24.w),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: 42.w,
                    width: 42.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Icon(Icons.directions_bus_rounded,
                            color: _navy, size: 24.w),
                        Positioned(
                          top: 8.w,
                          right: 8.w,
                          child: Container(
                            width: 7.w,
                            height: 7.w,
                            decoration: const BoxDecoration(
                              color: _accent,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 22.h),
              Text(
                'Dashboard',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.3,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Bus Ticket Booking',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.75),
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 16.h),
              // Printer status (uses the existing `status` string)
              Container(
                width: double.maxFinite,
                padding:
                    EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(14.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.print_rounded,
                        color: _accent, size: 18.w),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        status,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardCard(HomeProvider provider, int index) {
    final color = _cardColors[index % _cardColors.length];
    return InkWell(
      borderRadius: BorderRadius.circular(22.r),
      onTap: () {
        provider.navigationSwitch(
          context,
          index,
        );
      },
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22.r),
          border: Border.all(color: color.withOpacity(0.12)),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.14),
              blurRadius: 18,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 48.w,
              width: 48.w,
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Icon(_cardIcons[index % _cardIcons.length],
                  color: color, size: 26.w),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titleCards[index],
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: _navy,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Text(
                      'Open',
                      style: TextStyle(
                        color: color,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    Icon(Icons.arrow_forward_rounded,
                        color: color, size: 14.w),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuScreen() {
    return Container(
      width: double.maxFinite,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [_navy, _blue],
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: Colors.transparent),
            child: UserAccountsDrawerHeader(
              decoration: const BoxDecoration(color: Colors.transparent),
              accountName: Text(
                "User",
                style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              ),
              accountEmail: const Text("online"),
              currentAccountPictureSize: const Size.square(50),
              currentAccountPicture: const CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: _navy)),
            ),
          ),
          Divider(color: Colors.white.withOpacity(0.2), height: 1),
          ListTile(
            leading: const Icon(Icons.logout_rounded, color: Colors.white),
            title: const Text(
              'Logout',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
            onTap: () async {
              final model = context.read<BillingProvider>();
              await SharedPreferenceHelper.clearWholeData();
              await model.logoutclear();

              CommonFunctions.afterInit(() => Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const Login()),
                  (route) => false));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildUpdateSheet() {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
          boxShadow: [
            BoxShadow(
                color: Colors.black26,
                blurRadius: 20.r,
                offset: const Offset(0, 5))
          ],
        ),
        height: 320.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                        height: 25.h,
                        width: 25.w,
                        child: SvgPicture.asset(
                          "assets/image/google_play.svg",
                          fit: BoxFit.contain,
                        )),
                    8.horizontalSpace,
                    Text(
                      "Google Play",
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                25.verticalSpace,
                Row(
                  children: [
                    Text(
                      "Update available",
                      style: TextStyle(
                          color: _navy,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
                15.verticalSpace,
                Row(
                  children: [
                    Text(
                      "To use this app, download the latest version",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                10.verticalSpace,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 50.h,
                      width: 55.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        image: const DecorationImage(
                            image: AssetImage("assets/image/icon.png"),
                            fit: BoxFit.cover),
                        color: HexColor("#791AB1"),
                      ),
                    ),
                    15.horizontalSpace,
                    Column(
                      children: [
                        Text(
                          "Bus Ticket Register",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CommonButton(
                  onPressed: () async {
                    await launchUrl(Uri.parse(
                        "https://play.google.com/store/apps/details?id=com.punnyam.staff"));
                  },
                  width: 150.w,
                  title: "Update",
                ),
              ],
            )
          ],
        ).horizontalPadding(25.w).verticalPadding(30.h));
  }

  // ------------------------------------------------------------------ build

  @override
  Widget build(BuildContext context) {
    return Consumer<BillingProvider>(
      builder: (context, home, child) => Scaffold(
        bottomSheet: home.version?.data![0].androidVersion != AppConfig.version
            ? BottomSheet(
                onClosing: () {},
                builder: (BuildContext context) => _buildUpdateSheet(),
              )
            : null,
        resizeToAvoidBottomInset: false,
        key: scaffoldKey,
        appBar: AppBar(
            toolbarHeight: 0,
            elevation: 0,
            backgroundColor: _navy,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: _navy,
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.dark,
            )),
        backgroundColor: _navy,
        body: Consumer<BillingProvider>(builder: (context, provider, _) {
          return IgnorePointer(
            ignoring:
                provider.version?.data![0].androidVersion == AppConfig.version
                    ? false
                    : true,
            child: RefreshIndicator(
              onRefresh: () async {},
              child: ZoomDrawer(
                controller: _drawerController,
                style: DrawerStyle.defaultStyle,
                menuScreen: _buildMenuScreen(),
                mainScreen:
                    Consumer<HomeProvider>(builder: (context, provider, _) {
                  return Container(
                    color: const Color(0xFFF4F7FC),
                    child: Column(
                      children: [
                        _buildHeader(provider),
                        provider.loaderState == LoaderState.loading
                            ? const Expanded(
                                child: Center(
                                    child: CircularProgressIndicator(
                                        color: _navy)))
                            : Expanded(
                                child: GridView.count(
                                  physics: const BouncingScrollPhysics(),
                                  padding: EdgeInsets.fromLTRB(
                                      20.w, 24.h, 20.w, 20.h),
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 16.w,
                                  mainAxisSpacing: 16.w,
                                  childAspectRatio: 1.05,
                                  children: List.generate(titleCards.length,
                                      (index) {
                                    return _buildDashboardCard(
                                        provider, index);
                                  }),
                                ),
                              ),
                      ],
                    ),
                  );
                }),
                borderRadius: 24.0,
                showShadow: true,
                angle: -12.0,
                drawerShadowsBackgroundColor: Colors.grey.shade300,
                slideWidth: MediaQuery.of(context).size.width * .65,
                openCurve: Curves.fastOutSlowIn,
                closeCurve: Curves.bounceIn,
              ),
            ),
          );
        }),
      ),
    );
  }

  String? _chosenValue;
  String? selectedCounterID;
  void _showCounters() {
    Future.microtask(
      () {
        context.read<HomeProvider>().getCounter().then((value) {
          showDialog<bool>(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) {
              return Consumer<BillingProvider>(builder: (context, provider, _) {
                return IgnorePointer(
                  ignoring: provider.version?.data![0].androidVersion ==
                          AppConfig.version
                      ? false
                      : true,
                  child: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                      return PopScope(
                        canPop: false,
                        child: Consumer<HomeProvider>(
                            builder: (context, provider, _) {
                          return AlertDialog(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(22.r)),
                            title: const Text(
                              "Choose Counter",
                              style: TextStyle(
                                  color: _navy, fontWeight: FontWeight.w700),
                            ),
                            content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  const Text("Please select a counter."),
                                  SizedBox(height: 8.h),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12.w),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF4F7FC),
                                      borderRadius:
                                          BorderRadius.circular(12.r),
                                    ),
                                    child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: DropdownButton<String>(
                                          hint: const Text(
                                              'Select your option'),
                                          value: _chosenValue,
                                          underline: Container(),
                                          items: provider.counterName
                                              .map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            );
                                          }).toList(),
                                          onChanged: (value) async {
                                            final SharedPreferences prefs =
                                                await SharedPreferences
                                                    .getInstance();

                                            setState(() {
                                              _chosenValue = value;
                                              for (int i = 0; i < provider.counterName.length;
                                                  i++) {
                                                if (provider.counterName[i] ==
                                                    _chosenValue) {
                                                  selectedCounterID =
                                                      provider.counterId[i];
                                                  log(selectedCounterID
                                                      .toString());
                                                  prefs.setString(
                                                      "counterid",
                                                      selectedCounterID
                                                          .toString());
                                                }
                                              }
                                            });
                                          },
                                        )),
                                  ),
                                ]),
                            actions: <Widget>[
                              TextButton(
                                child: const Text(
                                  "SAVE",
                                  style: TextStyle(
                                      color: _navy,
                                      fontWeight: FontWeight.w700),
                                ),
                                onPressed: () async {
                                  final home = context.read<HomeProvider>();
                                  final billingProvider =
                                      context.read<BillingProvider>();

                                  if ((selectedCounterID != null)) {
                                    await SharedPreferenceHelper.saveCounterID(
                                            selectedCounterID ?? "")
                                        .then((value) async {
                                      await home.getquickbill();
                                      await billingProvider.getStars();
                                      await billingProvider.getgothra();
                                      await billingProvider.getrashi();

                                      billingProvider.getPaymentModes(context,
                                          onFailure: () => Helpers.successToast(
                                              'Error occurred while fetching payment modes ....!'));

                                      Navigator.of(context).pop();
                                    });
                                  } else {
                                    Helpers.successToast(
                                        "Should Select Counter");
                                  }
                                },
                              ),
                            ],
                          );
                        }),
                      );
                    },
                  ),
                );
              });
            },
          );
        });
      },
    );
  }

  getCounterID() async {
    String id = await SharedPreferenceHelper.getCounterID();
    if (id == '') {
      _showCounters();
    }
  }
}