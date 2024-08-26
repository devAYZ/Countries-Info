//
//  HomeModels.swift
//  Countries Info
//
//  Created by Ayokunle Pro on 8/23/24.
//
import Foundation


typealias CountriesResponseList = [CountriesResponse]

// MARK: CountriesResponse
struct CountriesResponse: Codable {
    var name: Name?
    var tld: [String]?
    var cca2, ccn3, cca3: String?
    var independent: Bool?
    var status: String?
    var unMember: Bool?
    var currencies: [String: Currency]?
    var idd: Idd?
    var capital, altSpellings: [String]?
    var region, subregion: String?
    var languages: Languages?
    var translations: [String: Translation]?
    var latlng: [Double]?
    var landlocked: Bool?
    var area: Double?
    var demonyms: [String: Eng]?
    var flag: String?
    var maps: Maps?
    var population: Int?
    var car: Car?
    var timezones, continents: [String]?
    var flags: Flags?
    var coatOfArms: CoatOfArms?
    var startOfWeek: String?
    var capitalInfo: [String: [Double]]?
    var cioc, fifa: String?
    var borders: [String]?
    var gini: [String: Double]?
    var postalCode: PostalCode?
    
    init(
        name: Name? = nil, tld: [String]? = nil, cca2: String? = nil,
        ccn3: String? = nil, cca3: String? = nil, independent: Bool? = nil,
        status: String? = nil, unMember: Bool? = nil, currencies: [String : Currency]? = nil,
        idd: Idd? = nil, capital: [String]? = nil, altSpellings: [String]? = nil,
        region: String? = nil, subregion: String? = nil, languages: Languages? = nil,
        translations: [String : Translation]? = nil, latlng: [Double]? = nil,
        landlocked: Bool? = nil, area: Double? = nil, demonyms: [String : Eng]? = nil,
        flag: String? = nil, maps: Maps? = nil, population: Int? = nil, car: Car? = nil,
        timezones: [String]? = nil, continents: [String]? = nil, flags: Flags? = nil,
        coatOfArms: CoatOfArms? = nil, startOfWeek: String? = nil,
        capitalInfo: [String : [Double]]? = nil, cioc: String? = nil, fifa: String? = nil,
        borders: [String]? = nil, gini: [String : Double]? = nil, postalCode: PostalCode? = nil
    ) {
        self.name = name
        self.tld = tld
        self.cca2 = cca2
        self.ccn3 = ccn3
        self.cca3 = cca3
        self.independent = independent
        self.status = status
        self.unMember = unMember
        self.currencies = currencies
        self.idd = idd
        self.capital = capital
        self.altSpellings = altSpellings
        self.region = region
        self.subregion = subregion
        self.languages = languages
        self.translations = translations
        self.latlng = latlng
        self.landlocked = landlocked
        self.area = area
        self.demonyms = demonyms
        self.flag = flag
        self.maps = maps
        self.population = population
        self.car = car
        self.timezones = timezones
        self.continents = continents
        self.flags = flags
        self.coatOfArms = coatOfArms
        self.startOfWeek = startOfWeek
        self.capitalInfo = capitalInfo
        self.cioc = cioc
        self.fifa = fifa
        self.borders = borders
        self.gini = gini
        self.postalCode = postalCode
    }
}

// MARK: Car
struct Car: Codable {
    var signs: [String]?
    var side: String?
}

// MARK: CoatOfArms
struct CoatOfArms: Codable {
    var png: String?
    var svg: String?
}

// MARK: Currency
struct Currency: Codable {
    var name, symbol: String?
}

// MARK: Eng
struct Eng: Codable {
    var f, m: String?
}

// MARK: Flags
struct Flags: Codable {
    var png: String?
    var svg: String?
    var alt: String?
}

// MARK: Idd
struct Idd: Codable {
    var root: String?
    var suffixes: [String]?
}

// MARK: Languages
struct Languages: Codable {
    var eng, fra, gsw, ita: String?
    var roh: String?
}

// MARK: Maps
struct Maps: Codable {
    var googleMaps, openStreetMaps: String?
}

// MARK: Name
struct Name: Codable {
    var common, official: String?
    var nativeName: [String: Translation]?
    
    init(common: String, official: String?, nativeName: [String: Translation]? = nil) {
        self.common = common
        self.official = official
        self.nativeName = nativeName
    }
}

// MARK: Translation
struct Translation: Codable {
    var official, common: String?
}

// MARK: PostalCode
struct PostalCode: Codable {
    var format, regex: String?
}

