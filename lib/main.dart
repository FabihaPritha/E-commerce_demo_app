import 'package:ecommerce_demo_app/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:stripe_payment/stripe_payment.dart';

void main() {
  StripePayment.setOptions(
    StripeOptions(
      publishableKey:
          "pk_test_51RjHH5EQKwm4VFhJrxOJtGjeZ0EXAY4S4HBtXbKU1hpMAcf1I51xGn51YstQT1xIc2RnqiolF0Rif4csbPsOmof300xOMUzF0r",
          merchantId: "Test",
          androidPayMode: 'test',
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ecommerce Demo App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomeScreen(),
    );
  }
}
