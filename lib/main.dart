import 'package:flutter_thailand_provinces/flutter_thailand_provinces.dart';
import "package:homealone/pages/Navbar/mainpages.dart";
import 'package:homealone/pages/addhome.dart';
import 'package:homealone/pages/addrent.dart';
import 'package:homealone/pages/adduser.dart';
import 'package:homealone/pages/home.dart';
import 'package:homealone/pages/house/HouseListForRent.dart';
import 'package:homealone/pages/house/addimages.dart';
import 'package:homealone/pages/house/editImage.dart';
import 'package:homealone/pages/house/edithouse.dart';
import 'package:homealone/pages/house/homeInfo.dart';
import 'package:homealone/pages/house/myhouse.dart';
import 'package:homealone/pages/house/payment/PreAddTransaction.dart';
import 'package:homealone/pages/house/payment/Transaction.dart';
import 'package:homealone/pages/login.dart';
import 'package:flutter/material.dart';
import 'package:homealone/pages/map/map.dart';
import 'package:homealone/pages/payment/editpayment.dart';
import 'package:homealone/pages/payment/elecpay.dart';
import 'package:homealone/pages/payment/elecpay_tenant.dart';
import 'package:homealone/pages/payment/rentpay.dart';
import 'package:homealone/pages/payment/rentpay_tenant.dart';
import 'package:homealone/pages/payment/waterpay.dart';
import 'package:homealone/pages/payment/waterpay_tenant.dart';
import 'package:homealone/pages/prelogin.dart';
import 'package:homealone/pages/profile.dart';
import 'package:homealone/pages/register.dart';
import 'package:homealone/pages/regmanager.dart';
import 'package:homealone/pages/reviewhome/prereview.dart';
import 'package:homealone/pages/reviewhome/reviewpage.dart';
import 'package:homealone/pages/search/search.dart';
import 'package:homealone/pages/users/ManagerEditProfile.dart';
import 'package:homealone/pages/users/editmanager.dart';
import 'package:homealone/theme.dart';
import 'package:intl/date_symbol_data_local.dart';


import 'pages/Navbar/mainpages.dart';
import 'pages/income.dart';


void main() async {

  // initializeDateFormatting('th',null);
  WidgetsFlutterBinding.ensureInitialized();
  await ThailandProvincesDatabase.init();
  // Intl.defaultLocale = 'th';
  // initializeDateFormatting();

  runApp(MyApp());
}



class MyApp extends StatelessWidget {
  final settings = ValueNotifier(ThemeSettings(
    sourceColor:  const Color(0xff11e4af),
    themeMode: ThemeMode.system,
  ));

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('th');
    final theme = ThemeProvider.of(context);
    return MaterialApp(
      home: MainPages(),
      debugShowCheckedModeBanner: false,
      // theme: theme.light(settings.value.sourceColor),
      // darkTheme: theme.dark(settings.value.sourceColor),
      // themeMode: theme.themeMode(),
      title: 'Home Alone',
      routes: {
        '/home-page': (context) => HomePage(),
        '/login-page': (context) => LoginPage(),
        '/main-page': (context) => MainPages(),
        '/Addrent-page': (context) => AddRent(),
        '/Adduser-page': (context) => AddUser(),
        '/Addhome-page': (context) => AddHome(),
        '/Profile-page': (context) => ProfilePage(),
        '/Search-page': (context) => SearchPage(),
        '/Map-page': (context) => MapPage(),
        '/Prelogin-page': (context) => PreLogin(),
        '/Register-page': (context) => RegisterPage(),
        '/Regmanager-page': (context) => RegManagerPage(),
        '/Waterpay-page': (context) => WaterpayPage(),
        '/Elecpay-page': (context) => ElecpayPage(),
        '/Rentpay-page': (context) => RentpayPage(),
        '/Myhouse-page': (context) => MyHouse(),
        '/Editmanager-page': (context) => EditManager(),
        '/Edithouse-page': (context) => EditHouse(),
        '/Homeinfo-page': (context) => InfoPage(),
        '/ManagerEditProfile-page':(context) => ManagerEditProfile(),
        '/PreRent-page':(context) => PreRent(),
        '/Income-page':(context) => IncomePage(),
        '/PreTransaction-page':(context) => PreAddTransactions(),
        '/Transaction-page':(context) => Transactions(),
        '/ElecPayTenant-page':(context) => elecTenant(),
        '/RentPayTenant-page':(context) => rentTenant(),
        '/WaterPayTenant-page':(context) => waterTenant(),
        '/EditPayment-page':(context) => EditPayment(),
         '/Review-page': (context) => ReviewPage(),
        '/PreReview-page':(context) => PreReview(),
        '/EditImageHouse-page':(context) => EditImageHouse(),
        '/AddImages-page':(context) => AddImages()

      },
    );
  }
}
