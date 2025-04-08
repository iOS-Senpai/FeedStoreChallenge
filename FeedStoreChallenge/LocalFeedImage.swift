//
//  LocalFeedImage.swift
//  Phoenix Framework
//
//  Created by xavient on 07/02/25.
//

import Foundation

public struct LocalFeedImage: Equatable {
    
    public let id: UUID
    public let description: String?
    public let location: String?
    public let url: URL
    
    public init(id: UUID, description: String? = nil, location: String? = nil, url: URL) {
        self.id = id
        self.description = description
        self.location = location
        self.url = url
    }
} // In Software Literature It is called Date Transfer Object to decouple modules or components from source code dependency. (Decentralizing)
