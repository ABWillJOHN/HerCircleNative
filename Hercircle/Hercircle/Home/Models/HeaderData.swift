//
//  HeaderData.swift
//  Hercircle
//
//  Created by vishal modem on 7/20/21.
//

import UIKit

struct HeaderData {
    let title: String
    let description: String?
    let titleColor: (r: CGFloat, g: CGFloat, b: CGFloat)
    
    static func getHeaderData() -> [HeaderData] {
        return [
            HeaderData(title: "goals track", description: "Be your best, keep track of your health using our dedicated trackers", titleColor: (56, 56, 56)),
            HeaderData(title: "connect communities", description: "Discover and follow communities of your interests", titleColor: (144, 117, 209)),
            HeaderData(title: "today's top picks", description: nil, titleColor: (64, 133, 164)),
            HeaderData(title: "must-watch videos", description: nil, titleColor: (58, 94, 167)),
            HeaderData(title: "grow jobs", description: "Discover and follow communities of your interests", titleColor: (39, 156, 142)),
            HeaderData(title: "creative corner", description: nil, titleColor: (39, 156, 142))
        ]
    }
}
