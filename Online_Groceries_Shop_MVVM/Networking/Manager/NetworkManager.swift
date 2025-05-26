//
//  NetworkManager.swift
//  MutualFundSDK
//
//  Created by Darshan Mothreja on 11/12/20.
//  Copyright © 2019 Darshan. All rights reserved.
//

import Foundation

enum NetworkResponse:String {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
    case serverError = "Internal server error."
}

enum Result<String>{
    case success
    case failure(String)
}

enum NetworkEnvironment {
    case qa
    case uat
    case prod
}

protocol FetcherServiceProtocol {
    func request<T: Decodable>(_ route: EndPointType, showHud: Bool, completion: @escaping (T?, String?, Int?) -> ())
    func requestDownload(_ route: EndPointType, showHud: Bool, completion: @escaping (Data?, String?, Int?) -> ())
}

extension FetcherServiceProtocol {
	func request<T: Decodable>(_ route: EndPointType, showHud: Bool = true, completion: @escaping (T?, String?, Int?) -> ()) { }
	func requestDownload(_ route: EndPointType, showHud: Bool, completion: @escaping (Data?, String?, Int?) -> ()) { }
}

struct NetworkManager: FetcherServiceProtocol {

    static let environment : NetworkEnvironment = .qa
//    static var targetAppAtAEM: AEMTargetApp = .none
	static var isEnterIntoNetwork: Bool = false
	static var savedRequests: [DispatchWorkItem] = []
    
    let router = Router()
    
    func request<T: Decodable>(_ route: EndPointType, showHud: Bool = true, completion: @escaping (T?, String?, Int?) -> ()) {
        
        if showHud { /*HudView.show()*/ }

        router.request(route) { (data, response, error) in
            if showHud { /*HudView.kill()*/ }
            guard let responseData = data, error == nil else {
                // Show error through alert
//                HudView.kill()
                return
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                switch result {
                case .success:
                    do {
                        let model = try JSONDecoder().decode(T.self, from: responseData)
                        completion(model, nil, response.statusCode)
                    } catch let jsonErr {
                        print("failed to decode, \(jsonErr)")
                        completion(nil, jsonErr.localizedDescription, response.statusCode)
                    }
                case .failure(let networkFailureError):
                    print("Error ===== ", networkFailureError)
                    completion(nil, networkFailureError, response.statusCode)
                }
            }
        }
    }

	private func saveRequest(_ block: @escaping () -> Void) {
			// Save request to DispatchWorkItem array
		NetworkManager.savedRequests.append( DispatchWorkItem {
			block()
		})
	}

	private func executeAllSavedRequests() {
		print("Validating request: :2 call our API 1 by 1 \(NetworkManager.savedRequests.count)")
		//NetworkManager.savedRequests.reverse()
		NetworkManager.savedRequests.forEach({ DispatchQueue.global().async(execute: $0) })
		NetworkManager.savedRequests.removeAll()
		NetworkManager.isEnterIntoNetwork = false
	}
    
	func requestDownload(_ route: EndPointType, showHud: Bool, completion: @escaping (Data?, String?, Int?) -> ()){

		if showHud { /*HudView.show()*/ }
        
		router.request(route) { (data, response, error) in

			if showHud { /*HudView.kill()*/ }
			guard let _ = data, error == nil else {
				return
			}

			if let response = response as? HTTPURLResponse {
				let result = self.handleNetworkResponse(response)
				switch result {
					case .success:
						completion(data, nil, response.statusCode)
					case .failure(let networkFailureError):
						if response.statusCode == 401 && NetworkManager.isEnterIntoNetwork {
							self.saveRequest {
								self.requestDownload(route, showHud: showHud, completion: completion)
							}
							return
						}else if response.statusCode == 401 && !(NetworkManager.isEnterIntoNetwork) {
							NetworkManager.isEnterIntoNetwork = true
							self.saveRequest {
								self.requestDownload(route, showHud: showHud, completion: completion)
							}
						}else  {
							completion(nil, networkFailureError, response.statusCode)
						}
				}
			}
		}
	}

    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200...400: return .success
        case 401      : return .failure(NetworkResponse.authenticationError.rawValue)
        case 402...500: return .failure(NetworkResponse.serverError.rawValue)
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600:       return .failure(NetworkResponse.outdated.rawValue)
        default:        return .failure(NetworkResponse.failed.rawValue)
        }
    }
}
