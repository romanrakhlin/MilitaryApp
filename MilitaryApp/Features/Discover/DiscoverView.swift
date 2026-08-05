//
//  DiscoverView.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import SwiftUI
import MapKit

/// The map hub: Free vs Discount toggle, category filter chips, an overlaid
/// "no results" hint, and entry points to List View + National Chains + Add.
/// Uses the iOS 16 `Map(coordinateRegion:interactionModes:annotationItems:)`
/// API with custom `PlaceAnnotationView` pins.
struct DiscoverView: View {
    @StateObject private var store: DiscoverStore

    // DC seed area (backend seed covers DC + San Diego).
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 38.8977, longitude: -77.0365),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    @State private var showList = false
    @State private var showChains = false

    init(container: AppContainer) {
        _store = StateObject(wrappedValue: container.makeDiscoverStore())
    }

    var body: some View {
        ZStack(alignment: .top) {
            Map(coordinateRegion: $region, interactionModes: .all, annotationItems: store.filtered) { place in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: place.lat, longitude: place.lng)) {
                    PlaceAnnotationView(isFree: place.isFree)
                }
            }
            .ignoresSafeArea()

            controlsOverlay

            DiscoverFloatingButtons(onList: { showList = true }, onAdd: {})
        }
        .sheet(isPresented: $showList) { PlacesListSheet(places: store.filtered) }
        .sheet(isPresented: $showChains) { NationalChainsSheet(chains: store.chains) }
        .task { await store.loadIfNeeded() }
    }

    // MARK: Controls

    private var controlsOverlay: some View {
        VStack(spacing: 12) {
            Text("Valor")
                .font(.valorFont(30, weight: .black))
                .italic()
                .foregroundStyle(Valor.blue)
                .shadow(radius: 8)

            HStack(spacing: 12) {
                ModeButton(title: "Free Locations", icon: "gift.fill", active: store.mode == .free) {
                    store.mode = (store.mode == .free ? nil : .free)
                }
                ModeButton(title: "Discount Locations", icon: "tag.fill", active: store.mode == .discount) {
                    store.mode = (store.mode == .discount ? nil : .discount)
                }
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    FilterChip(title: "All", active: store.category == nil) { store.category = nil }
                    FilterChip(title: "Chains", systemImage: "building.2.fill", active: false) { showChains = true }
                    ForEach(DiscountCategory.allCases) { c in
                        FilterChip(title: c.rawValue, active: store.category == c) { store.category = c }
                    }
                }
                .padding(.horizontal, 2)
            }

            if store.filtered.isEmpty {
                DiscoverEmptyHint(mode: store.mode)
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 8)
    }
}
