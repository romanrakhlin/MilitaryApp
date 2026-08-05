//
//  HomeMapPreview.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI
import MapKit

/// The small, non-interactive map preview on the Home dashboard.
/// Uses the iOS 16 `Map(coordinateRegion:interactionModes:annotationItems:)`
/// API with custom `PlaceAnnotationView` pins.
struct HomeMapPreview: View {
    let preview: HomeSummary.MapPreview?
    @State private var region: MKCoordinateRegion

    init(preview: HomeSummary.MapPreview?) {
        self.preview = preview
        let lat = preview?.centerLat ?? 38.9
        let lng = preview?.centerLng ?? -77.03
        _region = State(initialValue: MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: lat, longitude: lng),
            span: MKCoordinateSpan(latitudeDelta: 0.12, longitudeDelta: 0.12)))
    }

    var body: some View {
        VStack(spacing: 0) {
            Map(coordinateRegion: $region, interactionModes: [],
                annotationItems: preview?.markers ?? []) { marker in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: marker.lat, longitude: marker.lng)) {
                    PlaceAnnotationView(isFree: marker.isFree)
                }
            }
            .frame(height: 180)
            .allowsHitTesting(false)

            HStack {
                Text("View Full Map").font(.valorButton(16)).foregroundStyle(Valor.textPrimary)
                Spacer()
                Image(systemName: "chevron.right").foregroundStyle(Valor.textTertiary)
            }
            .padding(16)
            .background(Valor.card.opacity(0.6))
        }
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .overlay(RoundedRectangle(cornerRadius: 18).strokeBorder(Valor.cardStroke))
    }
}
