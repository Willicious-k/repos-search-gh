//
//  SearchEndpoint.swift
//  repos-search-gh
//
//  Created by 김성종 on 2023/02/23.
//

import Foundation
import Moya

enum SearchEndpoint: Moya.TargetType {
    case searchRepositories

    var baseURL: URL {
        URL(string: "https://api.github.com")!
    }

    var path: String {
        return "search/repositories"
    }

    var method: Moya.Method {
        .get
    }

    var task: Moya.Task {
        var params: [String: Any] = [:]
        params["q"] = "Q"
        return .requestParameters(
            parameters: params,
            encoding: URLEncoding.queryString
        )
    }

    var headers: [String : String]? {
        var dic: [String: String] = [:]
        dic.updateValue("application/vnd.github+json", forKey: "Accept")
        dic.updateValue("2022-11-28", forKey: "X-GitHub-Api-Version")
        return dic
    }
}
