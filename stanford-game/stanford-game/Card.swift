//
//  Card.swift
//  stanford-game
//
//  Created by xulihua on 2017/11/20.
//  Copyright © 2017年 huage. All rights reserved.
//

import Foundation

//1、struct 没有继承
//2、值传递，class是指针传递

struct Card {
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    static var identifierFactory = 0
    
    static func getUniqueIdentifier () ->   Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier();
    }
}
