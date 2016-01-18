//: Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"

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
        let charset = NSCharacterSet(charactersInString: " .,:;?!")
        let rawWordArray = self.lowercaseString.componentsSeparatedByCharactersInSet(charset)
        for raw in rawWordArray {
            print("raw --> \(raw)")
            if (raw as NSString).length == 0 || ignore.contains(raw) {
                continue
            }
            if let existWordCount = dic[raw] {
                print("count --> \(existWordCount)")
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
}

let sentence = "I'm a developer, I love code. And I hate English. But bla bla bla"
let ignore: Set = ["i", "a", "and"]
let words = sentence.wordCountDictionaryIgnoreBy(ignore)
