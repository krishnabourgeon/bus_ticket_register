// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:intl/intl.dart';
// // import 'package:provider/provider.dart';
// // import 'package:bus_ticket_register/common/common_button.dart';
// // import 'package:bus_ticket_register/common/common_functions.dart';
// // import 'package:bus_ticket_register/providers/billing_provider.dart';
// // import 'package:bus_ticket_register/screens/billing/widgets/daily_schedule_widget.dart';
// // import 'package:bus_ticket_register/screens/billing/widgets/loading_dropdown.dart';
// // import 'package:bus_ticket_register/screens/billing/widgets/monthly_schedule_widget.dart';
// // import 'package:bus_ticket_register/screens/billing/widgets/normal_billing_widget.dart';
// // import 'package:bus_ticket_register/screens/billing/widgets/other_schedule_widget.dart';
// // import 'package:bus_ticket_register/screens/billing/widgets/weekly_schedule_widget.dart';
// // import 'package:bus_ticket_register/services/provider_helper_class.dart';
// // import 'package:bus_ticket_register/widgets/punnyam_switch.dart';
// // import 'package:bus_ticket_register/widgets/stack_loader.dart';
// // import '../../common/custom_drop_down_search.dart';

// // class Billing extends StatefulWidget {
// //   const Billing({super.key});
// //   @override
// //   State<Billing> createState() => _BillingState();
// // }

