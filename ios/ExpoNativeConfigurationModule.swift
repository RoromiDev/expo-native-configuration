import ExpoModulesCore
import PassKit

public class ExpoNativeConfigurationModule: Module, PKPaymentAuthorizationViewControllerDelegate {
  public func definition() -> ModuleDefinition {
    Name("ExpoNativeConfiguration")

    Function("getApiKey") {
     return Bundle.main.object(forInfoDictionaryKey: "MY_CUSTOM_API_KEY") as? String
    }

    Function("payWithApplePay") { (arguments) in
      // Assurez-vous que l'appareil peut effectuer des paiements.
      if PKPaymentAuthorizationViewController.canMakePayments() {
        let request = PKPaymentRequest()
        request.merchantIdentifier = arguments["merchantId"] as! String
        request.supportedNetworks = [.visa, .masterCard, .amex]
        request.merchantCapabilities = .capability3DS
        request.countryCode = "FR"
        request.currencyCode = "EUR"
        request.paymentSummaryItems = [
          PKPaymentSummaryItem(label: "Item", amount: NSDecimalNumber(decimal: Decimal(arguments["amount"] as! Double)))
        ]

        let paymentAuthorizationViewController = PKPaymentAuthorizationViewController(paymentRequest: request)
        paymentAuthorizationViewController.delegate = self

        if let rootViewController = UIApplication.shared.keyWindow?.rootViewController {
          rootViewController.present(paymentAuthorizationViewController, animated: true, completion: nil)
        } else {
          // Gérer le cas où il n'y a pas de rootViewController.
        }

        // Présentez le paymentAuthorizationViewController.
      } else {
        // Gérer le cas où l'appareil ne peut pas effectuer de paiements.
      }
    }
  }

  public func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
  
  }

  public func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
    // Gérer la fin de l'autorisation de paiement ici.
    // Par exemple, vous pouvez dissimuler le controller.
    controller.dismiss(animated: true, completion: nil)
  }
}
