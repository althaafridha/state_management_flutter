import 'package:flutter/material.dart';
import 'package:latihan_state_management/dashboard.dart';
import 'package:latihan_state_management/screens/home_view/home_page_view.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const DasboardPageView(),

  '/provider' : (context) => const HomeProviderPageView(),
  '/provider/home' :(context) => const HomeProviderPageView(),
};