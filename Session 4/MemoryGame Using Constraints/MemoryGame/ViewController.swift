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
                                  completion: {(Bool) -> Void in
                                    self.checkTheSame(tappedImage: tappedImage)
                })
                
            } else if tappedImage.image == tappedImage.highlightedImage {
                tappedImage.image = #imageLiteral(resourceName: "back")
                
                UIView.transition(with: tappedImage,
                                  duration: 1,
                                  options: .transitionFlipFromRight,
                                  animations: { tappedImage.image = #imageLiteral(resourceName: "back") },
                                  completion: nil)
                
                counter -= 1
            }
        }
    }
    
    func checkTheSame(tappedImage: UIImageView){
        counter += 1
        if counter == 1 {
            firstImage = tappedImage
        } else if counter == 2 {
            secondImage = tappedImage
            // if two image are the same
            if firstImage?.image == secondImage?.image {
                UIView.transition(with: (firstImage)!,
                                  duration: 2,
                                  options: .transitionCurlUp,
                                  animations: { self.firstImage?.image = nil },
                                  completion: nil)
                
                UIView.transition(with: (secondImage)!,
                                  duration: 2,
                                  options: .transitionCurlUp,
                                  animations: { self.secondImage?.image = nil },
                                  completion: nil)
                
                counter = 0
                // else if the two are different
            } else {
                
                UIView.transition(with: (firstImage)!,
                                  duration: 1,
                                  options: .transitionFlipFromRight,
                                  animations: { self.firstImage?.image = #imageLiteral(resourceName: "back") },
                                  completion: nil)
                
                UIView.transition(with: (secondImage)!,
                                  duration: 1,
                                  options: .transitionFlipFromRight,
                                  animations: { self.secondImage?.image = #imageLiteral(resourceName: "back") },
                                  completion: nil)
                
                counter = 0
            }
        }
    }
    
    func setGestureRecognizer() -> UITapGestureRecognizer {
        var tapRecognizer = UITapGestureRecognizer()
        tapRecognizer = UITapGestureRecognizer (target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        return tapRecognizer
    }
}

