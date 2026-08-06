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
            .init(name: "Alaska Airlines", category: .airlines, badge: "Free bags",
                  blurb: "Up to five free checked bags for active military on orders, plus discounted military fares.",
                  urlString: "https://www.alaskaair.com/content/travel-info/policies/military-personnel"),
            .init(name: "JetBlue", category: .airlines, badge: "5% off",
                  blurb: "5% off flights for military members and veterans through the Veterans Advantage program.",
                  urlString: "https://www.jetblue.com/deals/military-discount"),
            .init(name: "Frontier Airlines", category: .airlines, badge: "Free bags",
                  blurb: "Free carry-on and checked bag for active-duty service members through Frontier's military program.",
                  urlString: "https://www.flyfrontier.com/deals/military-discounts/"),
            .init(name: "Allegiant", category: .airlines, badge: "Free bags",
                  blurb: "Free checked bags, carry-on, and oversized item waivers for active duty and veterans.",
                  urlString: "https://www.allegiantair.com/military"),

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
            .init(name: "Best Western", category: .hotels, badge: "Military rate",
                  blurb: "Government and military rates at most locations, on or off duty.",
                  urlString: "https://www.bestwestern.com/en_US/hotels/discounts/military-hotel-discounts.html"),
            .init(name: "Hyatt", category: .hotels, badge: "Gov rate",
                  blurb: "Government and military rates at participating Hyatt hotels worldwide.",
                  urlString: "https://www.hyatt.com/special-offers/government-rate"),
            .init(name: "Choice Hotels", category: .hotels, badge: "Gov rate",
                  blurb: "Government rates at Comfort Inn, Quality Inn, Cambria, and other Choice brands.",
                  urlString: "https://www.choicehotels.com/deals/government-hotel-rates"),
            .init(name: "Motel 6", category: .hotels, badge: "10% off",
                  blurb: "10% off every stay for military members and veterans — no verification hoops.",
                  urlString: "https://www.motel6.com/en/deals/military-discount.html"),

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
                  urlString: "https://www.apple.com/shop/browse/home/veteransandmilitary"),
            .init(name: "Under Armour", category: .shopping, badge: "20% off",
                  blurb: "20% off for military, veterans, and first responders — verify online with ID.me.",
                  urlString: "https://www.underarmour.com/en-us/t/military-first-responder-discount.html"),
            .init(name: "adidas", category: .shopping, badge: "30% off",
                  blurb: "30% off online and in-store for military members and veterans, verified with SheerID.",
                  urlString: "https://www.adidas.com/us/military-discount"),
            .init(name: "Oakley Standard Issue", category: .shopping, badge: "Pro pricing",
                  blurb: "Deep pro-level pricing on eyewear and gear for active duty, reserve, and veterans.",
                  urlString: "https://www.oakleysi.com"),
            .init(name: "Samsung", category: .shopping, badge: "Up to 30%",
                  blurb: "Exclusive military pricing on phones, TVs, and appliances through the Samsung Offer Program.",
                  urlString: "https://www.samsung.com/us/shop/offer-program/military/")
        ]
    }

    func federalBenefits() -> [StateBenefit] { StateBenefitsCatalog.federal }

    func stateGuides() -> [StateGuide] { StateBenefitsCatalog.states }

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
