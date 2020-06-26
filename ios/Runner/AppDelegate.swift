import UIKit
import Flutter

import CoreBluetooth
import RxSwift
import RxBluetoothKit

fileprivate let serviceId = CBUUID(string: "1111")
fileprivate let characteristicId = CBUUID(string: "2222")

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  static var manager: CentralManager! = nil
  
  var disposeBag = DisposeBag()
  
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    NSLog("App did relaunch")
    
    if AppDelegate.manager == nil {
      let queue = DispatchQueue(label: "manager.queue")
      let options = [CBCentralManagerOptionRestoreIdentifierKey: "RestoreIdentifierKey"] as [String: AnyObject]
      AppDelegate.manager = CentralManager(queue: queue, options: options, onWillRestoreCentralManagerState: { restoredState in
        NSLog("have just been restored")
        let restoredPeripherals = restoredState.peripherals
        let restoredScanOptions = restoredState.scanOptions
        let restoredServices = restoredState.services
        
        NSLog("restoredPeripherals: %d", restoredPeripherals.count)
        NSLog("restoredScanOptions: %d", restoredScanOptions?.keys.count ?? 0)
        NSLog("restoredServices: %d", restoredServices.count)
      })
    }
    
    AppDelegate.manager.observeState().subscribe(onNext: { (state) in
      NSLog("manager state: \(state)")
      if state == .poweredOn {
        AppDelegate.manager.scanForPeripherals(withServices: [serviceId])
          .take(1)
          .flatMap { $0.peripheral.establishConnection() }
          .flatMap { $0.discoverServices([serviceId]) }
          .flatMap { Observable.from($0) }
          .flatMap { $0.discoverCharacteristics([characteristicId]) }
          .flatMap { Observable.from($0) }
          .flatMap { $0.readValue() }
          .subscribe(onNext: {
            if let data = $0.value {
              NSLog("Value: %d", data.count)
            } else {
              NSLog("No data")
            }
          })
          .disposed(by: self.disposeBag)
      }
    }).disposed(by: disposeBag)
    
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  override func applicationWillTerminate(_ application: UIApplication) {
    disposeBag = DisposeBag()
    
    super.applicationWillTerminate(application)
  }
}
