//
//  Networking.swift
//  Network
//
//  Created by Glny Gl on 15/10/2024.
//
import Foundation

public protocol NetworkingProtocol {
    func request<T: Decodable, R: URLRequestable>(requestable: R, responseType: T.Type ) async -> Result<T, NetworkError>
}

public final class Networking {
    private let session: URLSession
    private let helper: URLRequestHelperProtocol
    private let parser: ResponseParserProtocol
    private let executor: RequestExecutorProtocol
    
    public init() {
        self.session = URLSession(configuration: .default)
        self.helper = URLRequestHelper()
        self.parser = ResponseParser()
        self.executor = RequestExecutor(session: .shared)
    }
    
    deinit {
        session.finishTasksAndInvalidate()
    }
}

extension Networking: NetworkingProtocol {
    
    public func request<T, R>(requestable: R,
                              responseType: T.Type) async -> Result<T, NetworkError> where T : Decodable, R: URLRequestable {
        do {
            let urlRequest = try helper.makeURLRequest(requestable: requestable)
            let result = await executor.execute(urlRequest)
            switch result {
            case .success(let successModel):
                return successRequest(with: successModel, responseType: responseType)
            case .failure(let error):
                let error = failRequest(error: error)
                return .failure(error)
            }
        } catch let networkError as NetworkError {
            return .failure(networkError)
        } catch {
            let error = NetworkError.unknown
            return .failure(error)
        }
    }
}

extension Networking {
    private func successRequest<T: Decodable>(with successModel: RequestSuccess, responseType: T.Type) ->
    Result<T,NetworkError> {
        let httpResponseStatus = successModel.response.responseStatus
        switch httpResponseStatus {
        case .success:
            return didReceiveSuccessStatusCode(
                with: successModel,
                responseType: responseType
            )
        case .failure(let error):
            return .failure(error)
        }
    }
    
    private func didReceiveSuccessStatusCode<T: Decodable>(with successModel: RequestSuccess, responseType: T.Type) -> Result<T, NetworkError> {
        let parsingResult = parser.parseResponse(data: successModel.data, responseType: responseType)
        return parsingResult
    }
    
    private func failRequest(error: Error) -> NetworkError {
        let nsError = error as NSError
        
        if nsError.code == NSURLErrorTimedOut {
            return .requestTimedOut
        } else if nsError.code == NSURLErrorNotConnectedToInternet {
            return .noInternetConnection
        } else if nsError.code == NSURLErrorCancelled {
            return .requestCancelled
        } else {
            return .executionError
        }
    }
}
