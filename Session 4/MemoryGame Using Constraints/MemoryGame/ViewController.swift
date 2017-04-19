//
//  ViewController.swift
//  MemoryGame
//
//  Created by KARIM on 4/14/17.
//  Copyright © 2017 KARIM. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var myImages: [UIImageView] = []
    
    var counter: Int = 0
    var firstImage: UIImageView?
    var secondImage: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        setTouchActionForImages()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setTouchActionForImages() {
        for index in 0..<16 {
            myImages[index].addGestureRecognizer(setGestureRecognizer())
        }
    }
    
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        if let tappedImage = tapGestureRecognizer.view as? UIImageView {
            if tappedImage.image == #imageLiteral(resourceName: "back") && counter < 2{
                tappedImage.image = tappedImage.highlightedImage
                
                UIView.transition(with: tappedImage,
                                  duration: 1,
                                  options: .transitionFlipFromLeft,
                                  animations: { tappedImage.image = tappedImage.highlightedImage },
                                  completion: nil)
                
                counter += 1
                if counter == 1 {
                    firstImage = tappedImage
                } else if counter == 2 {
                    secondImage = tappedImage
                    // if two image are the same
                    if firstImage?.image == secondImage?.image {
                        firstImage?.image = nil
                        secondImage?.image = nil
                        counter = 0
                        // else if the two are different
                    } else {
                        //firstImage?.image = #imageLiteral(resourceName: "back")
                        //secondImage?.image = #imageLiteral(resourceName: "back")
                        //counter = 0
                    }
                }
            } else if tappedImage.image == tappedImage.highlightedImage {
                tappedImage.image = #imageLiteral(resourceName: "back")
                
                UIView.transition(with: tappedImage,
                                  duration: 1,
                                  options: .transitionFlipFromRight,
                                  animations: { tappedImage.image = #imageLiteral(resourceName: "back") },
                                  completion: nil)
                
                counter -= 1
                if counter == 0 {
                    firstImage = nil
                    secondImage = nil
                }else if counter == 1 {
                    firstImage = secondImage
                    secondImage = nil
                }
            }
        }
    }
    
    func setGestureRecognizer() -> UITapGestureRecognizer {
        var tapRecognizer = UITapGestureRecognizer()
        tapRecognizer = UITapGestureRecognizer (target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        //tapRecognizer.numberOfTapsRequired = 3
        return tapRecognizer
    }
}

