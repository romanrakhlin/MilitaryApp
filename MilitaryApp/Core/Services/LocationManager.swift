//
//  LocationManager.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import CoreLocation
import Combine

/// Thin wrapper around `CLLocationManager`: triggers the system "Allow
/// location" prompt once, mirrors the authorization state for SwiftUI, and
/// grabs a one-shot fix as soon as access is granted so map previews can
/// center on the user.
final class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    static let shared = LocationManager()

    private let manager = CLLocationManager()

    /// Mirrors `CLLocationManager.authorizationStatus` so views re-render on grant.
    @Published private(set) var authorizationStatus: CLAuthorizationStatus = .notDetermined
    /// The one-shot fix captured after access was granted.
    @Published private(set) var lastLocation: CLLocation?

    private override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        authorizationStatus = manager.authorizationStatus
    }

    /// Presents the system permission alert if the user hasn't been asked yet;
    /// on repeat visits with access already granted it just refreshes the fix.
    func requestWhenInUseIfNeeded() {
        if manager.authorizationStatus == .notDetermined {
            manager.requestWhenInUseAuthorization()
        } else if isAuthorized, lastLocation == nil {
            manager.requestLocation()
        }
    }

    var isAuthorized: Bool {
        authorizationStatus == .authorizedWhenInUse || authorizationStatus == .authorizedAlways
    }

    /// True when the user has declined access (or the device restricts it) —
    /// at that point the system prompt can never be shown again, and the only
    /// way to enable location is the app's page in the Settings app.
    var isDenied: Bool {
        authorizationStatus == .denied || authorizationStatus == .restricted
    }

    private var hasShownDeniedAlertThisSession = false

    /// Returns `true` exactly once per app session when access is denied, so
    /// the map screen shows its "enable in Settings" alert on first open but
    /// doesn't nag on every tab switch back to the map.
    func shouldShowDeniedAlert() -> Bool {
        guard isDenied, !hasShownDeniedAlertThisSession else { return false }
        hasShownDeniedAlertThisSession = true
        return true
    }

    // MARK: - CLLocationManagerDelegate

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
        if isAuthorized, lastLocation == nil { manager.requestLocation() }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastLocation = locations.last
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // One-shot fix failed (e.g. simulator without a simulated location) —
        // callers simply keep their placeholder UI.
    }
}
