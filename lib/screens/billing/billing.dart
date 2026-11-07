import 'package:bus_ticket_register/providers/ticket_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:bus_ticket_register/common/common_button.dart';
import 'package:bus_ticket_register/common/common_functions.dart';
import 'package:bus_ticket_register/providers/billing_provider.dart';
import 'package:bus_ticket_register/screens/billing/place_picker_screen.dart';
import 'package:bus_ticket_register/services/helpers.dart';
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

Future<PlaceOption?> _pickPlace({
  required String title,
  required List<PlaceOption> places,
  int? selected,
  int? excluded,
}) {
  FocusScope.of(context).unfocus();

  return Navigator.push<PlaceOption>(
    context,
    MaterialPageRoute(
      builder: (_) => PlacePickerScreen(
        title: title,
        places: places,
        selected: selected,
        excluded: excluded,
      ),
    ),
  );
}

  // /// Opens the From list. After a place is chosen, the To list opens
  // /// automatically (unless a valid To place is already selected).
  // Future<void> _selectFrom() async {
  //   final result = await _pickPlace(
  //     title: 'Select From Place',
  //     selected: _fromController.text,
  //   );
  //   if (result == null || !mounted) return;

  //   setState(() {
  //     _fromController.text = result;
  //     if (_toController.text.trim().toLowerCase() == result.toLowerCase()) {
  //       _toController.clear();
  //     }
  //   });

  //   if (_toController.text.trim().isEmpty) {
  //     await _selectTo();
  //   }
  // }

  // Future<void> _selectTo() async {
  //   final result = await _pickPlace(
  //     title: 'Select To Place',
  //     selected: _toController.text,
  //     excluded: _fromController.text,
  //   );
  //   if (result == null || !mounted) return;
  //   setState(() => _toController.text = result);
  // }


  Future<void> _fetchFare(BillingProvider billingProvider) async {
    if (billingProvider.fromPlaceId == null ||
        billingProvider.toPlaceId == null) {
      return;
    }

    final fare = await billingProvider.getFareDetails(
      fromplace: billingProvider.fromPlaceId!,
      toplace: billingProvider.toPlaceId!,
    );

    if (!mounted) return;

    if (fare != null) {
      setState(() {
        _amountController.text = fare.unitFare.toString();
      });
    } else {
      // Don't leave a stale fare from the previous selection.
      setState(() => _amountController.clear());
      if (billingProvider.fareErrorMessage != null) {
        Helpers.successToast(billingProvider.fareErrorMessage!);
      }
    }
  }

  /// Makes sure the stops are loaded; shows the API error if they can't be.
  Future<bool> _ensurePlaces(BillingProvider billingProvider) async {
    if (billingProvider.initialDataList?.places.isNotEmpty ?? false) {
      return true;
    }
    final loaded = await billingProvider.getInitialDataList();
    if (!loaded && mounted) {
      Helpers.successToast(
          billingProvider.fareErrorMessage ?? 'Unable to load places');
    }
    return loaded && mounted;
  }

  Future<void> _selectFrom() async {
    final billingProvider = context.read<BillingProvider>();
    if (!await _ensurePlaces(billingProvider)) return;

    final places = billingProvider.initialDataList!.places;
    final selectedPlaceId = billingProvider.fromPlaceId;

    final PlaceOption? selected = await _pickPlace(
      title: 'Select From Place',
      places: places,
      selected: selectedPlaceId,
    );

    if (selected == null || !mounted) return;

    setState(() {
      _fromController.text = selected.name;
      billingProvider.fromPlaceId = selected.id;

      // If the selected place is same as To place, clear To.
      if (billingProvider.toPlaceId == selected.id) {
        _toController.clear();
        billingProvider.toPlaceId = null;
      }
    });

    // Automatically open To list if not selected.
    if (billingProvider.toPlaceId == null) {
      await _selectTo();
    } else {
      await _fetchFare(billingProvider);
    }
  }

  Future<void> _selectTo() async {
    final billingProvider = context.read<BillingProvider>();
    if (!await _ensurePlaces(billingProvider)) return;

    final places = billingProvider.initialDataList!.places;
    final selectedPlaceId = billingProvider.toPlaceId;

    final PlaceOption? selected = await _pickPlace(
      title: 'Select To Place',
      places: places,
      selected: selectedPlaceId,
      excluded: billingProvider.fromPlaceId,
    );

    if (selected == null || !mounted) return;

    setState(() {
      _toController.text = selected.name;
      billingProvider.toPlaceId = selected.id;
    });

    if (billingProvider.fromPlaceId != null) {
      await _fetchFare(billingProvider);
    }
  }

  void _swapPlaces() {
    final billingProvider = context.read<BillingProvider>();
    final tempText = _fromController.text;
    _fromController.text = _toController.text;
    _toController.text = tempText;

    final tempId = billingProvider.fromPlaceId;
    billingProvider.fromPlaceId = billingProvider.toPlaceId;
    billingProvider.toPlaceId = tempId;

    setState(() {});

    if (billingProvider.fromPlaceId != null &&
        billingProvider.toPlaceId != null) {
      _fetchFare(billingProvider);
    }
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
    final billingProvider = context.read<BillingProvider>();
    billingProvider.clearPlaces();
    setState(() => _qty = 1);
  }

  void _pushToProvider(BillingProvider billingProvider) {
    billingProvider.fromPlaceName = _fromController.text.trim();
    billingProvider.toPlaceName = _toController.text.trim();
    billingProvider.rateController.text = _amount.toString();
    billingProvider.qtyController.text = _qty.toString();
    billingProvider.totalRateController.text = _total.toString();
    billingProvider.paidAmountController.text = _total.toString();
    billingProvider.date = formatter.format(selectedDate);
    billingProvider.fromDate = DateFormat('yyyy-MM-dd').format(selectedDate);
  }

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
            color: _navy.withValues(alpha: 0.08),
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

  Widget _buildTicketCard({bool isFareLoading = false}) {
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
                    suffixIcon: isFareLoading
                        ? Transform.scale(
                            scale: 0.45,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: _blue,
                            ),
                          )
                        : null,
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
                  color: Colors.white.withValues(alpha: 0.75),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                '$_qty × ₹${_amount.toStringAsFixed(2)}',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.9),
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
        actions: [
          IconButton(
            tooltip: "Reset Form",
            onPressed: _resetForm,
            icon: const Icon(Icons.refresh_rounded, color: Colors.white),
          ),
        ],
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
                  _buildTicketCard(isFareLoading: billingProvider.isFareLoading),
                  SizedBox(height: 16.h),
                  _buildTotalBar(),
                  SizedBox(height: 24.h),
                  // CommonButton(
                  //   title: "Save and Add Next",
                  //   onPressed: _isFormValid
                  //       ? () async {
                  //           FocusScope.of(context).unfocus();
                  //           BillingProvider.address = false;
                  //           _pushToProvider(billingProvider);
                  //           await billingProvider.saveAndNextFunction();
                  //           _resetForm();
                  //         }
                  //       : null,
                  // ),
                  // 10.verticalSpace,
                  CommonButton(
                      title: "Save",
                      colors: [
                        billingProvider.poojaDetailsList.isEmpty
                            ? _isFormValid
                                ? _navy
                                : _blue
                            : _navy,
                        billingProvider.poojaDetailsList.isEmpty
                            ? _isFormValid
                                ? _navy
                                : _blue
                            : _navy
                      ],
                      // onPressed: billingProvider.poojaDetailsList.isEmpty
                      //     ? _isFormValid
                      //         ? () {
                      //             BillingProvider.address = false;
                      //             _pushToProvider(billingProvider);
                      //             billingProvider
                      //                 .saveAndPreviewFunction(context);
                      //           }
                      //         : null
                      //     : () =>
                      //         billingProvider.navigateToPreviewBill(context)
                      onPressed: _isFormValid
                        ?  () {
                              final bp = context.read<BillingProvider>();
                              context.read<TicketProvider>().saveTicket(
                                    fromPlaceId: bp.fromPlaceId!,
                                    toPlaceId: bp.toPlaceId!,
                                    passengers: _qty,
                                    fare: _amount,
                                    date: selectedDate,
                                      onSuccess: () {
                                        final t = context.read<TicketProvider>().saveTicketResponse!.ticket;
                                        Helpers.successToast('Ticket ${t.ticketNo} saved');
                                        _resetForm();          // or print / open a ticket preview here
                                      },
                                      onFailure: () => Helpers.successToast(
                                        context.read<TicketProvider>().errorMessage ?? 'Unable to save ticket'),
                                      );
                                    }
                                : null,
                            ),
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



   static const MethodChannel _printerChannel =
      MethodChannel('cloudpos/printer');

  // Future<bool> biPosPrint(BillingProvider previewBillProvider) async {
  //   DateTime time = DateTime.now();
  //   String today = "${time.day}/${time.month}/${time.year}";

  //   final data = previewBillProvider.saveBillResponse?.details ?? [];
  //   final persons = previewBillProvider.person;
  //   final datePattern = RegExp(r'\d{2}-\d{2}-\d{4}');

  //   final items = <Map<String, dynamic>>[];
  //   for (int i = 0; i < data.length; i++) {
  //     final match = datePattern.firstMatch("${data[i].date}");
  //     items.add({
  //       "index": i + 1,
  //       "deity": data[i].deity ?? '',
  //       "name": i < persons.length ? (persons[i].name ?? '') : '',
  //       "star": data[i].star ?? '',
  //       "pooja": data[i].pooja ?? '',
  //       "qty": data[i].qty ?? '',
  //       "rate": data[i].rate ?? '',
  //       "date": match?.group(0) ?? '',
  //       "address": data[i].address ?? '',
  //     });
  //   }

  //   try {
  //     await _printerChannel.invokeMethod('printReceipt', {
  //       "shop": previewBillProvider.temple?.name ?? '',
  //       "shopaddress": previewBillProvider.temple?.addressLine1 ?? '',
  //       "shopaddress2": previewBillProvider.temple?.addressLine2 ?? '',
  //       "phone": previewBillProvider.temple?.phone ?? '',
  //       "website": previewBillProvider.temple?.website ?? '',
  //       "bill": previewBillProvider.summary?.id ?? 0,
  //       "billdate": today,
  //       "mode": previewBillProvider.summary?.mode ?? '',
  //       "total": previewBillProvider.summary?.total ?? '',
  //       "items": items,
  //       "logo": previewBillProvider.imageData,
  //     });
  //     return true;
  //   } on PlatformException catch (e) {
  //     Helpers.successToast("Print failed: ${e.message}");
  //     return false;
  //   }
  // }


  
Future<bool> biPosPrint(Map<String, dynamic> response) async {
  try {
    final ticket = Map<String, dynamic>.from(
      response['ticket'] ?? {},
    );

    final bus = Map<String, dynamic>.from(
      ticket['bus'] ?? {},
    );

    final issuedAt = ticket['issued_at']?.toString() ?? '';
    final time = issuedAt.contains(' ')
        ? issuedAt.split(' ').last
        : issuedAt;

    await _printerChannel.invokeMethod('printReceipt', {
      'shop': bus['name']?.toString() ?? '',
      'phone': time,
      'website': bus['bus_no']?.toString() ?? '',
      'billdate': ticket['travel_date']?.toString() ?? '',
      'mode': ticket['passengers']?.toString() ?? '0',
      'total': ticket['total_amount']?.toString() ?? '0',
      'unitFare': ticket['unit_fare']?.toString() ?? '0',
      'fromPlace': ticket['from_place']?.toString() ?? '',
      'toPlace': ticket['to_place']?.toString() ?? '',

    });

    return true;
  } on PlatformException catch (e) {
    Helpers.successToast('Print failed: ${e.message}');
    return false;
  } catch (e) {
    Helpers.successToast('Print failed: $e');
    return false;
  }
}


}