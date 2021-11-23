//
//  FactsViewModel.swift
//  ProofOfConcept
//
//  Created by Sourabh Dubey on 19/11/21.
//

import Foundation

final class FactsViewModel: BaseViewModel, FactsViewModelProtocol {
    
    //MARK:- Vars
    let queue = DispatchQueue.global(qos: .userInitiated)
    var downloadManager: DownloadManagerImage?
    var factsApiService: FactsApiServicesProtocol?
    var factData: Facts?
    var reloadListClosure: ReloadClosure = { () in
        //reload The Data
    }
    var errorClosure: ErrorClosure  = { (_ ) in
        //show error on ViewController
    }
    
    //MARK:- Initilizer Methods
    override init() {
        super.init()
        self.factsApiService = FactsApiServices.init();
        self.downloadManager = DownloadManagerImage.init()
//        self.callFactsApi()
    }
    
}

private extension FactsViewModel {
    // Get The Facts Details For Particular Fact
    private func getFactFromParticularIndex(_ index: Int) -> FactDetails? {
        guard let factData = self.factData else {return nil}
        
        if let arrFactDetails = factData.factDetails, arrFactDetails.count > 0 {
            return arrFactDetails[index]
        }
        return nil
    }
}

internal extension FactsViewModel {
    // Get The Fact Data
    func callFactsApi() {
        queue.async {
            guard let factsApiService = self.factsApiService else {
                return
            }
            factsApiService.getFactsData(completion: { [weak self] facts, error in
                guard let weakSelf = self else {return}
                if error == nil {
                    if var factsData = facts {
                        if let data = factsData.factDetails?.filter({ factDetails in
                            if factDetails.title == nil && factDetails.description == nil && factDetails.imageHref == nil {
                                return false
                            }
                            return true
                        }) {
                            
                            factsData.updateFactDetais(data)
                            weakSelf.factData = factsData
                            weakSelf.reloadListClosure()
                        }
                    }
                } else if let actualError = error {
                    weakSelf.errorClosure(actualError)
                    print("The Error :: \(actualError.localizedDescription)")
                }
            })
        }
    }
    
    //Get The count Of Fact
    func numberOfFactsCount() -> Int {
        guard let factData = self.factData, let arrFactDetails = factData.factDetails else {return 0}
        return arrFactDetails.count
    }
    
    //Get The Title Of Fact for Particular Index
    func getFactsDetailsTitle(_ index: Int) -> String {
        
        if let factDetail = self.getFactFromParticularIndex(index) , let title = factDetail.title {
            return title
        }
        return ""
    }
    
    //Get The Details of Fact for Particular Fact
    func getFactsDetailsDesc(_ index: Int) -> String {
        if let factDetail = self.getFactFromParticularIndex(index) , let description = factDetail.description {
            return description
        }
        return ""
    }
    
    //Get The Image of Fact for Particular Fact
    func getFactsImage(_ index: Int) -> String {
        if let factDetail = self.getFactFromParticularIndex(index) , let strImageUrl = factDetail.imageHref {
            return strImageUrl
        }
        return ""
    }
    
    //Get The Title
    func getHeaderTitle() -> String {
        guard let factData = self.factData else {return ""}
        if let title = factData.title {
            return title
        }
        return ""
    }
    
    func getDownloadImage(_ strImageUrl:String, _ indexPath:IndexPath, handler: @escaping ImageDownloadHandler) {
        downloadManager?.downloadImage(strImageUrl, indexPath: indexPath) { image, indexPath, error in
            handler(image,indexPath,error)
        }
    }
    
    func slowDownloadImage(_ strImageUrl:String) {
        downloadManager?.slowDownImageDownloadTaskfor(strImageUrl)
    }
    
    func refreshFactApi() {
        self.factData = nil
        downloadManager?.cancelAll()
        self.callFactsApi()
    }
}
