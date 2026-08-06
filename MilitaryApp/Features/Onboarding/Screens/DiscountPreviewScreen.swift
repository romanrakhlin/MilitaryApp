//
//  DiscountPreviewScreen.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI
import MapKit

/// The "discounts near you" teaser. Reaching this screen is where nearby
/// places first matter, so the system location permission is requested here.
/// Once access is granted the card becomes a real (non-interactive) map
/// centered on the user with nearby discount pins; until then it shows the
/// locked placeholder.
struct DiscountPreviewScreen: View {
    @EnvironmentObject private var onboarding: OnboardingStore
    @ObservedObject private var location = LocationManager.shared
    let onNext: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            OBTitle(title: "There are 120+ military discounts within 10 miles of you.")
                .padding(.top, 8)

            preview
                .frame(height: 260)

            Spacer()
            PrimaryButton(title: "See them all", action: onNext).padding(.bottom, 20)
        }
        .obPadding().padding(.top, 24)
        .onAppear { LocationManager.shared.requestWhenInUseIfNeeded() }
        .task(id: location.lastLocation) {
            guard let coord = location.lastLocation?.coordinate else { return }
            await onboarding.loadNearbyPlaces(lat: coord.latitude, lng: coord.longitude)
        }
    }

    // MARK: - Preview card

    @ViewBuilder
    private var preview: some View {
        if location.isAuthorized, let coord = location.lastLocation?.coordinate {
            liveMap(centeredOn: coord)
        } else {
            lockedPlaceholder
        }
    }

    /// A static glimpse of the Discover map: the user's dot plus real nearby
    /// pins. All interaction is disabled — it's a preview, not the map tab.
    private func liveMap(centeredOn coord: CLLocationCoordinate2D) -> some View {
        Map(initialPosition: .region(MKCoordinateRegion(center: coord,
                                                        latitudinalMeters: 6_000,
                                                        longitudinalMeters: 6_000)),
            interactionModes: []) {
            UserAnnotation()
            ForEach(onboarding.nearbyPlaces) { place in
                Annotation(place.name,
                           coordinate: CLLocationCoordinate2D(latitude: place.lat, longitude: place.lng)) {
                    PlaceAnnotationView(isFree: place.isFree)
                }
            }
        }
        .mapStyle(.standard(pointsOfInterest: .excludingAll))
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .overlay(RoundedRectangle(cornerRadius: 20).strokeBorder(Valor.cardStroke))
    }

    private var lockedPlaceholder: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20).fill(Valor.card.opacity(0.6))
                .overlay(RoundedRectangle(cornerRadius: 20).strokeBorder(Valor.cardStroke))
            // scattered pins
            ForEach(0..<6, id: \.self) { i in
                Image(systemName: "mappin")
                    .foregroundStyle(i % 2 == 0 ? Valor.blue : Valor.red)
                    .offset(x: [-90, 70, -40, 30, -70, 60][i], y: [-40, -60, 20, 40, 60, 10][i])
            }
            VStack(spacing: 8) {
                Image(systemName: "lock.fill").font(.system(size: 22))
                    .foregroundStyle(.white)
                    .frame(width: 56, height: 56)
                    .background(Circle().fill(Color.black.opacity(0.5)))
                Text("Locked preview").font(.valorButton(16)).foregroundStyle(Valor.textPrimary)
            }
        }
    }
}
