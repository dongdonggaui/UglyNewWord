//
//  WordCount.swift
//  UglyNewWord
//
//  Created by huangluyang on 16/1/18.
//  Copyright © 2016年 huangluyang. All rights reserved.
//

import Foundation

struct Word {
    var count = 0
    var word = ""
}

extension String {

    func wordCountDictionaryIgnoreBy(ignore: Set<String>) -> [Word] {
        
        let nsSelf = self as NSString
        if nsSelf.length == 0 {
            return [Word(count: 0, word: "")]
        }
        
        let dic = NSMutableDictionary()
        let charset = NSCharacterSet(charactersInString: " .,:;?![]{}()\n")
        let rawWordArray = self.lowercaseString.componentsSeparatedByCharactersInSet(charset)
        for raw in rawWordArray {
            if (raw as NSString).length < 4 || ignore.contains(raw) {
                continue
            }
            if let existWordCount = dic[raw] {
                dic[raw] = (existWordCount as! Int) + 1
            } else {
                dic[raw] = 1
            }
        }
        var wordArray: [Word] = []
        for (rawWord, count) in dic {
            let word = Word(count: count as! Int, word: rawWord as! String)
            wordArray.append(word)
        }
        wordArray = wordArray.sort({ (word1, word2) -> Bool in
            if word1.count == word2.count {
                return word1.word.compare(word2.word) == NSComparisonResult.OrderedAscending
            }
            return word1.count > word2.count
        })
        
        return wordArray
    }
    
    func toIgnoreSet() -> Set<String> {
        if (self as NSString).length == 0 {
            return []
        }
        
        let charset = NSCharacterSet(charactersInString: " .,:;?![]{}()\n")
        let rawWordArray = self.lowercaseString.componentsSeparatedByCharactersInSet(charset)
        var ignoreSet: Set<String> = []
        for raw in rawWordArray {
            if (raw as NSString).length == 0 {
                continue
            }
            ignoreSet.insert(raw)
        }
        
        return ignoreSet
    }
}
