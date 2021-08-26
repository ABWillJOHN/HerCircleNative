//
//  LeftMenuViewController.swift
//  side+tab
//
//  Created by Rahul Patel on 24/06/21.
//

import UIKit

class LeftMenuViewController: UIViewController {

    var tabbar = TabBarHomeVC()
    var sbMain = UIStoryboard(name: StoryboardID.main, bundle: nil)
    var sbConnect = UIStoryboard(name: StoryboardID.connect, bundle: nil)
    var sbEngage = UIStoryboard(name: StoryboardID.engage, bundle: nil)
    var sbGrow = UIStoryboard(name: StoryboardID.grow , bundle: nil)
    var sbGoal = UIStoryboard(name: StoryboardID.goal, bundle: nil)

    //MARK:- IBOutlet And Variable Declaration
    //Note:- compare name with Enume.swift left menu "case sensitive"
    var leftMenu = ["Home Tab", "Connect Tab", "Engage Tab", "Grow Tab", "Goals Tab", "Help Tab", "Setting Tab"]
    @IBOutlet weak var tableLeftMenu: UITableView!

    //MARK:- UIViewController Initialize Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableLeftMenu.tableFooterView = UIView()
    }

    //MARK:- Other Methods
    func changeMainViewController(to viewController: UIViewController) {
        //Change main viewcontroller of side menu view controller
        let navigationViewController = UINavigationController(rootViewController: viewController)
        slideMenuController()?.changeMainViewController(navigationViewController, close: true)
    }
}

//MARK:- UITableViewDataSource Methods
extension LeftMenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leftMenu.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let tableViewCell = UITableViewCell()
        tableViewCell.textLabel?.text = leftMenu[indexPath.row]
        tableViewCell.selectionStyle = .none
        tableViewCell.backgroundColor = UIColor(red: 224/255, green: 230/255, blue: 230/255, alpha: 1.0)
        return tableViewCell
    }
}

//MARK:- UITableViewDelegate Methods
extension LeftMenuViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let leftHeaderView = loadFromNibNamed(ViewID.leftHeaderView) as? LeftHeaderView else {
            print("Left Header view not found")
            return nil
        }
        return leftHeaderView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 160
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        guard let leftMenuItem = LeftMenuItems(rawValue: leftMenu[indexPath.row]) else {
            print("Left Menu Item not found")
            return
        }
        switch leftMenuItem {
        case .homeVC: self.tabbar.selectedIndex = 0
//        case .helpVC:
//            guard let helpVC = storyboard?.instantiateViewController(withIdentifier: ViewControllerID.helpVC) as? HelpVC else {
//                return
//            }
//            changeMainViewController(to: helpVC)
//            //self.tabbar.selectedIndex = 1
//        case .settingsVC: self.tabbar.selectedIndex = 2
        case .helpVC, .settingsVC:
            let toIndex = (leftMenuItem == .helpVC) ? TabItem.settings.rawValue : TabItem.help.rawValue

            //Check here Custom TabBar ViewController is already exist then we just set index other wise we instantiate view controller and set index
            if let customTabBar = ((slideMenuController()?.mainViewController as? UINavigationController)?.viewControllers.first as? TabBarHomeVC) {

                customTabBar.selectedIndex = toIndex
                changeMainViewController(to: customTabBar)

            } else {
                guard let customTabBar = storyboard?.instantiateViewController(withIdentifier: ViewControllerID.tabBarHomeVC) as? TabBarHomeVC else {
                        return
                }
                customTabBar.selectedIndex = 0
                //customTabBar.setSelectIndex(from: 0, to: toIndex)
                changeMainViewController(to: customTabBar)
            }
        case .connectVC: break
//            guard let tabViewController = sbMain.instantiateViewController(withIdentifier: ViewControllerID.homeVC) as? HomeVC else {
//                return
//            }
//            changeMainViewController(to: tabViewController)
        case .engageVC:
            guard let tabViewController = sbEngage.instantiateViewController(withIdentifier: ViewControllerID.engageVC) as? EngageVC else {
                return
            }
            changeMainViewController(to: tabViewController)

        case .growVC: break
//            guard let tabViewController = sbGrow.instantiateViewController(withIdentifier: ViewControllerID.homeVC) as? HomeVC else {
//                return
//            }
//            changeMainViewController(to: tabViewController)
            
        case .goalsVC: break
//            guard let tabViewController = sbGoal.instantiateViewController(withIdentifier: ViewControllerID.homeVC) as? HomeVC else {
//                return
//            }
//            changeMainViewController(to: tabViewController)

        }
    }
}

