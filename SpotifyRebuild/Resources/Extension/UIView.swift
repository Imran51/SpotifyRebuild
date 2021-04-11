//
//  UIView.swift
//  SpotifyRebuild
//
//  Created by Imran Sayeed on 10/3/21.
//

import UIKit

extension UIView {
    var width: CGFloat {
        return frame.size.width
    }

    var height: CGFloat {
        return frame.size.height
    }

    var left: CGFloat {
        return frame.origin.x
    }

    var right: CGFloat {
        return left + width
    }

    var top: CGFloat {
        return frame.origin.y
    }

    var bottom: CGFloat {
        return top + height
    }
    
    func addSubViews(_ views: UIView...) {
        views.forEach({
            self.addSubview($0)
        })
    }
}
