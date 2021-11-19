//
//  DownloadManagerImage.swift
//  ProofOfConcept
//
//  Created by Sourabh Dubey on 19/11/21.
//

import Foundation
import UIKit

typealias ImageDownloadHandler = (_ image: UIImage?, _ indexPath: IndexPath?, _ error: Error?) -> Void

final class DownloadManagerImage {
    
    //MARK:- Global Variables
    private var completionHandler: ImageDownloadHandler?
    lazy var imageDownloadQueue: OperationQueue = {
        var queue = OperationQueue()
        queue.name = "com.proofOfConcept.imageDownloadqueue"
        queue.qualityOfService = .userInteractive
        return queue
    }()
    let imageCache = NSCache<NSString, UIImage>()
    
    //Initializer
    init () {
        
    }
    
    /* FUNCTION To The Download functionality to download the Image */
    public func downloadImage(_ strImageUrl: String, indexPath: IndexPath?, handler: @escaping ImageDownloadHandler) {
        self.completionHandler = handler
        guard let url = URL.init(string: strImageUrl)  else {
            return
        }
        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) {
            /* check for the cached image for url, if YES then return the cached image */
            print("Return cached Image for \(url)")
            self.completionHandler?(cachedImage, indexPath, nil)
        } else {
            /* check if there is a download task that is currently downloading the same image. */
            if let operations = (imageDownloadQueue.operations as? [POCOperation])?
                .filter({
                            $0.imageUrl.absoluteString == url.absoluteString
                                && $0.isFinished == false
                                && $0.isExecuting == true
                }),
               let operation = operations.first {
                print("Increase the priority for \(url)")
                operation.queuePriority = .veryHigh
            } else {
                /* create a new task to download the image.  */
                print("Create a new task for \(url)")
                let operation = POCOperation(url: url, indexPath: indexPath)
                if indexPath == nil {
                    operation.queuePriority = .high
                }
                operation.downloadHandler = { (image, indexPath, error) in
                    if let newImage = image {
                        self.imageCache.setObject(newImage, forKey: url.absoluteString as NSString)
                    }
                    self.completionHandler?(image, indexPath, error)
                }
                imageDownloadQueue.addOperation(operation)
            }
        }
    }
    
    /* FUNCTION to reduce the priority of the network operation in case the user scrolls and an image is no longer visible. */
    public func slowDownImageDownloadTaskfor (_ strImageUrl: String) {
        guard let url = URL(string: strImageUrl) else {
            return
        }
        if let operations = (imageDownloadQueue.operations as? [POCOperation])?
            .filter({
                        $0.imageUrl.absoluteString == url.absoluteString
                            && $0.isFinished == false
                            && $0.isExecuting == true
                
            }),
           let operation = operations.first {
            print("Reduce the priority for \(url)")
            operation.queuePriority = .low
        }
    }
    
    /* FUNCTION to Cancel All the executing Operations */
    public func cancelAll() {
        imageDownloadQueue.cancelAllOperations()
    }
    
}
