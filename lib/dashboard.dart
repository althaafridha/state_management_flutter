import 'package:flutter/material.dart';

class DasboardPageView extends StatefulWidget {
  const DasboardPageView({super.key});

  @override
  State<DasboardPageView> createState() => _DasboardPageViewState();
}

class _DasboardPageViewState extends State<DasboardPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MaterialButton(
              onPressed: () => Navigator.pushNamed(context, '/provider'),
              color: Colors.blue,
              child: const Text('Provider', style: TextStyle(color: Colors.white),),
            )
          ],
        ),
      ),
    );
  }
}