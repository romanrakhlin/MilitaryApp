//
//  PlaceMapper.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// Converts server `PlaceDTO`s into domain `Place`s.
enum PlaceMapper {

    static func place(from dto: PlaceDTO) -> Place {
        Place(id: dto.id,
              name: dto.name,
              city: dto.city,
              category: dto.category,
              isFree: dto.isFree,
              lat: dto.lat,
              lng: dto.lng,
              distanceMiles: dto.distanceMiles,
              isFavorite: dto.isFavorite ?? false)
    }

    static func places(from list: [PlaceDTO]) -> [Place] {
        list.map(place(from:))
    }
}
