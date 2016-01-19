//
//  ViewController.swift
//  UglyNewWord
//
//  Created by huangluyang on 16/1/18.
//  Copyright © 2016年 huangluyang. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    // MARK: - IBOutlets
    @IBOutlet var inputTextView: NSTextView!
    @IBOutlet var ignoreTextView: NSTextView!
    @IBOutlet var outputTextView: NSTextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        
        ignoreTextView.string = fetchIgnoreList()
    }

    override var representedObject: AnyObject? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    // MARK: - IBActions
    @IBAction func onPerformButtonClick(sender: NSButton) {
        if inputTextView.string == nil {
            return
        }
        
        var ignoreSet: Set = ["a", "is", "and", "ah"]
        if let inputIgnore = ignoreTextView.string {
            ignoreSet = ignoreSet.union(inputIgnore.toIgnoreSet())
        }
        let text = inputTextView.string!
        let result = text.wordCountDictionaryIgnoreBy(ignoreSet)
        let resultText = NSMutableString(string: "")
        for word in result {
            resultText.appendString("\(word.word) : \(word.count)\n")
        }
        outputTextView.string = resultText as String
    }
    
    @IBAction func onImportIgnoreButtonClick(sender: NSButton) {
        guard let text = outputTextView.string else { return }
        
        let sb = NSMutableString(string: "")
        do {
            let regex = try NSRegularExpression(pattern: "[a-z']+", options: [.CaseInsensitive])
            let nsText = text as NSString
            let matches = regex.matchesInString(text, options: .ReportCompletion, range: NSMakeRange(0, nsText.length))
            for matchResult in matches {
                let word = nsText.substringWithRange(matchResult.range)
                sb.appendString("\(word),")
            }
            sb.deleteCharactersInRange(NSMakeRange(sb.length - 1, 1))
            
            if let tobeSavedText = ignoreTextView.string {
                sb.insertString("\(tobeSavedText),", atIndex: 0)
            }
            
            ignoreTextView.string = sb as String
            saveIgnoreList()
            
        } catch {
            print("error -> \(error)")
        }
    }
    
    // MARK: - Private Methods
    func fetchIgnoreList() -> String {
        guard let filesPath = filesPath() else {
            return ""
        }
        
        var filePath = filesPath.stringByAppendingString("/ignore-list.txt")
        if !NSFileManager.defaultManager().fileExistsAtPath(filePath) {
            filePath = NSBundle.mainBundle().pathForResource("ignore-list", ofType: "txt")!
        }
        guard let data = NSData(contentsOfFile: filePath) else {
            return ""
        }
        return (NSString(data: data, encoding: NSUTF8StringEncoding) ?? "") as String
    }
    
    func saveIgnoreList() {
        guard let text = ignoreTextView.string else {
            return
        }
        
        guard let filesDir = filesPath() else {
            return
        }
        
        guard let data = text.dataUsingEncoding(NSUTF8StringEncoding) else {
            return
        }
        
        let filePath = filesDir.stringByAppendingString("/ignore-list.txt")
        data.writeToFile(filePath, atomically: true)
    }
    
    func filesPath() -> String? {
        guard let docPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).last else {
            return nil
        }
        let filesPath = docPath.stringByAppendingString("/files")
        if !NSFileManager.defaultManager().fileExistsAtPath(filesPath) {
            do {
                try NSFileManager.defaultManager().createDirectoryAtPath(filesPath, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("\(error)")
            }
        }
        
        return filesPath
    }
}

