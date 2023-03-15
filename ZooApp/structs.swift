import Foundation

struct OnboardingSlide: Codable {
    let title: String
    let text: String
    let image: String
}

struct ZooList: Codable {
    let image: String?
    let name: String
    let info: String
    let rating: Double
    let about: [AboutZooList]?
    let animals: [AnimalsList]?
}

struct AboutZooList: Codable {
    let image: String
    let name: String
    let info: String
    let address: String
    let phone: String
}

struct AnimalsList: Codable {
    let image: String
    let name: String
    let animal: [AboutAnimal]
}

struct AboutAnimal: Codable {
    let image: String
    let name: String
    let info: String
}
// zoolist Page

struct ZooListPage: Codable{
    let name: String
    let info: String
    let rating: Double
    
//    static func all() -> [ZooListPage]{
//        return[
//        ZooListPage(name: "Zoo Khatai", info: "Khudu Mammadov 29", rating: 98),
//        ZooListPage(name: "Zoo Nizami", info: "Qara Qarayev 124", rating: 95),
//        ZooListPage(name: "Zoo Narimanov", info: "Jeyhun Hacibeyli 18", rating: 88),
//        ZooListPage(name: "Zoo Sabail", info: "Street 33", rating: 99),
//        ZooListPage(name: "Zoo Nesimi", info: "Street 29", rating: 86),
//        ]
//    }
}
