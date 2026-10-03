import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:bus_ticket_register/common/color_palette.dart';
import 'package:bus_ticket_register/screens/splash/splash_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bus_ticket_register/services/multi_provider_list.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MultiProvider(
      providers: MultiProviderList.providerList, child: const Punnyam()));
}

class Punnyam extends StatelessWidget {
  const Punnyam({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height),
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Punnyam temple suite',
          theme: ThemeData(
            primarySwatch: ColorPalette.materialTheme,
            brightness: Brightness.light,
            scaffoldBackgroundColor: Colors.white,
          ),
          home: const SplashScreen(),
        );
      },
    );
  }
}
