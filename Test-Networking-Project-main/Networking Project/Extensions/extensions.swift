//
//  extensions.swift
//  Networking Project
//
//  Created by Clarke Kent on 7/10/22.
//

import Foundation
import UIKit

extension String {
    var lettersAndSpaces: String {
        return components(separatedBy: CharacterSet.letters.union(.whitespaces).inverted).joined()
    }

   var isEmptyOrWhitespace: Bool {
    let whitespace = CharacterSet.whitespacesAndNewlines
    return self.trimmingCharacters(in: whitespace).isEmpty
   }
}


extension UIView {
    static let loadingViewTag = 1938123987
    func showLoading(style: UIActivityIndicatorView.Style = .medium) {
        var loading = viewWithTag(UIImageView.loadingViewTag) as? UIActivityIndicatorView
        if loading == nil {
            loading = UIActivityIndicatorView(style: style)
        }

        loading?.translatesAutoresizingMaskIntoConstraints = false
        loading!.startAnimating()
        loading!.hidesWhenStopped = true
        loading?.tag = UIView.loadingViewTag
        addSubview(loading!)
      loading?.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        loading?.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }

    func stopLoading() {
        let loading = viewWithTag(UIView.loadingViewTag) as? UIActivityIndicatorView
        loading?.stopAnimating()
        loading?.removeFromSuperview()
    }
}

