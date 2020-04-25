# Sample Integration with the Square Payments Native iOS SDK

Sample project is a temporary fix while waiting for the Square Team to fix a critical issue with the current Square Flutter Plugin which causes the app to crash on Flutter 1.12 or greater. This approach could also be used if Square decides to discontinue support for the Flutter plugin and or decides to provide extended features in the Native SDKs.

The sample app uses Flutter's Platform Method Channels to communicate with the native platform (host). This allows us to utilize Third Party APIs built for the native platform (eg iOS) as well as connect with Native APIs.

This sample project however focuses on the single use case of launching the card entry form from the native Square In App Payments SDK (SquareInAppPaymentsSDK) and returning back to Flutter with the card nonce (ie single use token for the credit card details entered by the user)

Square handles the security and PCI compliance requirements for collecting the users credit card details. Your app still needs to do something useful with this card nonce once it is returned back to the app such as charging the card, creating a Square Customer profile and saving the card on file for that customer, etc. All of these details and much more information can be found on the Square Developer Documentation. (https://developer.squareup.com/au/en)


## Getting Started

Complete the steps provide on the Square Developer get started page (https://developer.squareup.com/docs/get-started)

Replace the application ID details in <Project>/ios/Runner/AppDelegate.swift
    // Set your Square Application ID
    SQIPInAppPaymentsSDK.squareApplicationID = "REPLACE_ME"

Navigate in the Terminal to <Project>/ios and run 'pod install'. In addition to the dependencies in you would normally add to your pubspec.yaml file, you will also need to add the Native Square iOS SDK dependency manually to the Podfile. This has already been completed for you in this sample project but is an additional step you need to take if you wish to incorporate this into your own project.

Note - references above to <Project> should be replaced with the name you've given this project file or if unchanged then the original name of the project as cloned from github (eg. square_native_sdk_sample/ios).

# Other Comments
This project is only setup to handle iOS. I am currently working on the Android side of this as well and will update this project to include both eventually.

Hot Restart & Hot Reloads - the app will not respond to Hot Reload and Hot Restart attempt when a platform channel has been invoked. You will need to stop the app and do a full restart.

Debugging - debugging native platform code will be much easier if you add the -v flag (eg. flutter run -v)

# Credits
Significant portions of the code in this sample project were taken from the sources below, all credit should be given to the appropriate authors. As well, the below are good resources for further exploring the possibilities of native platorm channels with flutter and the Square APIs.

https://flutter.dev/docs/development/platform-integration/platform-channels
https://blog.usejournal.com/integrating-native-third-party-sdk-in-flutter-8aab03afa9da
https://blog.solutelabs.com/integrating-third-party-native-sdks-in-flutter-df418829dcf7
https://developer.squareup.com/docs/in-app-payments-sdk/build-on-ios