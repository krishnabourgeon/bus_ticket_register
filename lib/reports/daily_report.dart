// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:bus_ticket_register/common/color_palette.dart';
// import 'package:bus_ticket_register/common/date_picker.dart';

// class DailyReport extends StatefulWidget {
//   const DailyReport({super.key});
//   @override
//   State<DailyReport> createState() => _DailyReportState();
// }

// class _DailyReportState extends State<DailyReport> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: Center(
//           child: InkWell(
//             onTap: (() => Navigator.pop(context)),
//             child: SizedBox(
//                 height: 25.h,
//                 width: 25.h,
//                 child: Image.asset("assets/image/backIcon.png")),
//           ),
//         ),
//         systemOverlayStyle: const SystemUiOverlayStyle(
//           statusBarColor: Colors.white,
//           statusBarIconBrightness: Brightness.dark,
//           statusBarBrightness: Brightness.light,
//         ),
//         title: const Text(
//           "Daily Collection",
//           style: TextStyle(color: Colors.black),
//         ),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 18),
//                 child: Row(
//                   children: [
//                     Flexible(
//                       child: PunnyamDatePicker(
//                         title: "From Date",
//                         onChanged: (date) => debugPrint(date),
//                       ),
//                     ),
//                     5.horizontalSpace,
//                     Flexible(
//                       child: PunnyamDatePicker(
//                         title: "To Date",
//                         onChanged: (date) => debugPrint(date),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               20.verticalSpace,
//               Container(
//                 margin: EdgeInsets.symmetric(horizontal: 20.w),
//                 padding: EdgeInsets.all(20.w),
//                 height: 200.h,
//                 width: double.maxFinite,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20.r),
//                   color: ColorPalette.orange,
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       "Counter 1",
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold, color: Colors.white),
//                     ),
//                     5.verticalSpace,
//                     const Text(
//                       "Cash: 4500",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                     5.verticalSpace,
//                     const Text(
//                       "QR: 10",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                     5.verticalSpace,
//                     const Text(
//                       "Postal : 0",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                     5.verticalSpace,
//                     const Text(
//                       "NEFT: 10",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                     5.verticalSpace,
//                     const Text(
//                       "Others: 10",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ],
//                 ),
//               ),
//               20.verticalSpace,
//               Container(
//                 margin: EdgeInsets.symmetric(horizontal: 20.w),
//                 padding: EdgeInsets.all(20.w),
//                 height: 200.h,
//                 width: double.maxFinite,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20.r),
//                   color: ColorPalette.orange,
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const Text(
//                       "Counter 1",
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold, color: Colors.white),
//                     ),
//                     5.verticalSpace,
//                     const Text(
//                       "Cash: 4500",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                     5.verticalSpace,
//                     const Text(
//                       "QR: 10",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                     5.verticalSpace,
//                     const Text(
//                       "Postal : 0",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                     5.verticalSpace,
//                     const Text(
//                       "NEFT: 10",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                     5.verticalSpace,
//                     const Text(
//                       "Others: 10",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           Container(
//             height: 100.h,
//             width: double.maxFinite,
//             color: Colors.green,
//             padding: EdgeInsets.all(20.w),
//             child: const Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Total Cash: 9000 ",
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold, color: Colors.white),
//                 ),
//                 Text(
//                   "Total Booking: 10000 ",
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold, color: Colors.white),
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:bus_ticket_register/common/color_palette.dart';
import 'package:bus_ticket_register/common/date_picker.dart';
import 'package:bus_ticket_register/providers/ticket_provider.dart';
import 'package:bus_ticket_register/models/reports_model.dart';

class DailyReport extends StatefulWidget {
  const DailyReport({super.key});

  @override
  State<DailyReport> createState() => _DailyReportState();
}

class _DailyReportState extends State<DailyReport> {
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();

  final DateFormat apiDateFormat = DateFormat('yyyy-MM-dd');
  final DateFormat displayDateFormat = DateFormat('dd-MM-yyyy');

