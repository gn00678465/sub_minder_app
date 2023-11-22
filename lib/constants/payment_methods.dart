enum PaymentMethods {
  paypal,
  visa,
  jcb,
  bankTransfer,
  googlePay,
  samsungPay,
  applePay,
}

Map<PaymentMethods, Map<String, String>> paymentMethodMap = {
  PaymentMethods.paypal: {"name": 'PayPal', "icon": "PayPal.svg"},
  PaymentMethods.visa: {"name": 'Visa', "icon": "Visa.svg"},
  PaymentMethods.jcb: {"name": 'JCB', "icon": "JCB.svg"},
  PaymentMethods.bankTransfer: {
    "name": "Bank Transfer",
    "icon": "BankTransfer.svg"
  },
  PaymentMethods.applePay: {"name": "Apple Pay", "icon": "ApplePay.svg"},
  PaymentMethods.googlePay: {"name": "Google Pay", "icon": "GooglePay.svg"},
  PaymentMethods.samsungPay: {"name": "Samsung Pay", "icon": "SamsungPay.svg"}
};
