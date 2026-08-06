//
//  StateBenefitsCatalog.swift
//  MilitaryApp
//
//  Created by John Dollar on 8/4/26.
//

import Foundation

/// Static editorial catalog behind the State Benefits browser: the federal
/// (all-states) benefits plus a per-state guide with each state's flagship
/// veteran benefits. Amounts and rules change yearly — every entry links out
/// to the official page.
enum StateBenefitsCatalog {

    static let federal: [StateBenefit] = [
        .init(name: "Post-9/11 GI Bill", badge: "Tuition + housing",
              blurb: "Up to full in-state tuition plus a monthly housing allowance and book stipend after 90 days of qualifying service.",
              urlString: "https://www.va.gov/education/about-gi-bill-benefits/post-9-11/"),
        .init(name: "VA Home Loan", badge: "$0 down",
              blurb: "Buy a home with no down payment and no private mortgage insurance, backed by the VA guarantee.",
              urlString: "https://www.va.gov/housing-assistance/home-loans/"),
        .init(name: "VA Health Care", badge: "Low or no cost",
              blurb: "Medical care through the VA network — many veterans qualify for free care based on service and income.",
              urlString: "https://www.va.gov/health-care/"),
        .init(name: "VA Disability Compensation", badge: "Tax free",
              blurb: "Monthly tax-free payment for conditions connected to your service, from 10% to 100% ratings.",
              urlString: "https://www.va.gov/disability/"),
        .init(name: "National Parks Military Pass", badge: "Free entry",
              blurb: "Free annual pass for active duty and Gold Star families, and a free lifetime pass for veterans — every national park and federal recreation site.",
              urlString: "https://www.nps.gov/subjects/annualpass/military.htm"),
        .init(name: "Federal Hiring Preference", badge: "Federal jobs",
              blurb: "Veterans' preference adds points to your score and priority placement in competitive federal hiring.",
              urlString: "https://www.fedshirevets.gov")
    ]