// // class _BillingState extends State<Billing> {
// //   final DateFormat formatter = DateFormat('dd-MM-yyyy');
// //   DateTime selectedDate = DateTime.now();
// //   @override
// //   void initState() {
// //     CommonFunctions.afterInit(() {
// //       context.read<BillingProvider>().getInitialDataList();
// //     });
// //     super.initState();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       resizeToAvoidBottomInset: false,
// //       appBar: AppBar(
// //         backgroundColor: Colors.white,
// //         elevation: 0,
// //         leading: Center(
// //           child: InkWell(
// //             onTap: (() => Navigator.pop(context)),
// //             child: SizedBox(
// //                 height: 25.h,
// //                 width: 25.h,
// //                 child: Image.asset("assets/image/backIcon.png")),
// //           ),
// //         ),
// //         systemOverlayStyle: const SystemUiOverlayStyle(
// //           statusBarColor: Colors.white,
// //           statusBarIconBrightness: Brightness.dark,
// //           statusBarBrightness: Brightness.light,
// //         ),
// //         title: const Text(
// //           "Billing",
// //           style: TextStyle(color: Colors.black),
// //         ),
// //       ),
// //       body: Consumer<BillingProvider>(builder: (__, billingProvider, _) {
// //         return StackLoader(
// //           inAsyncCall:
// //               billingProvider.loaderState == LoaderState.loading ? true : false,
// //           child: SingleChildScrollView(
// //             reverse: true,
// //             child: Container(
// //               margin: EdgeInsets.symmetric(horizontal: 20.w),
// //               child: Column(
// //                 children: [
// //                   NormalBillingWidget(billingProvider: billingProvider),
// //                   if (billingProvider.deityname != "DONATION") ...[
// //                     Padding(
// //                       padding: EdgeInsets.symmetric(horizontal: 5.w),
// //                       child: Row(
// //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                         children: [
// //                           const Text(
// //                             "Do you want to schedule?",
// //                             style: TextStyle(color: Colors.black),
// //                           ),
// //                           PunnyamSwitch(
// //                             isOn: billingProvider.isScheduled,
// //                             onTap: (value) => billingProvider
// //                               ..updateSwitch(value)
// //                               ..updateBillingFormState(),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
// //                     if (billingProvider.isScheduled)
// //                       Column(
// //                         children: [
// //                           10.verticalSpace,
// //                           billingProvider.loaderState == LoaderState.loading
// //                               ? const LoadingDropDown(
// //                                   title: 'Schedule Type',
// //                                 )
// //                               : CustomDropDownSearch(
// //                                   labelText: 'Schedule Type',
// //                                   maxHeight: 220.h,
// //                                   onChanged: (value) => billingProvider
// //                                     ..updateSheduleType(value)
// //                                     ..updateBillingFormState(),
// //                                   items: List.generate(
// //                                       billingProvider.scheduleTypesList.length,
// //                                       (index) =>
// //                                           billingProvider
// //                                               .scheduleTypesList[index] ??
// //                                           ''),
// //                                 ),
// //                           10.verticalSpace,
// //                           if (billingProvider.scheduleTypes == "Daily")
// //                             DailyScheduleWidget(billingProvider: billingProvider),
// //                           if (billingProvider.scheduleTypes == "Weekly")
// //                             WeeklyScheduleWidget(
// //                                 billingProvider: billingProvider),
// //                           if (billingProvider.scheduleTypes == "Monthly")
// //                             MonthlyScheduleWidget(
// //                                 billingProvider: billingProvider),
// //                           if (billingProvider.scheduleTypes == "Other")
// //                             OtherScheduleWidget(billingProvider: billingProvider),
// //                           20.verticalSpace,
// //                         ],
// //                       ),
// //                   ],
// //                   CommonButton(
// //                     title: "Save and Add Next",
// //                     onPressed: billingProvider.isBillingFormValidated
// //                         ? () async {
// //                             FocusScope.of(context).unfocus();
// //                             BillingProvider.address = false;
// //                             await billingProvider.saveAndNextFunction();
// //                             // billingProvider.getStarIdFromName('Nodata');
// //                           }
// //                         : null,
// //                   ),
// //                   10.verticalSpace,
// //                   CommonButton(
// //                       title: "Save and Preview",
// //                       colors: [
// //                         billingProvider.poojaDetailsList.isEmpty
// //                             ? billingProvider.isBillingFormValidated
// //                                 ? Colors.green
// //                                 : Colors.green.withOpacity(.5)
// //                             : Colors.green,
// //                         billingProvider.poojaDetailsList.isEmpty
// //                             ? billingProvider.isBillingFormValidated
// //                                 ? Colors.greenAccent
// //                                 : Colors.greenAccent.withOpacity(.5)
// //                             : Colors.greenAccent
// //                       ],
// //                       onPressed: billingProvider.poojaDetailsList.isEmpty
// //                           ? billingProvider.isBillingFormValidated
// //                               ? () {
// //                                   BillingProvider.address = false;
// //                                   billingProvider
// //                                       .saveAndPreviewFunction(context);
// //                                 }
// //                               : null
// //                           : () =>
// //                               billingProvider.navigateToPreviewBill(context)),
// //                   30.verticalSpace,
// //                   Padding(
// //                       padding: EdgeInsets.only(
// //                           bottom: MediaQuery.of(context).viewInsets.bottom))
// //                 ],
// //               ),
// //             ),
// //           ),
// //         );
// //       }),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:bus_ticket_register/common/common_button.dart';
// import 'package:bus_ticket_register/common/common_functions.dart';
// import 'package:bus_ticket_register/providers/billing_provider.dart';
// import 'package:bus_ticket_register/services/provider_helper_class.dart';
// import 'package:bus_ticket_register/widgets/stack_loader.dart';

// class Billing extends StatefulWidget {
//   const Billing({super.key});
//   @override
//   State<Billing> createState() => _BillingState();
// }

// class _BillingState extends State<Billing> {
//   // Same palette as Splash, Login and Home.
//   static const Color _navy = Color(0xFF0B2A5B);
//   static const Color _blue = Color(0xFF1E5AA8);
//   static const Color _accent = Color(0xFFFFC107);
//   static const Color _bg = Color(0xFFF4F7FC);

//   final DateFormat formatter = DateFormat('dd-MM-yyyy');
//   DateTime selectedDate = DateTime.now();

//   final TextEditingController _fromController = TextEditingController();
//   final TextEditingController _toController = TextEditingController();
//   final TextEditingController _amountController = TextEditingController();
//   int _qty = 1;

//   @override
//   void initState() {
//     CommonFunctions.afterInit(() {
//       context.read<BillingProvider>().getInitialDataList();
//     });
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _fromController.dispose();
//     _toController.dispose();
//     _amountController.dispose();
//     super.dispose();
//   }

//   // ------------------------------------------------------------- helpers

//   double get _amount => double.tryParse(_amountController.text.trim()) ?? 0;
//   double get _total => _amount * _qty;

