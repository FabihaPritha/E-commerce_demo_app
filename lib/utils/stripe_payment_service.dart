import 'package:dio/dio.dart';
import 'package:ecommerce_demo_app/const.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class StripePaymentService {
  StripePaymentService._();

  static final StripePaymentService instance = StripePaymentService._();

  Future<void> makePayment() async {
    try {
      String? paymentIntentClientSecret = await _createPaymentIntent(10, "usd");
      if (paymentIntentClientSecret == null) return;
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentClientSecret,
          merchantDisplayName: "Nowshin",
        ),
      );
      await _processPayment();
    } catch (e) {
      print(e);
    }
  }

  Future<String?> _createPaymentIntent(int amount, String currency) async {
    try {
      final Dio dio = Dio();
      Map<String, dynamic> data = {
        "amount": _calculateAmount(amount),
        "currency": currency,
      };
      var response = await dio.post(
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
      if (response.data != null) {
        return response.data["client_secret"];
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> _processPayment() async {
    try {
      await Stripe.instance.presentPaymentSheet();
    } catch (e) {
      print(e);
    }
  }

  String _calculateAmount(int amount) {
    final calculateAmount = amount * 100;
    return calculateAmount.toString();
  }
}


















// import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';

// class StripePaymentService {
//   static Future<void> makePayment(BuildContext context) async{
//     try{
//       PaymentMethod paymentMethod = await StripePayment.paymentRequestWithCardForm(
//         CardFormPaymentRequest(),
//       );
      
//       showDialog(
//         // ignore: use_build_context_synchronously
//         context: context, 
//         builder: (_) => AlertDialog(
//           title: const Text('Payment Successful'),
//           content: Text('Payment Method: ${paymentMethod.id}'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//                child: const Text('OK'),
//             )
//           ],
//         ),
//       );

//     }catch(e){
//       showDialog(
//         // ignore: use_build_context_synchronously
//         context: context, 
//         builder: (_) => AlertDialog(
//           title: const Text('Payment Failed'),
//           content: Text('Error : $e'),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context), 
//               child: const Text('OK'))
//           ],
//         ));
//     }
//   }
// }