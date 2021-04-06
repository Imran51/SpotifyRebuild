//
//  DateFormatter.swift
//  SpotifyRebuild
//
//  Created by Imran Sayeed on 6/4/21.
//

import Foundation

extension DateFormatter {
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        
        return dateFormatter
    }()
    
    static let displayDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        return dateFormatter
    }()
}
