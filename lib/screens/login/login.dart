// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import 'package:bus_ticket_register/common/color_palette.dart';
// import 'package:bus_ticket_register/common/common_button.dart';
// import 'package:bus_ticket_register/providers/auth_provider.dart';
// import 'package:bus_ticket_register/providers/billing_provider.dart';
// import 'package:bus_ticket_register/providers/home_provider.dart';
// import 'package:bus_ticket_register/screens/home/home.dart';
// import 'package:bus_ticket_register/screens/register/register_screen.dart';
// import 'package:bus_ticket_register/services/helpers.dart';
// import 'package:bus_ticket_register/services/provider_helper_class.dart';
// import 'package:bus_ticket_register/services/validation_helper.dart';
// import 'package:bus_ticket_register/widgets/punnyam_textfiled.dart';

// class Login extends StatefulWidget {
//   const Login({super.key});
//   @override
//   State<Login> createState() => _LoginState();
// }

// class _LoginState extends State<Login> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//           toolbarHeight: 0,
//           elevation: 0,
//           systemOverlayStyle: SystemUiOverlayStyle(
//             statusBarColor: ColorPalette.orange,
//             statusBarIconBrightness: Brightness.dark,
//             statusBarBrightness: Brightness.light,
//           )),
//       body: SingleChildScrollView(
//         child: Consumer<AuthProvider>(
//           builder: (context, authProvider, child) {
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 SafeArea(
//                   child: SizedBox(
//                     width: double.maxFinite,
//                     child: Image.asset(
//                       "assets/image/login_image.png",
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 25.w),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(
//                         height: 30.h,
//                       ),
//                       PunnyamTextField(
//                         contentpadding: EdgeInsets.symmetric(vertical: 15.h),
//                         hintText: "Email",
//                         textEditingController:
//                             authProvider.loginUsernameController,
//                         prefixIcon: Icons.person,
//                         onChanged: (value) {
//                           authProvider.updateValidationMessages(
//                               validationType: ValidationTypes.userName,
//                               validationMessage:
//                                   ValidationHelperClass.validateEmail(
//                                           value.trim()) ??
//                                       '');
//                         },
//                       ),
//                       if (authProvider.userNameValidationMessage != null)
//                         Padding(
//                           padding: EdgeInsets.symmetric(
//                               horizontal: 10.w, vertical: 5.h),
//                           child: Text(
//                             authProvider.userNameValidationMessage ?? '',
//                             style: const TextStyle(color: Colors.red),
//                           ),
//                         ),
//                       SizedBox(
//                         height: 15.h,
//                       ),
//                       PunnyamTextField(
//                         contentpadding: EdgeInsets.symmetric(vertical: 15.h),
//                         hintText: "Password",
//                         textEditingController:
//                             authProvider.loginPasswordController,
//                         prefixIcon: Icons.lock,
//                         onChanged: (value) =>
//                             authProvider.updateLoginFormState(),
//                         makePasswordField: true,
//                         textInputAction: TextInputAction.done,
//                       ),
//                       SizedBox(
//                         height: 10.h,
//                       ),
//                       Row(
//                         children: [
//                           Checkbox(
//                             value: authProvider.isRememberCredentials,
//                             onChanged: (value) {
//                               authProvider
//                                   .updateRememberMeValue(value ?? false);
//                             },
//                           ),
//                           Text("Remember me",
//                               style: TextStyle(color: Colors.grey.shade700)),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 20.h,
//                       ),
//                       CommonButton(
//                           title: 'Login',
//                           isLoading:
//                               authProvider.loaderState == LoaderState.loading,
//                           onPressed: authProvider.isLoginFormValidated
//                               ? () {
//                                   FocusScope.of(context).unfocus();
//                                   authProvider.login(
//                                       onSuccess: () async {
//                                         final home =
//                                             context.read<HomeProvider>();
//                                         final billingProvider =
//                                             context.read<BillingProvider>();
//                                         await home.getquickbill();
//                                         await billingProvider.getStars();
//                                         await billingProvider
//                                             .getversion(context);

//                                         billingProvider.getPaymentModes(context,
//                                             onFailure: () => Helpers.successToast(
//                                                 'Error occurred while fetching payment modes ....!'));

//                                         Navigator.pushReplacement(
//                                             context,
//                                             MaterialPageRoute(
//                                               builder: (context) =>
//                                                   const Home(),
//                                             )).then((value) async {
//                                           await home.getCounter();

//                                           authProvider.clearValues();
//                                         });
//                                       },
//                                       onFailure: () => Helpers.successToast(
//                                           authProvider.errorToast ?? ''));
//                                 }
//                               : null),
//                       SizedBox(
//                         height: 60.h,
//                       ),
//                       Center(
//                         child: RichText(
//                           text: TextSpan(
//                             text: 'Not a member ? ',
//                             style: TextStyle(color: Colors.grey.shade700),
//                             children: <WidgetSpan>[
//                               WidgetSpan(
//                                   child: InkWell(
//                                 onTap: () {
//                                   FocusScope.of(context).unfocus();
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) =>
//                                               const RegisterScreen()));
//                                 },
//                                 child: Text('Sign up now',
//                                     style: TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         color: ColorPalette.primaryColor)),
//                               ))
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                     padding: EdgeInsets.only(
//                         bottom: MediaQuery.of(context).viewInsets.bottom))
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:bus_ticket_register/common/common_button.dart';
import 'package:bus_ticket_register/providers/auth_provider.dart';
import 'package:bus_ticket_register/providers/billing_provider.dart';
import 'package:bus_ticket_register/providers/home_provider.dart';
import 'package:bus_ticket_register/screens/home/home.dart';
import 'package:bus_ticket_register/screens/register/register_screen.dart';
import 'package:bus_ticket_register/services/helpers.dart';
import 'package:bus_ticket_register/services/provider_helper_class.dart';
import 'package:bus_ticket_register/services/validation_helper.dart';
import 'package:bus_ticket_register/widgets/punnyam_textfiled.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // Same palette as the splash screen.
  static const Color _navy = Color(0xFF0B2A5B);
  static const Color _blue = Color(0xFF1E5AA8);
  static const Color _accent = Color(0xFFFFC107);

  Widget _buildHeader() {
    return Container(
      width: double.maxFinite,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [_navy, _blue],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(25.w, 28.h, 25.w, 64.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 68.w,
                height: 68.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Icon(Icons.directions_bus_rounded,
                        size: 38.w, color: _navy),
                    Positioned(
                      top: 12.w,
                      right: 12.w,
                      child: Container(
                        width: 8.w,
                        height: 8.w,
                        decoration: const BoxDecoration(
                          color: _accent,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 22.h),
              Text(
                'Welcome Back',
                style: TextStyle(
                  fontSize: 26.sp,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  letterSpacing: 0.3,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                'Login to manage your bus tickets',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.white.withValues(alpha: 0.75),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
          backgroundColor: _navy,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: _navy,
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
          )),
      body: SingleChildScrollView(
        child: Consumer<AuthProvider>(
          builder: (context, authProvider, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildHeader(),
                // Card overlaps the header by 28.h
                Transform.translate(
                  offset: Offset(0, -28.h),
                  child: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(30.r)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30.h,
                        ),
                        Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w700,
                            color: _navy,
                          ),
                        ),
                        SizedBox(
                          height: 22.h,
                        ),
                        PunnyamTextField(
                          contentpadding: EdgeInsets.symmetric(vertical: 15.h),
                          hintText: "Email",
                          textEditingController:
                              authProvider.loginUsernameController,
                          prefixIcon: Icons.person,
                          onChanged: (value) {
                            authProvider.updateValidationMessages(
                                validationType: ValidationTypes.userName,
                                validationMessage:
                                    ValidationHelperClass.validateEmail(
                                            value.trim()) ??
                                        '');
                          },
                        ),
                        if (authProvider.userNameValidationMessage != null)
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10.w, vertical: 5.h),
                            child: Text(
                              authProvider.userNameValidationMessage ?? '',
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                        SizedBox(
                          height: 15.h,
                        ),
                        PunnyamTextField(
                          contentpadding: EdgeInsets.symmetric(vertical: 15.h),
                          hintText: "Password",
                          textEditingController:
                              authProvider.loginPasswordController,
                          prefixIcon: Icons.lock,
                          onChanged: (value) =>
                              authProvider.updateLoginFormState(),
                          makePasswordField: true,
                          textInputAction: TextInputAction.done,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: authProvider.isRememberCredentials,
                              activeColor: _navy,
                              onChanged: (value) {
                                authProvider
                                    .updateRememberMeValue(value ?? false);
                              },
                            ),
                            Text("Remember me",
                                style:
                                    TextStyle(color: Colors.grey.shade700)),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        CommonButton(
                            title: 'Login',
                            isLoading:
                                authProvider.loaderState == LoaderState.loading,
                            onPressed: authProvider.isLoginFormValidated
                                ? () {
                                    FocusScope.of(context).unfocus();
                                    authProvider.login(
                                        onSuccess: () async {
                                          final home =
                                              context.read<HomeProvider>();
                                          final billingProvider =
                                              context.read<BillingProvider>();
                                          await home.getquickbill();
                                          await billingProvider.getStars();
                                          await billingProvider
                                              .getversion(context);

                                          billingProvider.getPaymentModes(
                                              context,
                                              onFailure: () => Helpers.successToast(
                                                  'Error occurred while fetching payment modes ....!'));

                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const Home(),
                                              )).then((value) async {
                                            await home.getCounter();

                                            authProvider.clearValues();
                                          });
                                        },
                                        onFailure: () => Helpers.successToast(
                                            authProvider.errorToast ?? ''));
                                  }
                                : null),
                        SizedBox(
                          height: 50.h,
                        ),
                        Center(
                          child: RichText(
                            text: TextSpan(
                              text: 'Not a member ? ',
                              style: TextStyle(color: Colors.grey.shade700),
                              children: <WidgetSpan>[
                                WidgetSpan(
                                    child: InkWell(
                                  onTap: () {
                                    FocusScope.of(context).unfocus();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const RegisterScreen()));
                                  },
                                  child: const Text('Sign up now',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: _navy)),
                                ))
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom))
              ],
            );
          },
        ),
      ),
    );
  }
}