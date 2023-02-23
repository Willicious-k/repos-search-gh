//
//  BaseNetworkAgent.swift
//  planet-job-listings
//
//  Created by 김성종 on 2023/02/23.
//

import Foundation
import Alamofire
import Moya
import RxMoya
import RxSwift

class BaseNetworkAgent<T: TargetType> {
    private var provider: MoyaProvider<T>!

    init() {
        self.provider = MoyaProvider<T>(
            callbackQueue: DispatchQueue.global(),
            session: networkSession(),
            plugins: plugins()
        )
    }

    func requestOptional<D: Decodable>(
        target: T,
        responseType: D.Type,
        atKeyPath responseKeyPath: String? = nil
    ) -> Observable<D?> {
        return provider.rx.request(target)
            .filterSuccessfulStatusCodes()
            .map(responseType, atKeyPath: responseKeyPath)
            .asObservable()
            .map { decodedResponse -> D? in
                return decodedResponse
            }
            .catch { error -> Observable<D?> in
                print(error.localizedDescription)
                return Observable.just(nil)
            }
            .observe(on: MainScheduler.asyncInstance)
    }
}

extension BaseNetworkAgent {
    private func plugins() -> [PluginType] {
    #if DEBUG
        return [loggerPlugin]
    #else
        return []
    #endif
    }

    private var loggerPlugin: NetworkLoggerPlugin {
        let JSONResponseStringFormatter: (_ data: Data) -> String = { data in
            guard
                !data.isEmpty
            else {
                return "response body data is empty"
            }

            do {
                let dataAsJSON = try JSONSerialization.jsonObject(with: data)
                let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
                let prettyString = String(data: prettyData, encoding: .utf8) ?? "Failed to parse log string"
                return prettyString
            } catch {
                return "Failed to parse log string"
            }
        }

        let formatters = NetworkLoggerPlugin.Configuration.Formatter(
            requestData: JSONResponseStringFormatter,
            responseData: JSONResponseStringFormatter
        )
        let configuration = NetworkLoggerPlugin.Configuration(
            formatter: formatters,
            logOptions: .verbose
        )
        let moyaLogger = NetworkLoggerPlugin(configuration: configuration)
        return moyaLogger
    }

    private func networkSession() -> Alamofire.Session {
        let configuration = URLSessionConfiguration.default
        configuration.headers = HTTPHeaders.default
        configuration.timeoutIntervalForRequest = 20
        configuration.timeoutIntervalForResource = 20
        return Alamofire.Session(configuration: configuration)
    }
}
