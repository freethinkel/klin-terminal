import Cocoa
import FlutterMacOS

class BlurryContainerViewController: NSViewController {
  let flutterViewController = FlutterViewController()

  init() {
    super.init(nibName: nil, bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError()
  }

  override func loadView() {
    let blurView = NSVisualEffectView()
    blurView.autoresizingMask = [.width, .height]
    blurView.blendingMode = .behindWindow
    blurView.state = .active
    if #available(macOS 10.14, *) {
        blurView.material = .popover
    }
    self.view = blurView
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    self.addChild(flutterViewController)

    flutterViewController.view.frame = self.view.bounds
    flutterViewController.backgroundColor = .clear
    flutterViewController.view.autoresizingMask = [.width, .height]
    self.view.addSubview(flutterViewController.view)
  }
}

class MainFlutterWindow: NSWindow, NSWindowDelegate {
  var _isMaximized = false;
  var channel: FlutterMethodChannel?;

  func startDragging() {
      DispatchQueue.main.async {
          let window: NSWindow  = self;
          if(window.currentEvent != nil) {
              window.performDrag(with: window.currentEvent!)
          }
      }
  }
   func maximize() {
    if (!_isMaximized) {
      self.zoom(nil);
    }
  }
  
   func unmaximize() {
    if (_isMaximized) {
      self.zoom(nil);
    }
  }

  func _emitEvent(_ eventName: String) {
    if (self.channel != nil) {
      self.channel!.invokeMethod(eventName, arguments: "");
    }
  }
  
  func _initHandler() {
    let controller = (self.contentViewController as! BlurryContainerViewController).flutterViewController;
    self.channel = FlutterMethodChannel(name: "ru.freethinkel.oshmesterminal/channel",
                                       binaryMessenger: controller.engine.binaryMessenger);
    channel!.setMethodCallHandler({
      (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
      let methodName: String = call.method
      let _: [String: Any] = call.arguments as? [String: Any] ?? [:]

      switch (methodName) {
        case "start_dragging":
          self.startDragging();
          result("");
          break;
        case "is_maximized":
          result(self._isMaximized);
          break;
        case "maximize":
          self.maximize();
          result("");
          break;
        case "unmaximize":
          self.unmaximize();
          result("");
          break;
        default:
          result(FlutterMethodNotImplemented)
      }
    })

  }
  
  
  override func awakeFromNib() {
    delegate = self
    let blurryContainerViewController = BlurryContainerViewController()
    let windowFrame = self.frame
    self.contentViewController = blurryContainerViewController
    self.setFrame(windowFrame, display: true)

    if #available(macOS 10.13, *) {
      let customToolbar = NSToolbar()
      customToolbar.showsBaselineSeparator = false
      self.toolbar = customToolbar
    }
    self.titleVisibility = .hidden
    self.titlebarAppearsTransparent = true
    self.isMovable = false
    if #available(macOS 11.0, *) {
      // Use .expanded if the app will have a title bar, else use .unified
      self.toolbarStyle = .unifiedCompact
    }

    self.isMovableByWindowBackground = true
    self.styleMask.insert([.fullSizeContentView, .fullSizeContentView, .borderless])

    self.isOpaque = false
    self.backgroundColor = .windowBackgroundColor
    self.hasShadow = true
    self.appearance = NSAppearance.init(named: NSAppearance.Name.vibrantDark)
    _initHandler();
    UserDefaults.standard.set(false, forKey: "ApplePressAndHoldEnabled");

    RegisterGeneratedPlugins(registry: blurryContainerViewController.flutterViewController)

    super.awakeFromNib()
  }

  public func windowDidResize(_ notification: Notification) {
    if (!_isMaximized && self.isZoomed) {
      _isMaximized = true
      _emitEvent("maximized")
    }
    if (_isMaximized && !self.isZoomed) {
      _isMaximized = false
      _emitEvent("unmaximized")
    }
  }
  func windowDidEndLiveResize(_ notification: Notification) {
    _emitEvent("resized")
  }
  
    func windowWillMove(_ notification: Notification) {
    _emitEvent("move")
  }
    
  func windowDidMove(_ notification: Notification) {
    _emitEvent("moved")
  }
    
  func windowDidBecomeMain(_ notification: Notification) {
    _emitEvent("focus");
  }
    
  func windowDidResignMain(_ notification: Notification){
    _emitEvent("blur");
  }
    
  func windowDidMiniaturize(_ notification: Notification) {
    _emitEvent("minimize");
  }
    
  func windowDidDeminiaturize(_ notification: Notification) {
    _emitEvent("restore");
  }

  // Hides the toolbar when in fullscreen mode
  func window(_ window: NSWindow, willUseFullScreenPresentationOptions proposedOptions: NSApplication.PresentationOptions = []) -> NSApplication.PresentationOptions {
    
    return [.autoHideToolbar, .autoHideMenuBar, .fullScreen]
  }

  func windowWillEnterFullScreen(_ notification: Notification) {
    self.toolbar?.isVisible = false
    _emitEvent("enter-full-screen");
  }
  
  func windowDidExitFullScreen(_ notification: Notification) {
      self.toolbar?.isVisible = true;
      _emitEvent("leave-full-screen");
  }
}
