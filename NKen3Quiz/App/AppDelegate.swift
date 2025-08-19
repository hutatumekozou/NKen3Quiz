// App/AppDelegate.swift
import UIKit
import GoogleMobileAds

final class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        #if DEBUG
        print("[Ads] GoogleMobileAds started (DEBUG - test ads)")
        #else
        print("[Ads] GoogleMobileAds started (RELEASE)")
        #endif
        return true
    }
}