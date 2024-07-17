//
//  CompanyInfo.swift
//  CompanySearchApp
//
//  Created by KKNANXX on 7/16/24.
//

import Foundation

struct CompanysInfo: Codable, Hashable {
    let entities: [CompanyInfo]

    enum CodingKeys: String, CodingKey {
        case entities
    }
}

struct CompanyInfo: Codable, Hashable {
    let identifier: CompanyDetails
    let description: String?

    enum CodingKeys: String, CodingKey {
        case identifier
        case description = "short_description"
    }
}

struct CompanyDetails: Codable, Hashable {
    let uuid: String?
    let value: String?
    let entityID: String?

    enum CodingKeys: String, CodingKey {
        case uuid
        case value
        case entityID = "entity_def_id"
    }
}
