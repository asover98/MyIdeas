//
//  KeyedDecodingContainer.swift
//
//  Created by Alexander Antonov on 23/07/2018.
//  Copyright © 2018 FINCH Moscow. All rights reserved.
//


struct Safe<Base: Decodable>: Decodable {
    
    let value: Base?
    
    init(from decoder: Decoder) throws {
        
        do {
            let container = try decoder.singleValueContainer()
            self.value = try container.decode(Base.self)
        } catch {
            self.value = nil
        }
    }
    
}


extension KeyedDecodingContainer {
    
    // MARK: - Syntax sugar
    
    func decode<T: Decodable>(_ key: Key, as type: T.Type = T.self) throws -> T {
        return try self.decode(T.self, forKey: key)
    }
    
    func decodeIfPresent<T: Decodable>(_ key: KeyedDecodingContainer.Key) throws -> T? {
        return try decodeIfPresent(T.self, forKey: key)
    }
    
    func decodeSafely<T: Decodable>(_ key: KeyedDecodingContainer.Key) -> T? {
        return self.decodeSafely(T.self, forKey: key)
    }
    
    func decodeSafelyIfPresent<T: Decodable>(_ key: KeyedDecodingContainer.Key) -> T? {
        return self.decodeSafelyIfPresent(T.self, forKey: key)
    }
    
    
    // MARK: - Safe decoding
    
    func decodeSafely<T: Decodable>(_ type: T.Type, forKey key: KeyedDecodingContainer.Key) -> T? {
        let decoded = try? decode(Safe<T>.self, forKey: key)
        return decoded?.value
    }
    
    func decodeSafelyIfPresent<T: Decodable>(_ type: T.Type, forKey key: KeyedDecodingContainer.Key) -> T? {
        let decoded = try? decodeIfPresent(Safe<T>.self, forKey: key)
        return decoded?.value
    }
    
    func decodeSafelyArray<T: Decodable>(of type: T.Type, forKey key: KeyedDecodingContainer.Key) -> [T] {
        let array = decodeSafely([Safe<T>].self, forKey: key)
        return array?.compactMap { $0.value } ?? []
    }
    
    func decodeSafely<T: Decodable>(withKey key: KeyedDecodingContainer.Key, andDefault defaultValue: T) -> T {
        return self.decodeSafely(key) ?? defaultValue
    }
    
}
