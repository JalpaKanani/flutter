import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorPayScreen extends StatefulWidget {
  const RazorPayScreen({Key? key}) : super(key: key);

  @override
  State<RazorPayScreen> createState() => _RazorPayScreenState();
}

class _RazorPayScreenState extends State<RazorPayScreen> {
  Razorpay? razorPay;
  TextEditingController textEditingController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    razorPay = new Razorpay();

    razorPay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorPay!.on(Razorpay.EVENT_PAYMENT_ERROR, handlerError);
    razorPay!.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    razorPay!.clear();
  }

  void openChekout() {
    var options = {
      'key': '',//razor payment key
      'amount': num.parse(textEditingController.text)*100,
      'name': 'Sample app',
      'description': ' Payment for the some random product',
      'prefill':{
      'contact':'2323232323',
      'email':'abc@gmail.com',
      },
      'external':{
        'wallets':[
          'paytm'
        ]
      },
    };
    try{
      razorPay!.open(options);
    }catch(e){
      print(e.toString());
    }
  }

  void handlerPaymentSuccess() {
    print('payment success');
  }

  void handlerError() {
    print('payment error');
  }

  void handlerExternalWallet() {
    print('externam wallet');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Razor Pay'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
          children: [
            TextField(
              controller: textEditingController,
              decoration: InputDecoration(hintText: 'amount to pay'),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(onPressed: () {
              openChekout();
            }, child: Text('Donate now'))
          ],
        ),
      ),
    );
  }
}
