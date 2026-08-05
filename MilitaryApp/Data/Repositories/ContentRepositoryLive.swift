//
//  ContentRepositoryLive.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// Static editorial content (national chains, fallback articles, and the
/// benefit catalogs) that isn't yet served by the backend.
struct ContentRepositoryLive: ContentRepository {

    func creditCards() -> [MilitaryCreditCard] {
        [
            .init(id: "amex-platinum", name: "The Platinum Card", issuer: "American Express",
                  annualFeeCents: 89_500, blurb: "Lounge access, hotel elite status, travel credits."),
            .init(id: "amex-gold", name: "American Express Gold", issuer: "American Express",
                  annualFeeCents: 32_500, blurb: "4x points at restaurants and U.S. supermarkets."),
            .init(id: "chase-sapphire-reserve", name: "Sapphire Reserve", issuer: "Chase",
                  annualFeeCents: 79_500, blurb: "Priority Pass, travel credit, 3x on travel and dining."),
            .init(id: "chase-sapphire-preferred", name: "Sapphire Preferred", issuer: "Chase",
                  annualFeeCents: 9_500, blurb: "Flexible Ultimate Rewards points, great starter card."),
            .init(id: "cap1-venture-x", name: "Venture X", issuer: "Capital One",
                  annualFeeCents: 39_500, blurb: "Lounge network, 10x on hotels, $300 travel credit."),
            .init(id: "delta-reserve", name: "Delta SkyMiles Reserve", issuer: "American Express",
                  annualFeeCents: 65_000, blurb: "Sky Club access and companion certificate."),
            .init(id: "hilton-aspire", name: "Hilton Honors Aspire", issuer: "American Express",
                  annualFeeCents: 55_000, blurb: "Hilton Diamond status and resort credits."),
            .init(id: "marriott-brilliant", name: "Marriott Bonvoy Brilliant", issuer: "American Express",
                  annualFeeCents: 65_000, blurb: "Platinum Elite status and dining credits.")
        ]
    }

    func infoBenefits() -> [InfoBenefit] {
        [
            // Airlines
            .init(name: "Delta Air Lines", category: .airlines, badge: "Free bags",
                  blurb: "Active-duty members fly with free checked bags and access to special military fares for official and leisure travel.",
                  urlString: "https://www.delta.com/us/en/special-circumstances/military-travel"),
            .init(name: "United Airlines", category: .airlines, badge: "Military fares",
                  blurb: "Discounted fares and extra baggage allowance for military members traveling on orders.",
                  urlString: "https://www.united.com/en/us/fly/company/company-info/military-benefits.html"),
            .init(name: "American Airlines", category: .airlines, badge: "Bag waivers",
                  blurb: "Checked-bag fee waivers for active military on personal and duty travel.",
                  urlString: "https://www.aa.com/i18n/travel-info/special-assistance/military-personnel.jsp"),
            .init(name: "Southwest Airlines", category: .airlines, badge: "Military fares",
                  blurb: "Discounted military fares bookable by phone, plus two free checked bags for everyone.",
                  urlString: "https://www.southwest.com/html/customer-service/family/military-travel/"),

            // Hotels
            .init(name: "Marriott", category: .hotels, badge: "Gov rate",
                  blurb: "Government and military rates at thousands of properties worldwide, on and off duty.",
                  urlString: "https://www.marriott.com/marriott/military-hotel-deals.mi"),
            .init(name: "Hilton", category: .hotels, badge: "Gov rate",
                  blurb: "Discounted government and military rates across all Hilton brands.",
                  urlString: "https://www.hilton.com/en/p/government-military-hotel-rates/"),
            .init(name: "IHG Hotels", category: .hotels, badge: "Gov rate",
                  blurb: "Government rate at Holiday Inn, InterContinental, and other IHG brands.",
                  urlString: "https://www.ihg.com/content/us/en/deals/hotel-offers/government-discounts"),
            .init(name: "Wyndham", category: .hotels, badge: "Gov rate",
                  blurb: "Government and military per-diem rates at participating hotels.",
                  urlString: "https://www.wyndhamhotels.com/deals/government-rates"),

            // Shopping
            .init(name: "Nike", category: .shopping, badge: "10% off",
                  blurb: "10% off for active, reserve, veterans, and family — verify with SheerID online.",
                  urlString: "https://www.nike.com/help/a/military-discount"),
            .init(name: "The Home Depot", category: .shopping, badge: "10% off",
                  blurb: "10% off eligible purchases for military members and veterans, up to $400 a year.",
                  urlString: "https://www.homedepot.com/c/military-discount-benefit"),
            .init(name: "Lowe's", category: .shopping, badge: "10% off",
                  blurb: "10% everyday military discount on eligible purchases with MyLowe's account.",
                  urlString: "https://www.lowes.com/l/military-discount.html"),
            .init(name: "Apple", category: .shopping, badge: "Special store",
                  blurb: "Special pricing on Mac, iPad, and more through the Veterans and Military store.",
                  urlString: "https://www.apple.com/shop/browse/home/veteransandmilitary")
        ]
    }

    func chains() -> [NationalChain] {
        [
            .init(name: "American Legion", category: .food,
                  blurb: "Military discount on dining and meals — show military ID or CAC card at checkout.",
                  locations: 41),
            .init(name: "Arby's", category: .food,
                  blurb: "Military discount on dining and meals — show military ID or CAC card at checkout.",
                  locations: 15),
            .init(name: "Bonefish Grill", category: .food,
                  blurb: "Exclusive military discount on fresh seafood and steaks.",
                  locations: 157, discountBadge: "15% off"),
            .init(name: "Carrabba's Italian Grill", category: .food,
                  blurb: "Reduced rates on classic Italian dishes for service members.",
                  locations: 203),
            .init(name: "Chick-fil-A", category: .food,
                  blurb: "Military discount on dining and meals — show military ID or CAC card at checkout.",
                  locations: 98),
            .init(name: "Advance Auto Parts", category: .automotive,
                  blurb: "Everyday military savings on parts and accessories.",
                  locations: 210, discountBadge: "10% off"),
            .init(name: "Under Armour", category: .shopping,
                  blurb: "Verified military discount in-store and online.",
                  locations: 64, discountBadge: "20% off"),
            .init(name: "Hilton Hotels", category: .travel,
                  blurb: "Government and military rates at participating properties.",
                  locations: 340)
        ]
    }

    func articles() -> [Article] {
        [
            .init(emoji: "🤖", title: "Get a Free Year of ChatGPT Plus If You're Transitioning Out",
                  excerpt: "OpenAI is giving separating service members a year of Plus.",
                  tag: "CAREER", readMinutes: 3),
            .init(emoji: "📄", title: "American Monument For Service Members",
                  excerpt: "A new national memorial honoring those who served.",
                  tag: "MILITARY", readMinutes: 3),
            .init(emoji: "🚚", title: "Freedom Haulers: How Veterans Get a CDL Without the Cost",
                  excerpt: "The government just doubled down on funding CDL training for vets.",
                  tag: "CAREER", readMinutes: 5)
        ]
    }
}
