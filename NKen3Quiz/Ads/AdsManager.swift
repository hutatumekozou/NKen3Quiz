// Ads/AdsManager.swift
import Foundation
import GoogleMobileAds
import UIKit

final class AdsManager: NSObject, GADFullScreenContentDelegate {
    static let shared = AdsManager()
    private var interstitial: GADInterstitialAd?
    private var isLoading = false
    private var onDismiss: (() -> Void)?

    private var interstitialID: String {
        #if DEBUG
        return "ca-app-pub-3940256099942544/4411468910" // Test
        #else
        return "ca-app-pub-8365176591962448/6013903024" // Release
        #endif
    }

    func preload() {
        guard !isLoading, interstitial == nil else { return }
        isLoading = true
        let request = GADRequest()
        #if DEBUG
        print("[Ads] Preloading Interstitial (DEBUG/Test)")
        #endif
        GADInterstitialAd.load(withAdUnitID: interstitialID, request: request) { [weak self] ad, error in
            guard let self else { return }
            self.isLoading = false
            if let error = error {
                print("[Ads] Interstitial load failed: \(error.localizedDescription)")
                self.interstitial = nil
            } else {
                self.interstitial = ad
                self.interstitial?.fullScreenContentDelegate = self
                print("[Ads] Interstitial loaded")
            }
        }
    }

    func show(from root: UIViewController, onDismiss: (() -> Void)? = nil) {
        self.onDismiss = onDismiss
        guard let ad = interstitial else {
            print("[Ads] Interstitial not ready, fallback and preload again")
            self.onDismiss?(); self.onDismiss = nil
            preload()
            return
        }
        #if DEBUG
        print("[Ads] Presenting Interstitial (DEBUG/Test)")
        #endif
        ad.present(fromRootViewController: root)
    }

    // MARK: - GADFullScreenContentDelegate
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("[Ads] Interstitial dismissed")
        interstitial = nil
        let done = onDismiss
        onDismiss = nil
        preload() // 次回に備えて
        done?()
    }

    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("[Ads] Interstitial present failed: \(error.localizedDescription)")
        interstitial = nil
        let done = onDismiss
        onDismiss = nil
        preload()
        done?()
    }
}