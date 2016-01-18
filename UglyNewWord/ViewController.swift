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

        ignoreTextView.string = "the,to,you,that,this,in,have,of,i,we,can,so,your,use,are,and,code,do,want,on,for,it,so,going,compiler,segue,about,if,just,our,how,new,really,know,all,be,what,my,view,at,ios,os,with,an,application,it's,but,check,app,identifier,now,right,am,swift,api,as,defined,these,availability,back,go,not,take,when,also,by,from,let's,protocol,type,will,call,controller,different,get,method,other,out,then,here,implementation,way,cases,enum,like,look,some,string,time,using,asset,because,class,define,enumeration,into,more,only,problem,runtime,same,see,that's,we've,actually,add,available,doesn't,earlier,even,problems,say,thing,ui,well,before,don't,done,image,solution,syntax,talk,them,case,information,mapping,need,own,provided,there,there's,think,was,where,would,behavior,checking,completely,functions,images,make,one,safe,switch,they,two,which,approach,apps,browser,compile,enums,factor,first,great,had,help,methods,or,pretty,protocols,provide,release,releases,sdk,something,specific,storyboard,strings,tell,us,users,very,advantagebetween,block,could,deploying,enumerations,error,everywhere,many,me,naturally,prepare,return,still,those,uikit"
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
    
}

