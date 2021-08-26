//
//  CategorySelectionViewController.swift
//  HerCircle Dashboard
//
//  Created by vishal modem on 6/24/21.
//
import TTGTagCollectionView
import UIKit


class CategorySelectionVC: UIViewController, TTGTextTagCollectionViewDelegate {

    @IBOutlet weak var categoryView: UIView!
    
    let collectionView = TTGTextTagCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        categoryView.addSubview(collectionView)
        collectionView.fillSuperview()
        
        let strings = ["AutoLayout", "dynamically", "calculates", "the", "size", "and", "position",
                       "of", "all", "the", "views", "in", "your", "view", "hierarchy", "based",
                       "on", "constraints", "placed", "on", "those", "views"]
        
        for text in strings {
            let content = TTGTextTagStringContent.init(text: text)
            content.textColor = UIColor(red: 3.0/255, green: 1.0/255, blue: 76.0/255, alpha: 1.0)
            let font = UIFont(name: "MuseoSans-300", size: 14)
            content.textFont = font!
            
            
            let normalStyle = TTGTextTagStyle.init()
            normalStyle.backgroundColor = UIColor.white
            normalStyle.extraSpace = CGSize.init(width: 24, height: 16)
            normalStyle.borderWidth = 1
            normalStyle.borderColor = .black
            normalStyle.shadowOpacity = 0
            
            let selectedStyle = TTGTextTagStyle.init()
            selectedStyle.backgroundColor = UIColor.random()
            selectedStyle.extraSpace = CGSize.init(width: 24, height: 16)
            selectedStyle.cornerRadius = 0
            selectedStyle.borderColor = selectedStyle.backgroundColor
            
            let tag = TTGTextTag.init()
            tag.content = content
            tag.style = normalStyle
            tag.selectedStyle = selectedStyle
            
            collectionView.addTag(tag)
            collectionView.verticalSpacing = 16
        }
        
        collectionView.reload()
        
    }
    
    func textTagCollectionView(_ textTagCollectionView: TTGTextTagCollectionView!, didTap tag: TTGTextTag!, at index: UInt) {
        
    }
}
