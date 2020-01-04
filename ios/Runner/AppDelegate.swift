import UIKit
import Flutter
import kotlin_shared

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let kotlinShared = FlutterMethodChannel(name: "kotlin_shared",
                                              binaryMessenger: controller.binaryMessenger)
    kotlinShared.setMethodCallHandler({
        (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
        guard call.method == "greet" else {
            result(FlutterMethodNotImplemented)
            return
        }
        result(CommonKt.greetFromKotlin())
    })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
