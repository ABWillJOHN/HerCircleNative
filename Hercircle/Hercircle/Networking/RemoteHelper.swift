//
//  RemoteHelper.swift
//  Stationmd
//
//  Created by ankit shelar on 01/04/20.
//  Copyright © 2020 Ishwar. All rights reserved.
//

import Foundation

fileprivate let enviroment = Enviroment.dev

enum ResponseError {
    case noData
    case worngData
    
    var errorDescription: String {
        switch self {
        case .noData: return "There is no data available, Please contact support team."
        case .worngData: return "Something went wrong, Please try again later!!!"
        }
    }
}

enum Enviroment {
    case sit
    case dev
    case test
    case uat
    case live
}

extension Enviroment {
    var HTTPProtocol: String {
        switch self {
            case .sit: return "http://10.161.47.15/"
            case .dev: return "http://10.160.137.82:8080/"
            case .test: return "http://"
            case .uat: return "https://"
            case .live: return "https://"
        }
    }
    
//    var domain: String {
//        switch self {
//            case .dev: return "10.160.137.82:8080/hccms_engagearticle"
//            case .test: return ""
//            case .uat: return "app-staging.stationmd.com"
//            case .live: return "app.stationmd.com"
//        }
//    }
//
//    var folder: String {
//        switch self {
//            case .dev: return "/api/"
//            case .test: return "/api/"
//            case .uat: return "/api/"
//            case .live: return "/api/"
//        }
//    }
}

enum BaseUrl {
    case baseUrl
}

extension BaseUrl {
    var baseUrlString : String {
        switch self {
        case .baseUrl: return enviroment.HTTPProtocol //+ enviroment.domain + enviroment.folder
        //case .homeUrl: return enviroment.HTTPProtocol + enviroment.domain
        
    }
}
}
//enum RemoteService {
//    case validateDevice
//    case activateDevice
//    case getSite
//    case getMeetings(siteId : String)
//    case QRCode
// }
//
//extension RemoteService {
//    var url : URL {
//        switch self {
//        case .validateDevice: return URL(string: BaseUrl.baseUrl.baseUrlString + enviroment.folder + endPoint.ValidateUsername)!
//        case .activateDevice: return URL(string: BaseUrl.baseUrl.baseUrlString + enviroment.folder + UrlConstant.activateDevice.identifer)!
//        case .getSite: return URL(string: BaseUrl.baseUrl.baseUrlString + enviroment.folder + UrlConstant.getSite.identifer)!
//        case .getMeetings(let siteId): return URL(string: BaseUrl.baseUrl.baseUrlString + enviroment.folder + UrlConstant.getMeetings.identifer + "?site_id=\(siteId)")!
//        case .QRCode: return URL(string: BaseUrl.baseUrl.baseUrlString + enviroment.folder + UrlConstant.QRregister.identifer)!
//        }
//    }
//}
