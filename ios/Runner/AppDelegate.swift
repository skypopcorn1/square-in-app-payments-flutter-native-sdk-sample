import UIKit
import Flutter
import SquareInAppPaymentsSDK


@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  
  var navigationController: UINavigationController!
    
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    // Set your Square Application ID
    SQIPInAppPaymentsSDK.squareApplicationID = "sandbox-sq0idb-4GUiO2eU3a5IlJyKtCwRUA"
    
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let paymentChannel = FlutterMethodChannel(name: "com.example.yourprojectname",
                                              binaryMessenger: controller.binaryMessenger)
    paymentChannel.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in

      // This checks to see if the channel method invoked has been implemented. If not,
      // it will return an error back to Flutter indicating the method has not been implemented
      //
      // This corresponds to the below line of code in the home.dart file of this sample project:
      //
      // ...
      // "await platform.invokeMethod('getCardNonce',).then((result) {
      // ...
      //

      guard call.method == "getCardNonce" else {
        result(FlutterMethodNotImplemented)
        return
      }
      self.presentSquareCardEntryForm(result: result)
    })

    GeneratedPluginRegistrant.register(with: self)

    // This block of code sets the Flutter View Controller as the root controller of the
    // UINavigationController.

    self.navigationController = UINavigationController(rootViewController: controller)
    self.window.rootViewController = self.navigationController
    self.navigationController.setNavigationBarHidden(true, animated: false)
    self.window.makeKeyAndVisible()
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

    // Here we initialise the SquareViewController (located in the SquareViewController.swift file)
    // Then we set the view controller's onFinish property to return the result from the Square API
    // Lastly we push the SquareViewController on top of the FlutterViewController.
    // When we are finished with the card entry or cancel the card entry, we will pop this view off
    // the screen to reveal/return back to our Flutter View.

    func presentSquareCardEntryForm(result: @escaping FlutterResult) {
        let vc = UIStoryboard.init(name: "Main", bundle: .main)
                .instantiateViewController(withIdentifier: "SquareViewController") as! SquareViewController
        vc.onFinish = { cardNonce in result("Card nonce: \(cardNonce)")}
        self.navigationController.pushViewController(vc, animated: true)
    }
}