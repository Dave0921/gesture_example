import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let nativeViewFactory = NativeViewFactory()
    registrar(forPlugin: "Runner")?.register(nativeViewFactory, withId: "NativeViewExample")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}

class NativeViewFactory : NSObject, FlutterPlatformViewFactory {
    
    public func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        return NativeView(frame, viewId:viewId, args:args)
    }
}

public class NativeView : NSObject, FlutterPlatformView {
    
    let frame: CGRect
    let viewId: Int64
    private var _view: UIView
    
    init(_ frame:CGRect, viewId:Int64, args: Any?){
        self.viewId = viewId
        self.frame = frame
        _view = UIView(frame: self.frame)
        _view.backgroundColor = UIColor.gray
        _view.isUserInteractionEnabled = false
        _view.isMultipleTouchEnabled = false
    }
    
    public func view() -> UIView {
        return _view
    }
    
}