  @override
  void initState() {
    super.initState();

    // Load today's report when the screen opens.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _fetchReport();
    });
  }

  String _apiDate(DateTime date) {
    return apiDateFormat.format(date);
  }

  DateTime? _parseSelectedDate(String value) {
    final input = value.trim();

    // Supports common date formats returned by the date picker.
    for (final format in [
      DateFormat('yyyy-MM-dd'),
      DateFormat('dd-MM-yyyy'),
      DateFormat('dd/MM/yyyy'),
      DateFormat('yyyy/MM/dd'),
    ]) {
      try {
        return format.parseStrict(input);
      } catch (_) {
        // Try the next format.
      }
    }

    return null;
  }

  Future<void> _fetchReport() async {
    if (fromDate.isAfter(toDate)) {
      _showMessage('From Date cannot be after To Date');
      return;
    }

    await context.read<TicketProvider>().getReports(
          fromDate: _apiDate(fromDate),
          toDate: _apiDate(toDate),
        );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  String _money(num amount) {
    return NumberFormat('#,##,##0.##', 'en_IN').format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Center(
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: SizedBox(
              height: 25.h,
              width: 25.h,
              child: Image.asset('assets/image/backIcon.png'),
            ),
          ),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        title: const Text(
          'Daily Collection',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Consumer<TicketProvider>(
        builder: (context, provider, child) {
          final ReportsModel? report = provider.reportsResponse;

          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Date filters
                      Container(
                        padding: EdgeInsets.all(14.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: PunnyamDatePicker(
                                    title: 'From Date',
                                    onChanged: (value) {
                                      final selected =
                                          _parseSelectedDate(value);
                                      if (selected == null) {
                                        _showMessage(
                                          'Invalid From Date format',
                                        );
                                        return;
                                      }

                                      setState(() {
                                        fromDate = selected;
                                      });
                                    },
                                  ),
                                ),
                                10.horizontalSpace,
                                Expanded(
                                  child: PunnyamDatePicker(
                                    title: 'To Date',
                                    onChanged: (value) {
                                      final selected =
                                          _parseSelectedDate(value);
                                      if (selected == null) {
                                        _showMessage(
                                          'Invalid To Date format',
                                        );
                                        return;
                                      }

                                      setState(() {
                                        toDate = selected;
                                      });
                                    },
                                  ),
                                ),
                              ],
                            ),
                            14.verticalSpace,
                            SizedBox(
                              width: double.infinity,
                              height: 46.h,
                              child: ElevatedButton.icon(
                                onPressed: provider.isReportsLoading
                                    ? null
                                    : _fetchReport,
                                icon: const Icon(Icons.filter_alt),
                                label: const Text('Apply Filter'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorPalette.orange,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(12.r),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      20.verticalSpace,

                      if (provider.isReportsLoading)
                        SizedBox(
                          height: 250.h,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        )
                      else if (provider.reportErrorMessage != null)
                        _buildError(provider.reportErrorMessage!)
                      else if (report == null)
                        _buildEmpty(
                          'No report loaded. Please apply the date filter.',
                        )
                      else ...[
                        // Report period
                        Text(
                          'Collection Details',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF0B2A5B),
                          ),
                        ),
                        5.verticalSpace,
                        Text(
                          '${displayDateFormat.format(report.filters.fromDate)}'
                          ' - '
                          '${displayDateFormat.format(report.filters.toDate)}',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 13.sp,
                          ),
                        ),
                        14.verticalSpace,

                        // Summary totals from the API
                        _buildSummaryCard(report.summary),

                        20.verticalSpace,

                        Text(
                          'Daily Breakdown',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF0B2A5B),
                          ),
                        ),
                        12.verticalSpace,

                        if (report.dailyCollection.isEmpty)
                          _buildEmpty(
                            'No collection records found for this period.',
                          )
                        else
                          ...report.dailyCollection.map(
                            (item) => _buildDailyCard(item),
                          ),
                      ],
                    ],
                  ),
                ),
              ),

              // Bottom total
              if (!provider.isReportsLoading && report != null)
                _buildBottomTotals(report.summary),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSummaryCard(Summary summary) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.w),
      decoration: BoxDecoration(
        color: ColorPalette.orange,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Total Collection',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          8.verticalSpace,
          Text(
            '₹ ${_money(summary.totalAmount)}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          16.verticalSpace,
          Row(
            children: [
              Expanded(
                child: _summaryItem(
                  'Total Tickets',
                  '${summary.totalTickets}',
                  Icons.confirmation_number_outlined,
                ),
              ),
              Expanded(
                child: _summaryItem(
                  'Passengers',
                  '${summary.totalPassengers}',
                  Icons.people_outline,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _summaryItem(String title, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 24.sp),
        8.horizontalSpace,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12.sp,
                ),
              ),
              3.verticalSpace,
              Text(
                value,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDailyCard(Summary item) {
    final dateText = item.date == null
        ? 'Date unavailable'
        : displayDateFormat.format(item.date!);

    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: const Color(0xFFE5EAF2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(9.w),
                decoration: BoxDecoration(
                  color: ColorPalette.orange.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.calendar_month,
                  color: ColorPalette.orange,
                ),
              ),
              12.horizontalSpace,
              Expanded(
                child: Text(
                  dateText,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0B2A5B),
                  ),
                ),
              ),
              Text(
                '₹ ${_money(item.totalAmount)}',
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.green.shade700,
                ),
              ),
            ],
          ),
          16.verticalSpace,
          const Divider(height: 1),
          12.verticalSpace,
          Row(
            children: [
              Expanded(
                child: _detailItem(
                  'Tickets',
                  '${item.totalTickets}',
                ),
              ),
              Expanded(
                child: _detailItem(
                  'Passengers',
                  '${item.totalPassengers}',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _detailItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.grey.shade600,
          ),
        ),
        5.verticalSpace,
        Text(
          value,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF0B2A5B),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomTotals(Summary summary) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 16.h,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF198754),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Total Passengers: ${summary.totalPassengers}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            6.verticalSpace,
            Text(
              'Total Tickets: ${summary.totalTickets}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            6.verticalSpace,
            Text(
              'Total Collection: ₹ ${_money(summary.totalAmount)}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildError(String message) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 42,
            ),
            10.verticalSpace,
            Text(
              message,
              textAlign: TextAlign.center,
            ),
            12.verticalSpace,
            OutlinedButton(
              onPressed: _fetchReport,
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmpty(String message) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      child: Column(
        children: [
          Icon(
            Icons.receipt_long_outlined,
            size: 42.sp,
            color: Colors.grey,
          ),
          10.verticalSpace,
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
