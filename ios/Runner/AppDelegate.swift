import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    var flutterEngine = FlutterEngine(name:"FlutterEngine")
    
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        flutterEngine.run()
        let controller = FlutterViewController(engine: flutterEngine, nibName: nil, bundle: nil)
        let pictureInPictureChannel = FlutterMethodChannel(name: "testPIP/picture-in-picture", binaryMessenger: controller.binaryMessenger)
        
        pictureInPictureChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            switch (call.method) {
            case "startPictureInPicture":
                let arguments = call.arguments as? [String: Any] ?? [String: Any]()
                let remoteStreamId = arguments["remoteStreamId"] as? String ?? ""
                let peerConnectionId = arguments["peerConnectionId"] as? String ?? ""
                let isRemoteCameraEnable = arguments["isRemoteCameraEnable"] as? Bool ?? false
                let myAvatar = arguments["myAvatar"] as? String ?? ""
                let remoteAvatar = arguments["remoteAvatar"] as? String ?? ""
                let remoteName = arguments["remoteName"] as? String ?? ""
                
                TestPiPViewController.shared.configurationPictureInPicture(result: result, peerConnectionId: peerConnectionId, remoteStreamId: remoteStreamId, isRemoteCameraEnable: isRemoteCameraEnable, myAvatar: myAvatar, remoteAvatar: remoteAvatar, remoteName: remoteName)
            case "updatePictureInPicture":
                let arguments = call.arguments as? [String: Any] ?? [String: Any]()
                let peerConnectionId = arguments["peerConnectionId"] as? String ?? ""
                let remoteStreamId = arguments["remoteStreamId"] as? String ?? ""
                let isRemoteCameraEnable = arguments["isRemoteCameraEnable"] as? Bool ?? false
                let remoteAvatar = arguments["remoteAvatar"] as? String ?? ""
                let remoteName = arguments["remoteName"] as? String ?? ""
                TestPiPViewController.shared.updatePictureInPictureView(result, peerConnectionId: peerConnectionId, remoteStreamId: remoteStreamId, isRemoteCameraEnable: isRemoteCameraEnable, remoteAvatar: remoteAvatar, remoteName: remoteName)
            case "updateState":
                let arguments = call.arguments as? [String: Any] ?? [String: Any]()
                let isRemoteCameraEnable = arguments["isRemoteCameraEnable"] as? Bool ?? false
                TestPiPViewController.shared.updateStateUserView(result, isRemoteCameraEnable: isRemoteCameraEnable)
            case "stopPictureInPicture":
                TestPiPViewController.shared.disposePictureInPicture()
                result(true)
            default:
                result(FlutterMethodNotImplemented)
            }
        })
        
        
        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
}
