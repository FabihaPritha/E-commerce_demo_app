import 'package:flutter/material.dart';
import 'package:stripe_payment/stripe_payment.dart';

class StripePaymentService {
  static Future<void> makePayment(BuildContext context) async{
    try{
      PaymentMethod paymentMethod = await StripePayment.paymentRequestWithCardForm(
        CardFormPaymentRequest(),
      );
      
      showDialog(
        // ignore: use_build_context_synchronously
        context: context, 
        builder: (_) => AlertDialog(
          title: const Text('Payment Successful'),
          content: Text('Payment Method: ${paymentMethod.id}'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
               child: const Text('OK'),
            )
          ],
        ),
      );

    }catch(e){
      showDialog(
        // ignore: use_build_context_synchronously
        context: context, 
        builder: (_) => AlertDialog(
          title: const Text('Payment Failed'),
          content: Text('Error : $e'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), 
              child: const Text('OK'))
          ],
        ));
    }
  }
}