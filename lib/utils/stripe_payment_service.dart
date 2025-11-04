import 'package:dio/dio.dart';
import 'package:ecommerce_demo_app/const.dart'; // contains `stripeSecretKey`
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripePaymentService {
  StripePaymentService._();

  static final StripePaymentService instance = StripePaymentService._();

  Future<void> makePayment(BuildContext context) async {
    try {
      final clientSecret = await _createPaymentIntent(10, "usd");

      if (clientSecret == null) {
        _showDialog(context, "Error", "Failed to create payment intent.");
        return;
      }

      // Initialize payment sheet
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: "Nowshin",
          style: ThemeMode.light,
        ),
      );

      // Present payment sheet
      await Stripe.instance.presentPaymentSheet();

      // Show success dialog
      _showDialog(context, "Payment Successful", "Your payment was completed!");
    } on StripeException catch (_) {
      _showDialog(context, "Payment Cancelled", "You cancelled the payment.");
    } catch (e) {
      _showDialog(context, "Payment Failed", "An error occurred: $e");
    }
  }

  Future<String?> _createPaymentIntent(int amount, String currency) async {
    try {
      final dio = Dio();
      final data = {"amount": _calculateAmount(amount), "currency": currency};

      final response = await dio.post(
        "https://api.stripe.com/v1/payment_intents",
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": "Bearer $stripeSecretKey",
            "Content-Type": 'application/x-www-form-urlencoded',
          },
        ),
      );

      return response.data["client_secret"];
    } catch (e) {
      debugPrint("PaymentIntent error: $e");
      return null;
    }
  }

  String _calculateAmount(int amount) {
    return (amount * 100).toString(); // Convert to cents
  }

  void _showDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("OK"),
              ),
            ],
          ),
    );
  }
}
