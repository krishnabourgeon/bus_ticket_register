// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import 'package:bus_ticket_register/common/color_palette.dart';
// import 'package:bus_ticket_register/providers/billing_provider.dart';
// import 'package:bus_ticket_register/providers/home_provider.dart';
// import 'package:bus_ticket_register/screens/login/login.dart';
// import 'package:bus_ticket_register/services/app_config.dart';
// import 'package:bus_ticket_register/services/helpers.dart';
// import 'package:bus_ticket_register/services/shared_preference_helper.dart';
// import '../home/home.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     checkLogged();
//     super.initState();
//   }

//   checkLogged() async {
//     await SharedPreferenceHelper.getToken();
//     Future.delayed(const Duration(seconds: 2), () => navToScreen());
//   }

//   navToScreen() async {
//     final home = context.read<HomeProvider>();
//     final billingProvider = context.read<BillingProvider>();
//     if ((AppConfig.accessToken ?? '').isNotEmpty) {
//       await billingProvider.getversion(context);
//       await home.getquickbill();
//       await billingProvider.getStars();
//       await billingProvider.getgothra();
//       await billingProvider.getrashi();

//       if (!mounted) return;
//       billingProvider.getPaymentModes(context,
//           onFailure: () => Helpers.successToast(
//               'Error occurred while fetching payment modes ....!'));

//       Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(builder: (context) => const Home()),
//           (route) => false);
//     } else {
//       Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(builder: (context) => const Login()),
//           (route) => false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           toolbarHeight: 0,
//           elevation: 0,
//           systemOverlayStyle: SystemUiOverlayStyle(
//             statusBarColor: ColorPalette.orange,
//             statusBarIconBrightness: Brightness.dark,
//             statusBarBrightness: Brightness.light,
//           )),
//       body: Container(
//         height: double.maxFinite,
//         width: double.maxFinite,
//         decoration: BoxDecoration(
//             gradient: LinearGradient(
//                 begin: Alignment.centerLeft,
//                 end: Alignment.centerRight,
//                 colors: [
//               ColorPalette.orange,
//               ColorPalette.primaryColor,
//             ])),
//         child: Center(
//             child: Image.asset(
//           'assets/image/logo.png',
//           width: 300.w,
//           height: 300.w,
//           fit: BoxFit.fill,
//         )),
//       ),
//     );
//   }
// }






import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:bus_ticket_register/providers/billing_provider.dart';
import 'package:bus_ticket_register/providers/home_provider.dart';
import 'package:bus_ticket_register/screens/login/login.dart';
import 'package:bus_ticket_register/services/app_config.dart';
import 'package:bus_ticket_register/services/helpers.dart';
import 'package:bus_ticket_register/services/shared_preference_helper.dart';
import '../home/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  // Splash-only colors. Move into ColorPalette if you want them app-wide.
  static const Color _navy = Color(0xFF0B2A5B);
  static const Color _blue = Color(0xFF1E5AA8);
  static const Color _accent = Color(0xFFFFC107);

  late final AnimationController _introController;
  late final AnimationController _roadController;
  late final Animation<double> _fade;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _introController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();
    _roadController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat();
    _fade = CurvedAnimation(parent: _introController, curve: Curves.easeOut);
    _scale = Tween<double>(begin: 0.85, end: 1).animate(
      CurvedAnimation(parent: _introController, curve: Curves.easeOutBack),
    );
    checkLogged();
  }

  @override
  void dispose() {
    _introController.dispose();
    _roadController.dispose();
    super.dispose();
  }

  checkLogged() async {
    await SharedPreferenceHelper.getToken();
    Future.delayed(const Duration(seconds: 2), () => navToScreen());
  }

  navToScreen() async {
    final home = context.read<HomeProvider>();
    final billingProvider = context.read<BillingProvider>();
    if ((AppConfig.accessToken ?? '').isNotEmpty) {
      await billingProvider.getversion(context);
      await home.getquickbill();
      await billingProvider.getStars();
      await billingProvider.getgothra();
      await billingProvider.getrashi();

      if (!mounted) return;
      billingProvider.getPaymentModes(context,
          onFailure: () => Helpers.successToast(
              'Error occurred while fetching payment modes ....!'));

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
          (route) => false);
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
          (route) => false);
    }
  }

  Widget _buildBadge() {
    return Container(
      width: 130.w,
      height: 130.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(36.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 30,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(Icons.directions_bus_rounded, size: 72.w, color: _navy),
          Positioned(
            top: 22.w,
            right: 22.w,
            child: Container(
              width: 14.w,
              height: 14.w,
              decoration: const BoxDecoration(
                color: _accent,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRoad() {
    return SizedBox(
      height: 40.h,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // dashed road line
          Padding(
            padding: EdgeInsets.only(bottom: 6.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                26,
                (_) => Container(
                  width: 6.w,
                  height: 2.h,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.45),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
            ),
          ),
          // moving bus
          AnimatedBuilder(
            animation: _roadController,
            builder: (context, child) {
              return Align(
                alignment: Alignment(-1 + (_roadController.value * 2), 0),
                child: child,
              );
            },
            child: Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: Icon(Icons.directions_bus_filled_rounded,
                  size: 26.w, color: _accent),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _navy,
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        backgroundColor: _navy,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: _navy,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [_navy, _blue],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32.w),
            child: Column(
              children: [
                const Spacer(flex: 3),
                FadeTransition(
                  opacity: _fade,
                  child: ScaleTransition(
                    scale: _scale,
                    child: Column(
                      children: [
                        _buildBadge(),
                        SizedBox(height: 28.h),
                        Text(
                          'Bus Ticket Register',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 26.sp,
                            fontWeight: FontWeight.w800,
                            color: Colors.white,
                            letterSpacing: 0.4,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Ticket • Print ',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withOpacity(0.75),
                            letterSpacing: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Spacer(flex: 3),
                _buildRoad(),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}