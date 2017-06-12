//
//  ViewController.swift
//  Silly Song
//
//  Created by Ankita Satpathy on 12/06/17.
//  Copyright © 2017 Ankita Satpathy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsView: UITextView!
    
    let bananaFanaTemplate = [
        "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
        "Banana Fana Fo F<SHORT_NAME>",
        "Me My Mo M<SHORT_NAME>",
        "<FULL_NAME>"].joined(separator: "\n")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
    }
    
    @IBAction func displayLyrics(_ sender: Any) {
        if nameField.text != "" {
          return lyricsView.text =  lyricsForName(lyricsTemplate: bananaFanaTemplate, fullName: nameField.text!)
        }
        
    }

    @IBAction func reset(_ sender: Any) {
       nameField!.text = ""
       lyricsView!.text = ""
    }
   
    func shortname(name: String) -> String {
        var shortname =  name.folding(options: .diacriticInsensitive, locale: .current)
        let lowercasename = shortname.lowercased()
        let vowelset = CharacterSet(charactersIn: "aeiou")
        
        if let FirstvowelRange = shortname.rangeOfCharacter(from: vowelset){
            return lowercasename.substring(from: FirstvowelRange.lowerBound)
        }
        return lowercasename
    }
    
    func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
        let fullnameLowercased = fullName.lowercased()
        let shortName = shortname(name: fullName)
        let lyrics = lyricsTemplate.replacingOccurrences(of: "<FULL_NAME>", with: fullnameLowercased).replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
        
        return lyrics
        
        
    }
    

}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

