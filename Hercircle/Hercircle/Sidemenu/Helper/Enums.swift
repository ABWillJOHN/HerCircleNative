//
//  Enums.swift
//
//  Created by Rahul Patel on 20/04/18.
//


//Note:- Add new VC in LeftMenuItems and in ViewControllerID.
// Add new Tabbar item in TabItem

enum LeftMenuItems: String {
    case homeVC = "Home Tab"
    case connectVC = "Connect Tab"
    case engageVC = "Engage Tab"
    case growVC = "Grow Tab"
    case goalsVC = "Goals Tab"
    case helpVC = "Help Tab"
    case settingsVC = "Setting Tab"
}

enum TabItem: Int {
    case home = 0
    case help
    case settings
    
    init() {
        self = .home
    }
}

enum ViewControllerID {
    static let leftMenuViewController = "LeftMenuViewController"
    static let rightMenuViewController = "RightMenuViewController"
    static let tabBarHomeVC = "TabBarHomeVC"
    static let homeVC = "HomeVC"
    static let helpVC = "HelpVC"
    static let settingsVC = "SettingsVC"


    static let connectVC = "ConnectVC"
    static let engageVC = "EngageVC"
    static let growVC = "GrowVC"
    static let goalsVC = "GoalsVC"




}

enum ViewID {
    static let leftHeaderView = "LeftHeaderView"
}

enum StoryboardID {
    static let main = "Main"
    static let connect = "Connect"
    static let engage = "Engage"
    static let goal = "Goal"
    static let grow = "Grow"
}
