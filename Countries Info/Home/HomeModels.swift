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
}

// MARK: Translation
struct Translation: Codable {
    var official, common: String?
}

// MARK: PostalCode
struct PostalCode: Codable {
    var format, regex: String?
}

