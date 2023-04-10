import 'package:flutter/material.dart';
import 'package:latihan_state_management/dashboard.dart';
import 'package:latihan_state_management/provider/screens/home_page_view.dart';
import 'package:latihan_state_management/provider/screens/tes.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const DasboardPageView(),

  '/provider' : (context) => const HomeProviderPageView(),
  '/provider/home' :(context) => const HomeProviderPageView(),

  '/tes' :(context) => const TabBarViewPage(),


};