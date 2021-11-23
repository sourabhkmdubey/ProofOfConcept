//
//  FactsViewModelProtocol.swift
//  ProofOfConcept
//
//  Created by Sourabh Dubey on 19/11/21.
//

import Foundation

typealias ReloadClosure  = (() -> Void)
typealias ErrorClosure  = ((_ error:Error?) -> Void)

protocol FactsViewModelProtocol: AnyObject {
    var factsApiService: FactsApiServicesProtocol? {get set}
    var downloadManager: DownloadManagerImage? {get set}
    var factData: Facts? {get set}
    var reloadListClosure: ReloadClosure {get set}
    var errorClosure: ErrorClosure {get set}
    func callFactsApi()
    func numberOfFactsCount() -> Int
    func getFactsDetailsTitle(_ index: Int) -> String
    func getFactsDetailsDesc(_ index: Int) -> String
    func getFactsImage(_ index: Int) -> String
    func getDownloadImage(_ strImageUrl:String, _ indexPath:IndexPath, handler: @escaping ImageDownloadHandler)
    func slowDownloadImage(_ strImageUrl:String)
    func refreshFactApi()
    func getHeaderTitle() -> String
}
