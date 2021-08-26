//
//  SegmentVC.swift
//  Hercircle
//
//  Created by Apple on 10/08/21.
//

import UIKit
import Segmentio

class SegmentVC: UIViewController {
    var page = 0
    var selectedIndex =  0

    var segmentioStyle = SegmentioStyle.imageOverLabel

    @IBOutlet private var segmentViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet private var segmentioView: Segmentio!
    @IBOutlet private var containerView: UIView!
    @IBOutlet private var scrollView: UIScrollView!

    private lazy var viewControllers: [UIViewController] = {
        return self.preparedViewControllers()
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "diet & fitness goal"

        switch segmentioStyle {
        case .onlyLabel, .imageBeforeLabel, .imageAfterLabel:
            segmentViewHeightConstraint.constant = 50
        case .onlyImage:
            segmentViewHeightConstraint.constant = 100
        default:
            break
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        setupScrollView()
        SegmentionUI.buildSegmentioView(
            segmentioView: segmentioView,
            segmentioStyle: segmentioStyle, segmentioPosition: .fixed(maxVisibleItems: 5)
        )
      //  SegmentioBuilder.setupBadgeCountForIndex(segmentioView, index: 1)

        segmentioView.valueDidChange = { [weak self] _, segmentIndex in
            if let scrollViewWidth = self?.scrollView.frame.width {
                let contentOffsetX = scrollViewWidth * CGFloat(segmentIndex)
                self?.scrollView.setContentOffset(
                    CGPoint(x: contentOffsetX, y: 0),
                    animated: true
                )
                switch segmentIndex
                {
                case 0:
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue:"calendar"), object: nil)

                case 1:
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue:"analytics"), object: nil)
                case 2:
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue:"insights"), object: nil)
                case 3:
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue:"communities"), object: nil)
                case 4:
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue:"settings"), object: nil)

                default:
                    break
                }
            }
        }
        segmentioView.selectedSegmentioIndex = selectedSegmentioIndex()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)


        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.setNavigationBarHidden(false, animated: false)

        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)

    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: false)

        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)

    }
    // Example viewControllers

    private func preparedViewControllers() -> [UIViewController] {

//        let storyboardObject = UIStoryboard (name :"Period", bundle:nil)

        let CalendarPeriodVC = DiaryViewVC()
        let AnalyticsPeriodVC = DiaryViewVC()
        let InsightsPeriodVC = DiaryViewVC()
        let CommunitiesPeriodVC = DiaryViewVC()
        let SettingsPeriodVC = DiaryViewVC()

        return [CalendarPeriodVC,AnalyticsPeriodVC,InsightsPeriodVC,CommunitiesPeriodVC,SettingsPeriodVC]
    }

    private func selectedSegmentioIndex() -> Int {
        return 0
    }

    // MARK: - Setup container view

    private func setupScrollView() {
        scrollView.contentSize = CGSize(
            width: UIScreen.main.bounds.width * CGFloat(viewControllers.count),
            height: containerView.frame.height + 100
        )

        for (index, viewController) in viewControllers.enumerated() {
            viewController.view.frame = CGRect(
                x: UIScreen.main.bounds.width * CGFloat(index),
                y: 0,
                width: view.frame.width,
                height: view.frame.height
            )
            addChild(viewController)
            scrollView.addSubview(viewController.view, options: .useAutoresize) // module's extension
            viewController.didMove(toParent: self)
        }
    }

    // MARK: - Actions

    private func goToControllerAtIndex(_ index: Int) {
        segmentioView.selectedSegmentioIndex = index
    }
}
extension SegmentVC: UIScrollViewDelegate {

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let currentPage = floor(scrollView.contentOffset.x / scrollView.frame.width)
        segmentioView.selectedSegmentioIndex = Int(currentPage)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentSize = CGSize(width: scrollView.contentSize.width, height: 0)
    }
}
