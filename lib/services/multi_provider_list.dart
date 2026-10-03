import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:bus_ticket_register/providers/auth_provider.dart';
import 'package:bus_ticket_register/providers/bill_details_provider.dart';
import 'package:bus_ticket_register/providers/create_cutomer_provider.dart';
import 'package:bus_ticket_register/providers/home_provider.dart';
import '../providers/billing_provider.dart';

class MultiProviderList {
  static List<SingleChildWidget> providerList = [
    ChangeNotifierProvider(create: (_) => BillingProvider()),
    ChangeNotifierProvider(create: (_) => AuthProvider()),
    ChangeNotifierProvider(create: (_) => HomeProvider()),
    ChangeNotifierProvider(create: (_) => CreateCustomerProvider()),
    ChangeNotifierProvider(create: (_) => BillDetailprovider()),
    // ChangeNotifierProvider(create: (_) => PreviewBillProvider())
  ];
}
