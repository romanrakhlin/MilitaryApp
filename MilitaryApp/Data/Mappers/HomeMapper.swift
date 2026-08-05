//
//  HomeMapper.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// Converts the server `HomeDTO` into the view-shaped domain `HomeSummary`.
enum HomeMapper {

    static func summary(from dto: HomeDTO) -> HomeSummary {
        HomeSummary(
            greeting: .init(partOfDay: dto.greeting.partOfDay, name: dto.greeting.name),
            benefitsTracked: .init(totalCents: dto.benefitsTracked.totalCents,
                                   acrossCount: dto.benefitsTracked.acrossCount),
            tiles: .init(cards: tile(dto.tiles.cards),
                         income: tile(dto.tiles.income),
                         tsp: tile(dto.tiles.tsp),
                         perks: tile(dto.tiles.perks)),
            recon: .init(title: dto.recon.title, subtitle: dto.recon.subtitle, deeplink: dto.recon.deeplink),
            mapPreview: dto.mapPreview.map { mp in
                HomeSummary.MapPreview(
                    centerLat: mp.center.lat,
                    centerLng: mp.center.lng,
                    markers: mp.markers.map { .init(lat: $0.lat, lng: $0.lng, isFree: $0.isFree) })
            },
            latestArticles: dto.latestArticles?.map {
                .init(id: $0.id, emoji: $0.emoji, title: $0.title,
                      excerpt: $0.excerpt, tag: $0.tag, readMinutes: $0.readMinutes)
            }
        )
    }

    private static func tile(_ t: HomeDTO.Tile) -> HomeSummary.Tile {
        .init(valueDisplay: t.valueDisplay, subtitle: t.subtitle, cta: t.cta)
    }
}
