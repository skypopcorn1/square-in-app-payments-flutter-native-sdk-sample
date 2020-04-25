import SquareInAppPaymentsSDK


protocol SquareControllerDelegate: class {
    func didRequestPayWithCard()
}

class SquareViewController: UIViewController {
    
    var onFinish: ((_ nonce: String) -> Void)?
    
    override func viewDidLoad() {
        didRequestPayWithCard()
        super.viewDidLoad()
    }
    
}


// You can customise the card entry form here.
// Docs here ---->
// https://developer.squareup.com/docs/api/in-app-payment/ios/Classes/SQIPTheme.html

extension SquareViewController {
    func makeCardEntryViewController() -> SQIPCardEntryViewController {
        // Customize the card payment form
        let theme = SQIPTheme()
        theme.errorColor = UIColor(red: 1.00, green: 0.00, blue: 0.00, alpha: 1)
        theme.tintColor = UIColor(red: 0.14, green: 0.6, blue: 0.55, alpha: 1)
        theme.keyboardAppearance = .light
        theme.messageColor = UIColor(red: 0.98, green: 0.48, blue: 0.48, alpha: 1)
        theme.saveButtonTitle = "Send Card to Square API to Get a Nonce Back"

        return SQIPCardEntryViewController(theme: theme)
    }
}

extension SquareViewController: SquareControllerDelegate {
    func didRequestPayWithCard() {
            dismiss(animated: true) {
                let vc = self.makeCardEntryViewController()
                vc.delegate = self
                let nc = UINavigationController(rootViewController: vc)
                self.present(nc, animated: true, completion: nil)
            }
        }
    
    // Note you may consider adding additional code to handle errors from the Square API
    // before returning the user back to the Flutter View. This would allow the form to
    // stay intact and avoid the user have to re-enter all their card details. For
    // simplicity, I have skipped this step in this sample project.
    
}

extension SquareViewController: SQIPCardEntryViewControllerDelegate {
    func cardEntryViewController(
        _: SQIPCardEntryViewController,
        didCompleteWith status: SQIPCardEntryCompletionStatus
    ) {
        //TODO - investigate how to handle errors without dismissing the form.
        switch status {
        case .canceled:
            NSLog("Cancelled")
            dismiss(animated: true)
            self.navigationController?.popViewController(animated: true)
            break
        case .success:
            dismiss(animated: true)
            self.navigationController?.popViewController(animated: true)
        }
    }

    func cardEntryViewController(_: SQIPCardEntryViewController,
                                 didObtain cardDetails: SQIPCardDetails,
                                 completionHandler: @escaping (Error?) -> Void) {

        // Send card nonce "back" to Flutter and handle all the communication with the backend
        // server from there. This approach allows the server logic to be handled in Dart which
        // used across across iOS and Android rather than having write the logic twice. For
        // security purposes, your backend server should still handled all communication with the
        // Square API to ensure your Square Developer API Access Token is not kept in the app code
        // on the device.
        //
        // Alternatively, you can handle the server calls from within the Runner. For an example of
        // this, see the Square iOS SDK example.
        //
        // https://github.com/square/in-app-payments-ios-quickstart/tree/master/InAppPaymentsSample
        //
        // Square has thoughtfully provided a sample backend server to help you quickly get a full
        // lifecycle test up and running. If you live outside the US, you will need to clone or
        // fork the sample to change the currency and/or other settings in the sample Node JS code
        // before you can use the sample. Otherwise, you can use the super handy 'Deploy to Heroku'
        // quick launch button in the github repo README.md
        //
        // https://github.com/square/in-app-payments-server-quickstart


        onFinish?(cardDetails.nonce)
        completionHandler(nil)
    }
}

// MARK: - UINavigationControllerDelegate

extension SquareViewController: UINavigationControllerDelegate {
   func navigationControllerSupportedInterfaceOrientations(
       _: UINavigationController
   ) -> UIInterfaceOrientationMask {
       return .portrait
   }
}
