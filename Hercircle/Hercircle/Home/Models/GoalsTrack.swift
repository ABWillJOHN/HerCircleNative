//
//  GoalsTrack.swift
//  Hercircle
//
//  Created by vishal modem on 7/16/21.
//

import Foundation

struct GoalsTrack {
    let imageString: String
    let goalName: String
    
    static func getGoalsTrackList() -> [GoalsTrack] {
        return [
            GoalsTrack(imageString: "finance", goalName: "finance"),
            GoalsTrack(imageString: "diet", goalName: "diet & fitness"),
            GoalsTrack(imageString: "fertility", goalName: "fertility & pregnancy"),
            GoalsTrack(imageString: "period", goalName: "period")
        ]
    }
}
