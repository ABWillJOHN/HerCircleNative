//
//  SegmentionUI.swift
//  periodDemo
//
//  Created by Rahul Patel on 29/07/21.
//

import Foundation
import Segmentio
import UIKit

struct SegmentionUI {
//segmentTitleLabelHeight
    static func setupBadgeCountForIndex(_ segmentioView: Segmentio, index: Int) {
        segmentioView.addBadge(
            at: index,
            count: 10,
            color: .red
        )
    }

    static func buildSegmentioView(segmentioView: Segmentio, segmentioStyle: SegmentioStyle, segmentioPosition: SegmentioPosition) {
        segmentioView.setup(
            content: segmentioContent(),
            style: segmentioStyle,
            options: segmentioOptions(segmentioStyle: segmentioStyle, segmentioPosition: segmentioPosition)
        )
    }

    private static func segmentioContent() -> [SegmentioItem] {
        return [
            SegmentioItem(title: "Calendar", image: UIImage.init(named: "diary"), selectedImage: nil),
            SegmentioItem(title: "Analytics", image: UIImage.init(named: "analytics"), selectedImage: nil),
            SegmentioItem(title: "Insights", image: UIImage.init(named: "insights"), selectedImage: nil),
            SegmentioItem(title: "Communities", image: UIImage.init(named: "communities"), selectedImage: nil),
            SegmentioItem(title: "Settings", image: UIImage.init(named: "settings"), selectedImage: nil)
        ]
    }

    private static func segmentioOptions(segmentioStyle: SegmentioStyle, segmentioPosition: SegmentioPosition) -> SegmentioOptions {
        var imageContentMode = UIView.ContentMode.center
        switch segmentioStyle {
        case .imageOverLabel:
            imageContentMode = .center
        default:
            break
        }

        return SegmentioOptions(
            backgroundColor: .white,
            segmentPosition: segmentioPosition,
            scrollEnabled: true,
            indicatorOptions: segmentioIndicatorOptions(),
            horizontalSeparatorOptions: segmentioHorizontalSeparatorOptions(),
            verticalSeparatorOptions: segmentioVerticalSeparatorOptions(),
            imageContentMode: imageContentMode,
            labelTextAlignment: .center,
            labelTextNumberOfLines: 1,
            segmentStates: segmentioStates(),
            animationDuration: 0.3
        )
    }

    private static func segmentioStates() -> SegmentioStates {
        let font = UIFont.exampleAvenirMedium(ofSize: 12)
        return SegmentioStates(
            defaultState: segmentioState(
                backgroundColor: .clear,
                titleFont: font,
                titleTextColor: .gray
            ),
            selectedState: segmentioState(
                backgroundColor: .clear,
                titleFont: font,
                titleTextColor: .systemGreen//.orange
            ),
            highlightedState: segmentioState(
                backgroundColor: .white,
                titleFont: font,
                titleTextColor: .gray
            )
        )
    }

    private static func segmentioState(backgroundColor: UIColor, titleFont: UIFont, titleTextColor: UIColor) -> SegmentioState {
        return SegmentioState(
            backgroundColor: backgroundColor,
            titleFont: titleFont,
            titleTextColor: titleTextColor
        )
    }

    private static func segmentioIndicatorOptions() -> SegmentioIndicatorOptions {
        return SegmentioIndicatorOptions(
            type: .bottom,
            ratio: 1,
            height: 5,
            color: .systemGreen
        )
    }

    private static func segmentioHorizontalSeparatorOptions() -> SegmentioHorizontalSeparatorOptions {
        return SegmentioHorizontalSeparatorOptions(
            type: .topAndBottom,
            height: 0,
            color: .white
        )
    }

    private static func segmentioVerticalSeparatorOptions() -> SegmentioVerticalSeparatorOptions {
        return SegmentioVerticalSeparatorOptions(
            ratio: 0,
            color:UIColor.black
        )
    }

}

extension UIFont {

    class func exampleAvenirMedium(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "MuseoSans-300", size: size) ?? UIFont.systemFont(ofSize: size)
    }

    class func exampleAvenirLight(ofSize size: CGFloat) -> UIFont {
        return UIFont(name: "MuseoSans-300", size: size) ?? UIFont.systemFont(ofSize: size)
    }

}
//extension UIColor {
//    convenience init(hex: String) {
//        let scanner = Scanner(string: hex)
//        scanner.scanLocation = 0
//
//        var rgbValue: UInt64 = 0
//
//        scanner.scanHexInt64(&rgbValue)
//
//        let r = (rgbValue & 0xff0000) >> 16
//        let g = (rgbValue & 0xff00) >> 8
//        let b = rgbValue & 0xff
//
//        self.init(
//            red: CGFloat(r) / 0xff,
//            green: CGFloat(g) / 0xff,
//            blue: CGFloat(b) / 0xff, alpha: 1
//        )
//    }
//}
//