//   bool get _isFormValid =>
//       _fromController.text.trim().isNotEmpty &&
//       _toController.text.trim().isNotEmpty &&
//       _fromController.text.trim().toLowerCase() !=
//           _toController.text.trim().toLowerCase() &&
//       _amount > 0 &&
//       _qty >= 1;

//   String? get _routeError {
//     final from = _fromController.text.trim().toLowerCase();
//     final to = _toController.text.trim().toLowerCase();
//     if (from.isNotEmpty && to.isNotEmpty && from == to) {
//       return 'From and To places cannot be the same';
//     }
//     return null;
//   }

//   void _swapPlaces() {
//     final temp = _fromController.text;
//     _fromController.text = _toController.text;
//     _toController.text = temp;
//     setState(() {});
//   }

//   Future<void> _pickDate() async {
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: selectedDate,
//       firstDate: DateTime.now().subtract(const Duration(days: 365)),
//       lastDate: DateTime.now().add(const Duration(days: 365)),
//       builder: (context, child) => Theme(
//         data: Theme.of(context).copyWith(
//           colorScheme: const ColorScheme.light(
//             primary: _navy,
//             onPrimary: Colors.white,
//             onSurface: _navy,
//           ),
//         ),
//         child: child!,
//       ),
//     );
//     if (picked != null) {
//       setState(() => selectedDate = picked);
//     }
//   }

//   void _resetForm() {
//     _fromController.clear();
//     _toController.clear();
//     _amountController.clear();
//     setState(() => _qty = 1);
//   }

//   /// TODO: hook the five values into BillingProvider here, before the save
//   /// calls run. Values: _fromController.text, _toController.text, _amount,
//   /// _qty, selectedDate. (Send BillingProvider and I'll wire this.)
//   void _pushToProvider(BillingProvider billingProvider) {}

//   // ------------------------------------------------------------- UI parts

//   InputDecoration _decoration({
//     required String label,
//     required IconData icon,
//     String? prefixText,
//   }) {
//     OutlineInputBorder border(Color color, [double width = 1]) =>
//         OutlineInputBorder(
//           borderRadius: BorderRadius.circular(14.r),
//           borderSide: BorderSide(color: color, width: width),
//         );
//     return InputDecoration(
//       labelText: label,
//       prefixText: prefixText,
//       prefixIcon: Icon(icon, color: _blue, size: 22.w),
//       labelStyle: TextStyle(color: Colors.grey.shade600, fontSize: 14.sp),
//       floatingLabelStyle: const TextStyle(color: _navy),
//       filled: true,
//       fillColor: Colors.white,
//       contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 14.w),
//       enabledBorder: border(Colors.grey.shade300),
//       focusedBorder: border(_navy, 1.5),
//       border: border(Colors.grey.shade300),
//     );
//   }

//   Widget _sectionCard({required Widget child}) {
//     return Container(
//       width: double.maxFinite,
//       padding: EdgeInsets.all(16.w),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(22.r),
//         boxShadow: [
//           BoxShadow(
//             color: _navy.withOpacity(0.08),
//             blurRadius: 18,
//             offset: const Offset(0, 8),
//           ),
//         ],
//       ),
//       child: child,
//     );
//   }

