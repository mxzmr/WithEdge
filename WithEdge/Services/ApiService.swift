//
//  ApiService.swift
//  WithEdge
//
//  Created by Max zam on 19/07/2025.
//
import Foundation

enum ApiError: Error {
    case invalidResponse
    case httpError(Int)
    case decodingError(Error)
    case networkError(Error)
}

protocol ApiService {
    func fetch <T: Codable>(from url: URL) async throws -> T
}

class ApiServiceImpl: ApiService {
    private let decoder: JSONDecoder = JSONDecoder()
    
    func fetch<T: Decodable>(from url: URL) async throws -> T {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ApiError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw ApiError.httpError(httpResponse.statusCode)
        }
        
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw ApiError.decodingError(error)
        }
    }
}

class MockApiService: ApiService {
    let mockData: Decodable
    
    func fetch<T: Decodable>(from url: URL) async throws -> T {
        guard let data = mockData as? T else {
            throw ApiError.decodingError(NSError(domain: "Mock", code: -1))
        }
        return data
    }
    
    init(mockData: Decodable) {
        self.mockData = mockData
    }
}
