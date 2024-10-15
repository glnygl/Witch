//
//  ResponseParser.swift
//  Network
//
//  Created by Glny Gl on 15/10/2024.
//

import Foundation

protocol ResponseParserProtocol {
    func parseResponse<T: Decodable>(data: Data, responseType: T.Type) -> Result<T, NetworkError>
}

class ResponseParser : ResponseParserProtocol {
     func parseResponse<T: Decodable>(data: Data, responseType: T.Type) -> Result<T, NetworkError> {
        let decoder = JSONDecoder()
        do {
            let decodedModel = try decoder.decode(T.self, from: data)
            return .success(decodedModel)
        } catch let error as DecodingError {
            let message = messageForDecodingError(error)
            return .failure(NetworkError.parse(message: message))
        } catch {
            return .failure(NetworkError.parse(message: "unknown"))
        }
    }
}

extension ResponseParser {
    private func messageForDecodingError(_ error: DecodingError) -> String {
        switch error {
        case .typeMismatch:
            return "Type mismatch error"
        case .valueNotFound:
            return "Value not found error"
        case .keyNotFound:
            return "Key not found error key"
        case .dataCorrupted:
            return "Data corrupted error"
        default:
            return "Undefined decoding error"
        }
    }
}
