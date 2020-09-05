//
//  PreSignedImageURL.swift
//  PreSignedImageKingFisher
//
//  Created by Hai Pham on 9/5/20.
//  Copyright © 2020 Hai Pham. All rights reserved.
//

import Kingfisher

/// Custom URL class for Kingfisher.
///
/// Because presigned image url will change every time api calling,
/// so to prevent duplicate caching image resource, we should only cache image url that exclude presigned suffix
struct PresignedImageURL: Resource {
    var cacheKey: String {
        let cacheKey: String
        let isPresigned = self.downloadURL.absoluteString.isPresigned ?? false
        if isPresigned, let index = self.downloadURL.absoluteString.firstIndex(of: "?") {
            cacheKey = String(self.downloadURL.absoluteString.prefix(upTo: index))
        } else {
            cacheKey = self.downloadURL.absoluteString
        }
        return cacheKey
    }
    
    var downloadURL: URL {
        return _url!
    }
    
    private var _url: URL? = nil
    
    init?(string urlString: String) {
        let url = URL(string: urlString)
        if let url = url {
            self._url = url
        } else {
            return nil
        }
    }
}

private var AssociatedObjectHandle: UInt8 = 0

extension String {
    /// Custom variable that determine the image url has been presigned or not
    var isPresigned: Bool? {
        get {
            return objc_getAssociatedObject(self, &AssociatedObjectHandle) as? Bool
        }
        set {
            objc_setAssociatedObject(self, &AssociatedObjectHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
