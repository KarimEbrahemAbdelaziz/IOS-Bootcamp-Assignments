//
//  InfoViewController.swift
//  SecondSession
//
//  Created by KARIM on 4/12/17.
//  Copyright © 2017 KARIM. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var webViewContent: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let url = Bundle.main.url(forResource: "BullsEye", withExtension: "html") {
            if let htmlData = try? Data(contentsOf: url) {
                let baseURL = URL(fileURLWithPath: Bundle.main.bundlePath)
                webViewContent.load(htmlData, mimeType: "text/html",textEncodingName: "UTF-8", baseURL: baseURL)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func BackPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
