//
//  PlaceDetailCard.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI
import MapKit

/// The card that slides up from the bottom of the map when a pin is selected:
/// name, city, free/discount badge, distance, and a Directions shortcut that
/// hands off to Apple Maps.
struct PlaceDetailCard: View {
    let place: Place
    let onClose: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(place.name)
                        .font(.valorButton(18))
                        .foregroundStyle(Valor.textPrimary)
                        .fixedSize(horizontal: false, vertical: true)
                    if let city = place.city {
                        Text(city)
                            .font(.valorBody(14))
                            .foregroundStyle(Valor.textSecondary)
                    }
                }
                Spacer()
                Button(action: onClose) {
                    Image(systemName: "xmark.circle.fill")
                        .font(.system(size: 22))
                        .foregroundStyle(Valor.textTertiary)
                }
            }

            HStack(spacing: 10) {
                Text(place.category ?? (place.isFree ? "Free" : "Discount"))
                    .font(.valorFont(12, weight: .bold))
                    .foregroundStyle(place.isFree ? Valor.green : Valor.blue)
                    .padding(.horizontal, 10).padding(.vertical, 5)
                    .background(Capsule().fill((place.isFree ? Valor.green : Valor.blue).opacity(0.15)))

                if let miles = place.distanceMiles {
                    Label(String(format: "%.1f mi", miles), systemImage: "location.fill")
                        .font(.valorFont(12, weight: .semibold))
                        .foregroundStyle(Valor.textSecondary)
                }

                Spacer()

                Button(action: openInMaps) {
                    HStack(spacing: 6) {
                        Image(systemName: "arrow.triangle.turn.up.right.circle.fill")
                        Text("Directions")
                    }
                    .font(.valorButton(14))
                    .foregroundStyle(.white)
                    .padding(.horizontal, 14).padding(.vertical, 9)
                    .background(Capsule().fill(Valor.blue))
                }
                .buttonStyle(ScaleButtonStyle())
            }
        }
        .padding(16)
        .background(RoundedRectangle(cornerRadius: 20).fill(.regularMaterial))
        .overlay(RoundedRectangle(cornerRadius: 20).strokeBorder(Valor.cardStroke))
        .shadow(color: .black.opacity(0.12), radius: 14, y: 4)
    }

    private func openInMaps() {
        let coordinate = CLLocationCoordinate2D(latitude: place.lat, longitude: place.lng)
        let item = MKMapItem(placemark: MKPlacemark(coordinate: coordinate))
        item.name = place.name
        item.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
}
