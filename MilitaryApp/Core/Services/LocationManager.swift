//
//  LocationManager.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import CoreLocation

/// Thin wrapper that triggers the real system "Allow location" prompt once,
/// when the user first reaches a screen that shows nearby places. The app
/// currently renders places from the backend/ZIP, so we only need the grant.
final class LocationManager: NSObject, CLLocationManagerDelegate {
    static let shared = LocationManager()

    private let manager = CLLocationManager()

    private override init() {
        super.init()
        manager.delegate = self
    }

    /// Presents the system permission alert, but only if the user hasn't been
    /// asked yet — so it never nags on repeat visits.
    func requestWhenInUseIfNeeded() {
        guard manager.authorizationStatus == .notDetermined else { return }
        manager.requestWhenInUseAuthorization()
    }
}