    static let states: [StateGuide] = [
        .init(name: "Alabama", abbreviation: "AL", benefits: [
            .init(name: "Homestead Tax Exemption", badge: "100% waived",
                  blurb: "Veterans rated 100% permanently and totally disabled pay no state property taxes on their primary residence.",
                  urlString: "https://va.alabama.gov"),
            .init(name: "G.I. Dependent Scholarship", badge: "Free tuition",
                  blurb: "Tuition, fees, and books at Alabama public colleges for dependents of qualifying disabled veterans.",
                  urlString: "https://va.alabama.gov"),
            .init(name: "Hunting & Fishing Licenses", badge: "~$3/year",
                  blurb: "Heavily discounted licenses for resident veterans with a 20%+ disability rating.",
                  urlString: "https://va.alabama.gov")
        ]),
        .init(name: "Alaska", abbreviation: "AK", benefits: [
            .init(name: "Property Tax Exemption", badge: "First $150k",
                  blurb: "The first $150,000 of assessed home value is exempt for veterans rated 50% or more disabled.",
                  urlString: "https://veterans.alaska.gov"),
            .init(name: "State Camping Pass", badge: "Free camping",
                  blurb: "Disabled veterans get a free lifetime camping pass for Alaska state parks.",
                  urlString: "https://veterans.alaska.gov"),
            .init(name: "Hunting & Fishing License", badge: "Free",
                  blurb: "Free hunting, fishing, and trapping license for residents with a 50%+ service-connected disability.",
                  urlString: "https://veterans.alaska.gov")
        ]),
        .init(name: "Arizona", abbreviation: "AZ", benefits: [
            .init(name: "Retirement Pay Exemption", badge: "Tax free",
                  blurb: "Arizona fully exempts military retirement pay from state income tax.",
                  urlString: "https://dvs.az.gov"),
            .init(name: "Property Tax Exemption", badge: "Reduced",
                  blurb: "County-administered exemption that lowers assessed home value for qualifying disabled veterans.",
                  urlString: "https://dvs.az.gov"),
            .init(name: "Hunt & Fish Combo License", badge: "Discounted",
                  blurb: "Complimentary or reduced-fee licenses for 100% disabled resident veterans.",
                  urlString: "https://dvs.az.gov")
        ]),
        .init(name: "Arkansas", abbreviation: "AR", benefits: [
            .init(name: "Retirement Pay Exemption", badge: "Tax free",
                  blurb: "Military retirement pay is fully exempt from Arkansas income tax.",
                  urlString: "https://www.veterans.arkansas.gov"),
            .init(name: "Homestead Exemption", badge: "100% waived",
                  blurb: "100% permanently and totally disabled veterans pay no property tax on their homestead.",
                  urlString: "https://www.veterans.arkansas.gov"),
            .init(name: "Hunting & Fishing License", badge: "Free lifetime",
                  blurb: "Free lifetime combination license for 100% disabled resident veterans.",
                  urlString: "https://www.veterans.arkansas.gov")
        ]),
        .init(name: "California", abbreviation: "CA", benefits: [
            .init(name: "College Fee Waiver", badge: "Free tuition",
                  blurb: "Waives system-wide tuition at UC, CSU, and community colleges for children and spouses of disabled veterans.",
                  urlString: "https://www.calvet.ca.gov"),
            .init(name: "CalVet Home Loans", badge: "Low rates",
                  blurb: "State-run home financing built for California veterans, separate from the federal VA loan.",
                  urlString: "https://www.calvet.ca.gov"),
            .init(name: "Distinguished Veteran Pass", badge: "Free parks",
                  blurb: "Free lifetime pass to most California state parks for qualifying disabled veterans and former POWs.",
                  urlString: "https://www.calvet.ca.gov")
        ]),
        .init(name: "Colorado", abbreviation: "CO", benefits: [
            .init(name: "Property Tax Exemption", badge: "50% of $200k",
                  blurb: "Half of the first $200,000 of home value is exempt for 100% permanently disabled veterans.",
                  urlString: "https://vets.colorado.gov"),
            .init(name: "State Parks Access", badge: "Free pass",
                  blurb: "Free state park entry for all veterans every August, plus a free lifetime Columbine pass for disabled veterans.",
                  urlString: "https://vets.colorado.gov"),
            .init(name: "Retirement Pay Deduction", badge: "Up to $24k",
                  blurb: "Deduct up to $24,000 of military retirement pay from state taxes, depending on age.",
                  urlString: "https://vets.colorado.gov")
        ]),
        .init(name: "Connecticut", abbreviation: "CT", benefits: [
            .init(name: "Retirement Pay Exemption", badge: "Tax free",
                  blurb: "Connecticut fully exempts military retirement pay from state income tax.",
                  urlString: "https://portal.ct.gov/dva"),
            .init(name: "Property Tax Exemption", badge: "$1,500+",
                  blurb: "Base exemption for wartime veterans, with larger amounts for disabled veterans.",
                  urlString: "https://portal.ct.gov/dva"),
            .init(name: "Tuition Waiver", badge: "Free tuition",
                  blurb: "Tuition waived at Connecticut state colleges and universities for qualifying wartime veterans.",
                  urlString: "https://portal.ct.gov/dva")
        ]),
        .init(name: "Delaware", abbreviation: "DE", benefits: [
            .init(name: "Pension Exclusion", badge: "Up to $12.5k",
                  blurb: "Exclude up to $12,500 of military pension income from Delaware taxes.",
                  urlString: "https://vets.delaware.gov"),
            .init(name: "State Parks Pass", badge: "Free entry",
                  blurb: "Free annual state park pass for Delaware resident veterans.",
                  urlString: "https://vets.delaware.gov"),
            .init(name: "Delaware Veterans Home", badge: "Long-term care",
                  blurb: "Skilled nursing and long-term care for Delaware veterans.",
                  urlString: "https://vets.delaware.gov")
        ]),
        .init(name: "Florida", abbreviation: "FL", benefits: [
            .init(name: "Homestead Exemption", badge: "100% waived",
                  blurb: "100% permanently disabled veterans pay no property tax on their homestead; partial discounts start at 10%.",
                  urlString: "https://floridavets.org"),
            .init(name: "Purple Heart Tuition Waiver", badge: "Free tuition",
                  blurb: "Tuition waived at Florida public colleges for Purple Heart and combat-decoration recipients.",
                  urlString: "https://floridavets.org"),
            .init(name: "Military Gold Sportsman's License", badge: "$20/year",
                  blurb: "Hunting and fishing license bundle for $20 for Florida military members and veterans.",
                  urlString: "https://floridavets.org")
        ]),
        .init(name: "Georgia", abbreviation: "GA", benefits: [
            .init(name: "Property Tax Exemption", badge: "Up to $109k",
                  blurb: "Disabled veterans can exempt over $109,000 of home value from property taxes.",
                  urlString: "https://veterans.georgia.gov"),
            .init(name: "Honorary Licenses", badge: "Free",
                  blurb: "Free lifetime hunting and fishing licenses for 100% disabled Georgia veterans.",
                  urlString: "https://veterans.georgia.gov"),
            .init(name: "Retirement Pay Exclusion", badge: "Up to $65k",
                  blurb: "Georgia excludes a large share of military retirement income from state tax.",
                  urlString: "https://veterans.georgia.gov")
        ]),
        .init(name: "Hawaii", abbreviation: "HI", benefits: [
            .init(name: "Retirement Pay Exemption", badge: "Tax free",
                  blurb: "Hawaii doesn't tax military retirement pay.",
                  urlString: "https://dod.hawaii.gov/ovs/"),
            .init(name: "Property Tax Exemption", badge: "100% waived",
                  blurb: "Totally disabled veterans are exempt from property tax on their primary residence (county programs).",
                  urlString: "https://dod.hawaii.gov/ovs/"),
            .init(name: "Yukio Okutsu Veterans Home", badge: "Long-term care",
                  blurb: "State veterans home in Hilo offering skilled nursing care.",
                  urlString: "https://dod.hawaii.gov/ovs/")
        ]),
        .init(name: "Idaho", abbreviation: "ID", benefits: [
            .init(name: "Property Tax Reduction", badge: "Up to $1,500",
                  blurb: "Annual property tax benefit for veterans rated 100% service-connected disabled.",
                  urlString: "https://veterans.idaho.gov"),
            .init(name: "State Parks Passport", badge: "Discounted",
                  blurb: "Reduced-price entry and camping in Idaho state parks for disabled veterans.",
                  urlString: "https://veterans.idaho.gov"),
            .init(name: "Retirement Benefits Deduction", badge: "Age 65+",
                  blurb: "Military retirement deduction for veterans 65 and older, or disabled and 62+.",
                  urlString: "https://veterans.idaho.gov")
        ]),
        .init(name: "Illinois", abbreviation: "IL", benefits: [
            .init(name: "Illinois Veteran Grant", badge: "Free tuition",
                  blurb: "Pays tuition and fees at Illinois public colleges for eligible veterans — stackable with the GI Bill.",
                  urlString: "https://veterans.illinois.gov"),
            .init(name: "Property Tax Exemption", badge: "Up to 100%",
                  blurb: "Veterans rated 70%+ pay no property tax (up to a cap); scaled exemptions start at 30%.",
                  urlString: "https://veterans.illinois.gov"),
            .init(name: "Retirement Pay Exemption", badge: "Tax free",
                  blurb: "Illinois doesn't tax military retirement pay or survivor benefits.",
                  urlString: "https://veterans.illinois.gov")
        ]),
        .init(name: "Indiana", abbreviation: "IN", benefits: [
            .init(name: "Retirement Pay Exemption", badge: "Tax free",
                  blurb: "Military retirement pay is fully exempt from Indiana income tax.",
                  urlString: "https://www.in.gov/dva/"),
            .init(name: "Property Tax Deductions", badge: "Up to $24,960",
                  blurb: "Stackable deductions for disabled and wartime veterans.",
                  urlString: "https://www.in.gov/dva/"),
            .init(name: "Hunting & Fishing Licenses", badge: "Discounted",
                  blurb: "Reduced-fee licenses for Indiana veterans with service-connected disabilities.",
                  urlString: "https://www.in.gov/dva/")
        ]),
        .init(name: "Iowa", abbreviation: "IA", benefits: [
            .init(name: "Retirement Pay Exemption", badge: "Tax free",
                  blurb: "Iowa fully exempts military retirement pay from state income tax.",
                  urlString: "https://va.iowa.gov"),
            .init(name: "Military Homestead Credit", badge: "Property relief",
                  blurb: "Military service property tax exemption plus homestead credit for veterans.",
                  urlString: "https://va.iowa.gov"),
            .init(name: "Lifetime Hunt & Fish License", badge: "$7 lifetime",
                  blurb: "Lifetime license for a small one-time fee for Iowa disabled veterans and former POWs.",
                  urlString: "https://va.iowa.gov")
        ]),
        .init(name: "Kansas", abbreviation: "KS", benefits: [
            .init(name: "Retirement Pay Exemption", badge: "Tax free",
                  blurb: "Military retirement pay is exempt from Kansas income tax.",
                  urlString: "https://kcva.ks.gov"),
            .init(name: "Homestead Refund", badge: "Up to $700",
                  blurb: "Property tax refund program for veterans rated 50% or more disabled.",
                  urlString: "https://kcva.ks.gov"),
            .init(name: "Park & License Discounts", badge: "Discounted",
                  blurb: "Reduced state park vehicle permits and hunt/fish licenses for disabled veterans.",
                  urlString: "https://kcva.ks.gov")
        ]),
        .init(name: "Kentucky", abbreviation: "KY", benefits: [
            .init(name: "Pension Exclusion", badge: "Up to $31,110",
                  blurb: "Military retirement excluded from state tax up to the pension cap.",
                  urlString: "https://veterans.ky.gov"),
            .init(name: "Homestead Exemption", badge: "$46,350",
                  blurb: "Indexed homestead exemption for 100% disabled veterans.",
                  urlString: "https://veterans.ky.gov"),
            .init(name: "Kentucky Veterans Centers", badge: "Long-term care",
                  blurb: "Four state veterans nursing homes across the Commonwealth.",
                  urlString: "https://veterans.ky.gov")
        ]),
        .init(name: "Louisiana", abbreviation: "LA", benefits: [
            .init(name: "Retirement Pay Exemption", badge: "Tax free",
                  blurb: "Louisiana fully exempts military retirement pay from state income tax.",
                  urlString: "https://www.vetaffairs.la.gov"),
            .init(name: "Homestead Exemption", badge: "Up to $150k",
                  blurb: "Doubled homestead exemption for veterans rated 100% disabled.",
                  urlString: "https://www.vetaffairs.la.gov"),
            .init(name: "Hunting & Fishing License", badge: "Free",
                  blurb: "Free licenses for Louisiana veterans with a 50%+ disability rating.",
                  urlString: "https://www.vetaffairs.la.gov")
        ]),
        .init(name: "Maine", abbreviation: "ME", benefits: [
            .init(name: "Retirement Pay Exemption", badge: "Tax free",
                  blurb: "Military retirement pay is fully exempt from Maine income tax.",
                  urlString: "https://www.maine.gov/veterans/"),
            .init(name: "Property Tax Exemption", badge: "$6,000",
                  blurb: "Exemption for veterans 62+ or receiving 100% disability compensation.",
                  urlString: "https://www.maine.gov/veterans/"),
            .init(name: "Parks & Licenses", badge: "Free",
                  blurb: "Free state park day-use and free hunting/fishing licenses for 100% disabled veterans.",
                  urlString: "https://www.maine.gov/veterans/")
        ]),
        .init(name: "Maryland", abbreviation: "MD", benefits: [
            .init(name: "Property Tax Exemption", badge: "100% waived",
                  blurb: "Full property tax exemption for 100% permanently disabled veterans.",
                  urlString: "https://veterans.maryland.gov"),
            .init(name: "Retirement Income Subtraction", badge: "Tax relief",
                  blurb: "Maryland subtracts a growing share of military retirement income from state tax.",
                  urlString: "https://veterans.maryland.gov"),
            .init(name: "Complimentary Licenses", badge: "Free",
                  blurb: "Free hunting licenses for 100% disabled veterans and former POWs.",
                  urlString: "https://veterans.maryland.gov")
        ]),
        .init(name: "Massachusetts", abbreviation: "MA", benefits: [
            .init(name: "Retirement Pay Exemption", badge: "Tax free",
                  blurb: "Massachusetts doesn't tax military retirement pay.",
                  urlString: "https://www.mass.gov/orgs/executive-office-of-veterans-services"),
            .init(name: "Disabled Veteran Annuity", badge: "$2,000/yr",
                  blurb: "Annual annuity for 100% disabled veterans, paid in two installments.",
                  urlString: "https://www.mass.gov/orgs/executive-office-of-veterans-services"),
            .init(name: "Tuition Waiver", badge: "Free tuition",
                  blurb: "Tuition waivers at Massachusetts state colleges for qualifying veterans.",
                  urlString: "https://www.mass.gov/orgs/executive-office-of-veterans-services")
        ]),
        .init(name: "Michigan", abbreviation: "MI", benefits: [
            .init(name: "Property Tax Exemption", badge: "100% waived",
                  blurb: "100% permanently disabled veterans are exempt from property taxes on their homestead.",
                  urlString: "https://www.michigan.gov/mvaa"),
            .init(name: "Retirement Pay Exemption", badge: "Tax free",
                  blurb: "Military retirement pay is exempt from Michigan income tax.",
                  urlString: "https://www.michigan.gov/mvaa"),
            .init(name: "Hunting & Fishing License", badge: "Free",
                  blurb: "Free licenses for Michigan veterans rated 100% disabled.",
                  urlString: "https://www.michigan.gov/mvaa")
        ]),
        .init(name: "Minnesota", abbreviation: "MN", benefits: [
            .init(name: "Market Value Exclusion", badge: "Up to $300k",
                  blurb: "Excludes up to $300,000 of home value from taxes for 100% permanently disabled veterans.",
                  urlString: "https://mn.gov/mdva/"),
            .init(name: "Minnesota GI Bill", badge: "Up to $10k",
                  blurb: "State education benefit stackable on top of the federal GI Bill.",
                  urlString: "https://mn.gov/mdva/"),
            .init(name: "Retirement Pay Subtraction", badge: "Tax free",
                  blurb: "Military retirement pay can be fully subtracted from Minnesota taxable income.",
                  urlString: "https://mn.gov/mdva/")
        ]),
        .init(name: "Mississippi", abbreviation: "MS", benefits: [
            .init(name: "Retirement Pay Exemption", badge: "Tax free",
                  blurb: "Mississippi doesn't tax military retirement pay.",
                  urlString: "https://www.msva.ms.gov"),
            .init(name: "Homestead Exemption", badge: "100% waived",
                  blurb: "Total homestead exemption for veterans rated 100% disabled.",
                  urlString: "https://www.msva.ms.gov"),
            .init(name: "State Veterans Homes", badge: "Long-term care",
                  blurb: "Four state veterans homes across Mississippi.",
                  urlString: "https://www.msva.ms.gov")
        ]),
        .init(name: "Missouri", abbreviation: "MO", benefits: [
            .init(name: "Retirement Pay Exemption", badge: "Tax free",
                  blurb: "Military retirement pay is fully exempt from Missouri income tax.",
                  urlString: "https://mvc.dps.mo.gov"),
            .init(name: "Property Tax Credit", badge: "Up to $1,100",
                  blurb: "Income-based credit for 100% disabled veterans.",
                  urlString: "https://mvc.dps.mo.gov"),
            .init(name: "Missouri Veterans Homes", badge: "Long-term care",
                  blurb: "Seven state veterans homes offering skilled nursing care.",
                  urlString: "https://mvc.dps.mo.gov")
        ]),
        .init(name: "Montana", abbreviation: "MT", benefits: [
            .init(name: "Property Tax Assistance", badge: "Reduced",
                  blurb: "The Montana Disabled Veteran program cuts property tax rates for 100% disabled veterans.",
                  urlString: "https://dma.mt.gov/mvad"),
            .init(name: "Retirement Pay Exemption", badge: "Tax relief",
                  blurb: "Partial exemption for military retirees who make Montana home.",
                  urlString: "https://dma.mt.gov/mvad"),
            .init(name: "Hunting & Fishing License", badge: "Free/reduced",
                  blurb: "Free or reduced licenses for resident disabled veterans.",
                  urlString: "https://dma.mt.gov/mvad")
        ]),
        .init(name: "Nebraska", abbreviation: "NE", benefits: [
            .init(name: "Retirement Pay Exemption", badge: "Tax free",
                  blurb: "Nebraska fully exempts military retirement pay from state income tax.",
                  urlString: "https://veterans.nebraska.gov"),
            .init(name: "Homestead Exemption", badge: "Up to 100%",
                  blurb: "Tiered property tax exemption for disabled veterans.",
                  urlString: "https://veterans.nebraska.gov"),
            .init(name: "Park Entry Permits", badge: "Discounted",
                  blurb: "Reduced-fee state park entry permits for disabled veterans.",
                  urlString: "https://veterans.nebraska.gov")
        ]),
        .init(name: "Nevada", abbreviation: "NV", benefits: [
            .init(name: "No State Income Tax", badge: "0% tax",
                  blurb: "Nevada taxes no wages, pensions, or military retirement pay at all.",
                  urlString: "https://veterans.nv.gov"),
            .init(name: "Property Tax Exemption", badge: "Tax relief",
                  blurb: "Annual exemption for veterans — larger for disabled — usable against home or vehicle taxes.",
                  urlString: "https://veterans.nv.gov"),
            .init(name: "State Parks Pass", badge: "Free/reduced",
                  blurb: "Free or reduced annual park permits for eligible Nevada veterans.",
                  urlString: "https://veterans.nv.gov")
        ]),
        .init(name: "New Hampshire", abbreviation: "NH", benefits: [
            .init(name: "No Income Tax", badge: "0% tax",
                  blurb: "No tax on salaries or military pensions in New Hampshire.",
                  urlString: "https://www.nh.gov/nhveterans/"),
            .init(name: "Property Tax Credits", badge: "Up to $701+",
                  blurb: "Standard and optional veteran tax credits; full exemption for certain 100% disabled veterans.",
                  urlString: "https://www.nh.gov/nhveterans/"),
            .init(name: "NH Veterans Home", badge: "Long-term care",
                  blurb: "State veterans home in Tilton.",
                  urlString: "https://www.nh.gov/nhveterans/")
        ]),
        .init(name: "New Jersey", abbreviation: "NJ", benefits: [
            .init(name: "Retirement Pay Exemption", badge: "Tax free",
                  blurb: "New Jersey doesn't tax military retirement pay.",
                  urlString: "https://www.nj.gov/military/"),
            .init(name: "Property Tax Relief", badge: "Up to 100%",
                  blurb: "$250 annual deduction for veterans; total exemption for 100% permanently disabled.",
                  urlString: "https://www.nj.gov/military/"),
            .init(name: "State Parks Access", badge: "Free pass",
                  blurb: "Free entry to New Jersey state parks for resident disabled veterans.",
                  urlString: "https://www.nj.gov/military/")
        ]),
        .init(name: "New Mexico", abbreviation: "NM", benefits: [
            .init(name: "Property Tax Exemption", badge: "$4,000+",
                  blurb: "Standard exemption for veterans; 100% disabled veterans get a full exemption on their primary residence.",
                  urlString: "https://www.nmdvs.org"),
            .init(name: "Retirement Pay Exemption", badge: "Up to $30k",
                  blurb: "Phased exemption of military retirement income from state tax.",
                  urlString: "https://www.nmdvs.org"),
            .init(name: "State Parks Pass", badge: "Free pass",
                  blurb: "Free annual day-use pass for resident veterans rated 50% or more disabled.",
                  urlString: "https://www.nmdvs.org")
        ]),
        .init(name: "New York", abbreviation: "NY", benefits: [
            .init(name: "Retirement Pay Exemption", badge: "Tax free",
                  blurb: "New York doesn't tax military retirement pay.",
                  urlString: "https://veterans.ny.gov"),
            .init(name: "Alternative Veterans Exemption", badge: "Up to 25%",
                  blurb: "Reduces assessed home value for wartime veterans, with combat and disability boosts.",
                  urlString: "https://veterans.ny.gov"),
            .init(name: "Lifetime Liberty Pass", badge: "Free parks",
                  blurb: "Free state park entry, camping discounts, and free fishing for 40%+ disabled veterans.",
                  urlString: "https://veterans.ny.gov")
        ]),
        .init(name: "North Carolina", abbreviation: "NC", benefits: [
            .init(name: "Retirement Pay Exemption", badge: "Tax free",
                  blurb: "Military retirement pay is exempt from North Carolina income tax.",
                  urlString: "https://www.milvets.nc.gov"),
            .init(name: "Property Tax Exclusion", badge: "First $45k",
                  blurb: "Excludes the first $45,000 of home value for 100% disabled veterans.",
                  urlString: "https://www.milvets.nc.gov"),
            .init(name: "Lifetime Licenses", badge: "$11",
                  blurb: "Deeply discounted lifetime hunting/fishing licenses for 50%+ disabled veterans.",
                  urlString: "https://www.milvets.nc.gov")
        ]),
        .init(name: "North Dakota", abbreviation: "ND", benefits: [
            .init(name: "Retirement Pay Exemption", badge: "Tax free",
                  blurb: "North Dakota fully exempts military retirement pay.",
                  urlString: "https://www.veterans.nd.gov"),
            .init(name: "Property Tax Credit", badge: "Up to $8,100",
                  blurb: "Credit against taxable home value for veterans rated 50% or more disabled.",
                  urlString: "https://www.veterans.nd.gov"),
            .init(name: "Dependent Tuition Waiver", badge: "Free tuition",
                  blurb: "Free tuition for dependents of veterans who were killed in action or totally disabled.",
                  urlString: "https://www.veterans.nd.gov")
        ]),
        .init(name: "Ohio", abbreviation: "OH", benefits: [
            .init(name: "Retirement Pay Exemption", badge: "Tax free",
                  blurb: "Ohio doesn't tax military retirement pay.",
                  urlString: "https://dvs.ohio.gov"),
            .init(name: "Homestead Exemption", badge: "$50,000",
                  blurb: "Enhanced homestead exemption for veterans rated 100% disabled.",
                  urlString: "https://dvs.ohio.gov"),
            .init(name: "Ohio Veterans Homes", badge: "Long-term care",
                  blurb: "Sandusky and Georgetown campuses offer care for Ohio veterans.",
                  urlString: "https://dvs.ohio.gov")
        ]),
        .init(name: "Oklahoma", abbreviation: "OK", benefits: [
            .init(name: "Retirement Pay Exemption", badge: "Tax free",
                  blurb: "Oklahoma fully exempts military retirement pay from state income tax.",
                  urlString: "https://oklahoma.gov/odva"),
            .init(name: "Sales Tax Exemption", badge: "No sales tax",
                  blurb: "100% disabled veterans are exempt from Oklahoma sales tax up to an annual cap — a benefit unique to Oklahoma.",
                  urlString: "https://oklahoma.gov/odva"),
            .init(name: "Homestead Exemption", badge: "100% waived",
                  blurb: "Full property tax exemption for 100% permanently disabled veterans.",
                  urlString: "https://oklahoma.gov/odva")
        ]),
        .init(name: "Oregon", abbreviation: "OR", benefits: [
            .init(name: "ODVA Home Loan", badge: "Low rates",
                  blurb: "Oregon's state-run home loan for veterans — separate from and stackable with the federal VA loan.",
                  urlString: "https://www.oregon.gov/odva"),
            .init(name: "Property Tax Exemption", badge: "$24k-$29k",
                  blurb: "Assessed-value exemption for veterans rated 40% or more disabled.",
                  urlString: "https://www.oregon.gov/odva"),
            .init(name: "State Parks Pass", badge: "Free camping",
                  blurb: "Free camping and day-use in Oregon state parks for eligible disabled veterans.",
                  urlString: "https://www.oregon.gov/odva")
        ]),
        .init(name: "Pennsylvania", abbreviation: "PA", benefits: [
            .init(name: "Retirement Pay Exemption", badge: "Tax free",
                  blurb: "Pennsylvania doesn't tax military retirement pay.",
                  urlString: "https://www.dmva.pa.gov"),
            .init(name: "Real Estate Tax Exemption", badge: "100% waived",
                  blurb: "Full property tax exemption for 100% disabled wartime veterans (need-based).",
                  urlString: "https://www.dmva.pa.gov"),
            .init(name: "State Veterans Homes", badge: "Long-term care",
                  blurb: "Six state veterans homes across the Commonwealth.",
                  urlString: "https://www.dmva.pa.gov")
        ]),
        .init(name: "Rhode Island", abbreviation: "RI", benefits: [
            .init(name: "Retirement Pay Exemption", badge: "Tax free",
                  blurb: "Military retirement pay is now fully exempt from Rhode Island income tax.",
                  urlString: "https://vets.ri.gov"),
            .init(name: "Property Tax Exemptions", badge: "By town",
                  blurb: "Veteran and disabled-veteran exemptions available in every municipality.",
                  urlString: "https://vets.ri.gov"),
            .init(name: "RI Veterans Home", badge: "Long-term care",
                  blurb: "State veterans home on the Bristol waterfront.",
                  urlString: "https://vets.ri.gov")
        ]),
        .init(name: "South Carolina", abbreviation: "SC", benefits: [
            .init(name: "Retirement Pay Exemption", badge: "Tax free",
                  blurb: "South Carolina fully exempts military retirement pay from state income tax.",
                  urlString: "https://scdva.sc.gov"),
            .init(name: "Property Tax Exemption", badge: "100% waived",
                  blurb: "Full homestead exemption — plus two vehicles — for 100% permanently disabled veterans.",
                  urlString: "https://scdva.sc.gov"),
            .init(name: "Licenses & Park Discounts", badge: "Free/reduced",
                  blurb: "Free hunting/fishing licenses for disabled veterans and reduced state park fees.",
                  urlString: "https://scdva.sc.gov")
        ]),
        .init(name: "South Dakota", abbreviation: "SD", benefits: [
            .init(name: "No State Income Tax", badge: "0% tax",
                  blurb: "South Dakota taxes no income, including military retirement pay.",
                  urlString: "https://vetaffairs.sd.gov"),
            .init(name: "Property Tax Exemption", badge: "First $150k",
                  blurb: "Exempts $150,000 of home value for 100% permanently disabled veterans.",
                  urlString: "https://vetaffairs.sd.gov"),
            .init(name: "State Parks Entry", badge: "Free entry",
                  blurb: "Free park entrance license for eligible disabled veterans.",
                  urlString: "https://vetaffairs.sd.gov")
        ]),
        .init(name: "Tennessee", abbreviation: "TN", benefits: [
            .init(name: "No State Income Tax", badge: "0% tax",
                  blurb: "Tennessee taxes no wages or retirement income.",
                  urlString: "https://www.tn.gov/veteran"),
            .init(name: "Property Tax Relief", badge: "Up to $175k",
                  blurb: "Tax relief on the first $175,000 of home value for 100% permanently disabled veterans.",
                  urlString: "https://www.tn.gov/veteran"),
            .init(name: "Hunting & Fishing License", badge: "Free",
                  blurb: "Free licenses for 100% disabled veterans; discounts start at 30%.",
                  urlString: "https://www.tn.gov/veteran")
        ]),
        .init(name: "Texas", abbreviation: "TX", benefits: [
            .init(name: "Hazlewood Act", badge: "150 free hours",
                  blurb: "Up to 150 credit hours tuition-free at Texas public colleges — unused hours can pass to a child.",
                  urlString: "https://www.tvc.texas.gov"),
            .init(name: "Property Tax Exemption", badge: "100% waived",
                  blurb: "Full exemption for 100% disabled veterans; partial exemptions start at 10%.",
                  urlString: "https://www.tvc.texas.gov"),
            .init(name: "Parklands Passport", badge: "Free entry",
                  blurb: "Free state park entry for Texas veterans rated 60% or more disabled.",
                  urlString: "https://www.tvc.texas.gov")
        ]),
        .init(name: "Utah", abbreviation: "UT", benefits: [
            .init(name: "Retirement Pay Credit", badge: "Tax free",
                  blurb: "Utah's tax credit effectively exempts military retirement pay.",
                  urlString: "https://veterans.utah.gov"),
            .init(name: "Property Tax Abatement", badge: "Rating-based",
                  blurb: "Abates property tax on a share of home value matched to your disability rating.",
                  urlString: "https://veterans.utah.gov"),
            .init(name: "Utah Veterans Homes", badge: "Long-term care",
                  blurb: "Four state veterans homes across Utah.",
                  urlString: "https://veterans.utah.gov")
        ]),
        .init(name: "Vermont", abbreviation: "VT", benefits: [
            .init(name: "Property Tax Exemption", badge: "$10k-$40k",
                  blurb: "At least $10,000 of assessed value exempt (towns may raise to $40,000) for 50%+ disabled veterans.",
                  urlString: "https://veterans.vermont.gov"),
            .init(name: "Retirement Pay Exemption", badge: "Up to $10k",
                  blurb: "Income-limited exemption of military retirement pay.",
                  urlString: "https://veterans.vermont.gov"),
            .init(name: "Hunting & Fishing License", badge: "Free",
                  blurb: "Free licenses for Vermont veterans rated 60% or more disabled.",
                  urlString: "https://veterans.vermont.gov")
        ]),
        .init(name: "Virginia", abbreviation: "VA", benefits: [
            .init(name: "Real Estate Tax Exemption", badge: "100% waived",
                  blurb: "Full property tax exemption for 100% permanently disabled veterans and surviving spouses.",
                  urlString: "https://www.dvs.virginia.gov"),
            .init(name: "Retirement Subtraction", badge: "Up to $40k",
                  blurb: "Growing subtraction of military retirement income for veterans 55 and older.",
                  urlString: "https://www.dvs.virginia.gov"),
            .init(name: "Veterans Care Centers", badge: "Long-term care",
                  blurb: "State-run care centers for Virginia veterans.",
                  urlString: "https://www.dvs.virginia.gov")
        ]),
        .init(name: "Washington", abbreviation: "WA", benefits: [
            .init(name: "No State Income Tax", badge: "0% tax",
                  blurb: "Washington taxes no wages or military retirement pay.",
                  urlString: "https://dva.wa.gov"),
            .init(name: "Property Tax Exemption", badge: "Income-based",
                  blurb: "Relief for veterans rated 80% or more disabled who meet income limits.",
                  urlString: "https://dva.wa.gov"),
            .init(name: "Discover Pass", badge: "Free/reduced",
                  blurb: "Free or reduced state land access pass for eligible disabled veterans.",
                  urlString: "https://dva.wa.gov")
        ]),
        .init(name: "West Virginia", abbreviation: "WV", benefits: [
            .init(name: "Retirement Pay Exemption", badge: "Tax free",
                  blurb: "Military retirement pay is fully exempt from West Virginia income tax.",
                  urlString: "https://veterans.wv.gov"),
            .init(name: "Homestead Exemption", badge: "$20,000",
                  blurb: "First $20,000 of assessed value exempt for 100% disabled veterans.",
                  urlString: "https://veterans.wv.gov"),
            .init(name: "Licenses & Parks", badge: "Free/reduced",
                  blurb: "Free hunting/fishing licenses for qualifying disabled veterans plus state park discounts.",
                  urlString: "https://veterans.wv.gov")
        ]),
        .init(name: "Wisconsin", abbreviation: "WI", benefits: [
            .init(name: "Wisconsin GI Bill", badge: "Free tuition",
                  blurb: "Full tuition remission at UW System and technical colleges for eligible veterans, spouses, and children.",
                  urlString: "https://dva.wisconsin.gov"),
            .init(name: "Retirement Pay Exemption", badge: "Tax free",
                  blurb: "Wisconsin doesn't tax military retirement pay.",
                  urlString: "https://dva.wisconsin.gov"),
            .init(name: "Property Tax Credit", badge: "Refundable",
                  blurb: "Refunds property taxes for 100% disabled veterans through an income tax credit.",
                  urlString: "https://dva.wisconsin.gov")
        ]),
        .init(name: "Wyoming", abbreviation: "WY", benefits: [
            .init(name: "No State Income Tax", badge: "0% tax",
                  blurb: "Wyoming taxes no income, including military retirement pay.",
                  urlString: "https://www.wyomilitary.wyo.gov"),
            .init(name: "Property Tax Exemption", badge: "$3,000 assessed",
                  blurb: "Annual exemption against assessed home value for wartime veterans.",
                  urlString: "https://www.wyomilitary.wyo.gov"),
            .init(name: "Game & Fish Licenses", badge: "Discounted",
                  blurb: "Reduced-price lifetime licenses for resident disabled veterans.",
                  urlString: "https://www.wyomilitary.wyo.gov")
        ])
    ]
}