//   Widget _buildRouteCard() {
//     return _sectionCard(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Route',
//             style: TextStyle(
//               color: _navy,
//               fontSize: 16.sp,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//           SizedBox(height: 14.h),
//           TextField(
//             controller: _fromController,
//             textCapitalization: TextCapitalization.words,
//             textInputAction: TextInputAction.next,
//             onChanged: (_) => setState(() {}),
//             decoration: _decoration(
//               label: 'From Place',
//               icon: Icons.trip_origin_rounded,
//             ),
//           ),
//           Align(
//             alignment: Alignment.centerRight,
//             child: InkWell(
//               borderRadius: BorderRadius.circular(20.r),
//               onTap: _swapPlaces,
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Icon(Icons.swap_vert_rounded, color: _blue, size: 20.w),
//                     SizedBox(width: 4.w),
//                     Text(
//                       'Swap',
//                       style: TextStyle(
//                         color: _blue,
//                         fontSize: 12.sp,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           TextField(
//             controller: _toController,
//             textCapitalization: TextCapitalization.words,
//             textInputAction: TextInputAction.next,
//             onChanged: (_) => setState(() {}),
//             decoration: _decoration(
//               label: 'To Place',
//               icon: Icons.location_on_rounded,
//             ),
//           ),
//           if (_routeError != null)
//             Padding(
//               padding: EdgeInsets.only(top: 6.h, left: 6.w),
//               child: Text(
//                 _routeError!,
//                 style: TextStyle(color: Colors.red, fontSize: 12.sp),
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget _buildQtyStepper() {
//     return Container(
//       height: 56.h,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(14.r),
//         border: Border.all(color: Colors.grey.shade300),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           IconButton(
//             onPressed: _qty > 1 ? () => setState(() => _qty--) : null,
//             icon: const Icon(Icons.remove_circle_rounded),
//             color: _navy,
//             disabledColor: Colors.grey.shade400,
//           ),
//           Text(
//             '$_qty',
//             style: TextStyle(
//               color: _navy,
//               fontSize: 18.sp,
//               fontWeight: FontWeight.w800,
//             ),
//           ),
//           IconButton(
//             onPressed: _qty < 99 ? () => setState(() => _qty++) : null,
//             icon: const Icon(Icons.add_circle_rounded),
//             color: _navy,
//             disabledColor: Colors.grey.shade400,
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTicketCard() {
//     return _sectionCard(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Ticket Details',
//             style: TextStyle(
//               color: _navy,
//               fontSize: 16.sp,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//           SizedBox(height: 14.h),
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Expanded(
//                 flex: 3,
//                 child: TextField(
//                   controller: _amountController,
//                   keyboardType:
//                       const TextInputType.numberWithOptions(decimal: true),
//                   inputFormatters: [
//                     FilteringTextInputFormatter.allow(
//                         RegExp(r'^\d*\.?\d{0,2}')),
//                   ],
//                   onChanged: (_) => setState(() {}),
//                   decoration: _decoration(
//                     label: 'Amount',
//                     icon: Icons.currency_rupee_rounded,
//                   ),
//                 ),
//               ),
//               SizedBox(width: 12.w),
//               Expanded(
//                 flex: 3,
//                 child: _buildQtyStepper(),
//               ),
//             ],
//           ),
//           SizedBox(height: 14.h),
//           InkWell(
//             borderRadius: BorderRadius.circular(14.r),
//             onTap: _pickDate,
//             child: InputDecorator(
//               decoration: _decoration(
//                 label: 'Date',
//                 icon: Icons.calendar_month_rounded,
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     formatter.format(selectedDate),
//                     style: TextStyle(
//                       color: _navy,
//                       fontSize: 15.sp,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   Icon(Icons.arrow_drop_down_rounded,
//                       color: Colors.grey.shade600),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTotalBar() {
//     return Container(
//       width: double.maxFinite,
//       padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           begin: Alignment.centerLeft,
//           end: Alignment.centerRight,
//           colors: [_navy, _blue],
//         ),
//         borderRadius: BorderRadius.circular(20.r),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Total Amount',
//                 style: TextStyle(
//                   color: Colors.white.withOpacity(0.75),
//                   fontSize: 12.sp,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               SizedBox(height: 2.h),
//               Text(
//                 '$_qty × ₹${_amount.toStringAsFixed(2)}',
//                 style: TextStyle(
//                   color: Colors.white.withOpacity(0.9),
//                   fontSize: 13.sp,
//                 ),
//               ),
//             ],
//           ),
//           Text(
//             '₹${_total.toStringAsFixed(2)}',
//             style: TextStyle(
//               color: _accent,
//               fontSize: 24.sp,
//               fontWeight: FontWeight.w800,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ------------------------------------------------------------------ build

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: _bg,
//       appBar: AppBar(
//         backgroundColor: _navy,
//         elevation: 0,
//         centerTitle: false,
//         leading: IconButton(
//           onPressed: () => Navigator.pop(context),
//           icon: const Icon(Icons.arrow_back_ios_new_rounded,
//               color: Colors.white, size: 20),
//         ),
//         systemOverlayStyle: const SystemUiOverlayStyle(
//           statusBarColor: _navy,
//           statusBarIconBrightness: Brightness.light,
//           statusBarBrightness: Brightness.dark,
//         ),
//         title: const Text(
//           "Ticket Billing",
//           style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
//         ),
//       ),
//       body: Consumer<BillingProvider>(builder: (__, billingProvider, _) {
//         return StackLoader(
//           inAsyncCall:
//               billingProvider.loaderState == LoaderState.loading ? true : false,
//           child: SingleChildScrollView(
//             reverse: true,
//             child: Container(
//               margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
//               child: Column(
//                 children: [
//                   _buildRouteCard(),
//                   SizedBox(height: 16.h),
//                   _buildTicketCard(),
//                   SizedBox(height: 16.h),
//                   _buildTotalBar(),
//                   SizedBox(height: 24.h),
//                   CommonButton(
//                     title: "Save and Add Next",
//                     onPressed: _isFormValid
//                         ? () async {
//                             FocusScope.of(context).unfocus();
//                             BillingProvider.address = false;
//                             _pushToProvider(billingProvider);
//                             await billingProvider.saveAndNextFunction();
//                             _resetForm();
//                           }
//                         : null,
//                   ),
//                   10.verticalSpace,
//                   CommonButton(
//                       title: "Save and Preview",
//                       colors: [
//                         billingProvider.poojaDetailsList.isEmpty
//                             ? _isFormValid
//                                 ? Colors.green
//                                 : Colors.green.withOpacity(.5)
//                             : Colors.green,
//                         billingProvider.poojaDetailsList.isEmpty
//                             ? _isFormValid
//                                 ? Colors.greenAccent
//                                 : Colors.greenAccent.withOpacity(.5)
//                             : Colors.greenAccent
//                       ],
//                       onPressed: billingProvider.poojaDetailsList.isEmpty
//                           ? _isFormValid
//                               ? () {
//                                   BillingProvider.address = false;
//                                   _pushToProvider(billingProvider);
//                                   billingProvider
//                                       .saveAndPreviewFunction(context);
//                                 }
//                               : null
//                           : () =>
//                               billingProvider.navigateToPreviewBill(context)),
//                   30.verticalSpace,
//                   Padding(
//                       padding: EdgeInsets.only(
//                           bottom: MediaQuery.of(context).viewInsets.bottom))
//                 ],
//               ),
//             ),
//           ),
//         );
//       }),
//     );
//   }
// }






import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:bus_ticket_register/common/common_button.dart';
import 'package:bus_ticket_register/common/common_functions.dart';
import 'package:bus_ticket_register/providers/billing_provider.dart';
import 'package:bus_ticket_register/screens/billing/place_picker_screen.dart';
import 'package:bus_ticket_register/services/provider_helper_class.dart';
import 'package:bus_ticket_register/widgets/stack_loader.dart';

class Billing extends StatefulWidget {
  const Billing({super.key});
  @override
  State<Billing> createState() => _BillingState();
}

class _BillingState extends State<Billing> {
  // Same palette as Splash, Login and Home.
  static const Color _navy = Color(0xFF0B2A5B);
  static const Color _blue = Color(0xFF1E5AA8);
  static const Color _accent = Color(0xFFFFC107);
  static const Color _bg = Color(0xFFF4F7FC);

  final DateFormat formatter = DateFormat('dd-MM-yyyy');
  DateTime selectedDate = DateTime.now();

  final TextEditingController _fromController = TextEditingController();
  final TextEditingController _toController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  int _qty = 1;

  /// TODO: replace with the real places list (API / BillingProvider, and a
  /// local cache so it also works offline). Sample data for now.
  List<String> get _places => const [
        'Thrissur',
        'Ernakulam',
        'Kochi',
        'Palakkad',
        'Guruvayur',
        'Chalakudy',
        'Angamaly',
        'Kozhikode',
        'Kannur',
        'Irinjalakuda',
        'Kodungallur',
        'Perumbavoor',
      ];

  @override
  void initState() {
    CommonFunctions.afterInit(() {
      context.read<BillingProvider>().getInitialDataList();
    });
    super.initState();
  }

  @override
  void dispose() {
    _fromController.dispose();
    _toController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  // ------------------------------------------------------------- helpers

  double get _amount => double.tryParse(_amountController.text.trim()) ?? 0;
  double get _total => _amount * _qty;

  bool get _isFormValid =>
      _fromController.text.trim().isNotEmpty &&
      _toController.text.trim().isNotEmpty &&
      _fromController.text.trim().toLowerCase() !=
          _toController.text.trim().toLowerCase() &&
      _amount > 0 &&
      _qty >= 1;

  Future<String?> _pickPlace({
    required String title,
    String? selected,
    String? excluded,
  }) {
    FocusScope.of(context).unfocus();
    return Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (_) => PlacePickerScreen(
          title: title,
          places: _places,
          selected: selected,
          excluded: excluded,
        ),
      ),
    );
  }

  /// Opens the From list. After a place is chosen, the To list opens
  /// automatically (unless a valid To place is already selected).
  Future<void> _selectFrom() async {
    final result = await _pickPlace(
      title: 'Select From Place',
      selected: _fromController.text,
    );
    if (result == null || !mounted) return;

    setState(() {
      _fromController.text = result;
      if (_toController.text.trim().toLowerCase() == result.toLowerCase()) {
        _toController.clear();
      }
    });

    if (_toController.text.trim().isEmpty) {
      await _selectTo();
    }
  }

  Future<void> _selectTo() async {
    final result = await _pickPlace(
      title: 'Select To Place',
      selected: _toController.text,
      excluded: _fromController.text,
    );
    if (result == null || !mounted) return;
    setState(() => _toController.text = result);
  }

  void _swapPlaces() {
    final temp = _fromController.text;
    _fromController.text = _toController.text;
    _toController.text = temp;
    setState(() {});
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: _navy,
            onPrimary: Colors.white,
            onSurface: _navy,
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  void _resetForm() {
    _fromController.clear();
    _toController.clear();
    _amountController.clear();
    setState(() => _qty = 1);
  }

  /// TODO: hook the five values into BillingProvider here, before the save
  /// calls run. Values: _fromController.text, _toController.text, _amount,
  /// _qty, selectedDate. (Send BillingProvider and I'll wire this.)
  void _pushToProvider(BillingProvider billingProvider) {}

  // ------------------------------------------------------------- UI parts

  InputDecoration _decoration({
    required String label,
    required IconData icon,
    String? prefixText,
    Widget? suffixIcon,
  }) {
    OutlineInputBorder border(Color color, [double width = 1]) =>
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(14.r),
          borderSide: BorderSide(color: color, width: width),
        );
    return InputDecoration(
      labelText: label,
      prefixText: prefixText,
      prefixIcon: Icon(icon, color: _blue, size: 22.w),
      suffixIcon: suffixIcon,
      labelStyle: TextStyle(color: Colors.grey.shade600, fontSize: 14.sp),
      floatingLabelStyle: const TextStyle(color: _navy),
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 14.w),
      enabledBorder: border(Colors.grey.shade300),
      focusedBorder: border(_navy, 1.5),
      border: border(Colors.grey.shade300),
    );
  }

  Widget _sectionCard({required Widget child}) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22.r),
        boxShadow: [
          BoxShadow(
            color: _navy.withOpacity(0.08),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }

  /// Read-only field that opens the place list screen on tap.
  Widget _buildPlaceField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    required VoidCallback onTap,
  }) {
    final value = controller.text.trim();
    return InkWell(
      borderRadius: BorderRadius.circular(14.r),
      onTap: onTap,
      child: InputDecorator(
        isEmpty: value.isEmpty,
        decoration: _decoration(
          label: label,
          icon: icon,
          suffixIcon:
              Icon(Icons.chevron_right_rounded, color: Colors.grey.shade600),
        ),
        child: Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: _navy,
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildRouteCard() {
    return _sectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Route',
            style: TextStyle(
              color: _navy,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 14.h),
          _buildPlaceField(
            label: 'From Place',
            icon: Icons.trip_origin_rounded,
            controller: _fromController,
            onTap: _selectFrom,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              borderRadius: BorderRadius.circular(20.r),
              onTap: _swapPlaces,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.swap_vert_rounded, color: _blue, size: 20.w),
                    SizedBox(width: 4.w),
                    Text(
                      'Swap',
                      style: TextStyle(
                        color: _blue,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          _buildPlaceField(
            label: 'To Place',
            icon: Icons.location_on_rounded,
            controller: _toController,
            onTap: _selectTo,
          ),
        ],
      ),
    );
  }

  Widget _buildQtyStepper() {
    return Container(
      height: 56.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: _qty > 1 ? () => setState(() => _qty--) : null,
            icon: const Icon(Icons.remove_circle_rounded),
            color: _navy,
            disabledColor: Colors.grey.shade400,
          ),
          Text(
            '$_qty',
            style: TextStyle(
              color: _navy,
              fontSize: 18.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
          IconButton(
            onPressed: _qty < 99 ? () => setState(() => _qty++) : null,
            icon: const Icon(Icons.add_circle_rounded),
            color: _navy,
            disabledColor: Colors.grey.shade400,
          ),
        ],
      ),
    );
  }

  Widget _buildTicketCard() {
    return _sectionCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ticket Details',
            style: TextStyle(
              color: _navy,
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 14.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 3,
                child: TextField(
                  controller: _amountController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                  ],
                  onChanged: (_) => setState(() {}),
                  decoration: _decoration(
                    label: 'Amount',
                    icon: Icons.currency_rupee_rounded,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                flex: 3,
                child: _buildQtyStepper(),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          InkWell(
            borderRadius: BorderRadius.circular(14.r),
            onTap: _pickDate,
            child: InputDecorator(
              decoration: _decoration(
                label: 'Date',
                icon: Icons.calendar_month_rounded,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formatter.format(selectedDate),
                    style: TextStyle(
                      color: _navy,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Icon(Icons.arrow_drop_down_rounded,
                      color: Colors.grey.shade600),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalBar() {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [_navy, _blue],
        ),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Total Amount',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.75),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                '$_qty × ₹${_amount.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 13.sp,
                ),
              ),
            ],
          ),
          Text(
            '₹${_total.toStringAsFixed(2)}',
            style: TextStyle(
              color: _accent,
              fontSize: 24.sp,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------------ build

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _navy,
        elevation: 0,
        centerTitle: false,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Colors.white, size: 20),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: _navy,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
        title: const Text(
          "Ticket Billing",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
      ),
      body: Consumer<BillingProvider>(builder: (__, billingProvider, _) {
        return StackLoader(
          inAsyncCall:
              billingProvider.loaderState == LoaderState.loading ? true : false,
          child: SingleChildScrollView(
            reverse: true,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                children: [
                  _buildRouteCard(),
                  SizedBox(height: 16.h),
                  _buildTicketCard(),
                  SizedBox(height: 16.h),
                  _buildTotalBar(),
                  SizedBox(height: 24.h),
                  CommonButton(
                    title: "Save and Add Next",
                    onPressed: _isFormValid
                        ? () async {
                            FocusScope.of(context).unfocus();
                            BillingProvider.address = false;
                            _pushToProvider(billingProvider);
                            await billingProvider.saveAndNextFunction();
                            _resetForm();
                          }
                        : null,
                  ),
                  10.verticalSpace,
                  CommonButton(
                      title: "Save and Preview",
                      colors: [
                        billingProvider.poojaDetailsList.isEmpty
                            ? _isFormValid
                                ? Colors.green
                                : Colors.green.withOpacity(.5)
                            : Colors.green,
                        billingProvider.poojaDetailsList.isEmpty
                            ? _isFormValid
                                ? Colors.greenAccent
                                : Colors.greenAccent.withOpacity(.5)
                            : Colors.greenAccent
                      ],
                      onPressed: billingProvider.poojaDetailsList.isEmpty
                          ? _isFormValid
                              ? () {
                                  BillingProvider.address = false;
                                  _pushToProvider(billingProvider);
                                  billingProvider
                                      .saveAndPreviewFunction(context);
                                }
                              : null
                          : () =>
                              billingProvider.navigateToPreviewBill(context)),
                  30.verticalSpace,
                  Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom))
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}