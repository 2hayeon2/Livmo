//
//  Data.swift
//  Livmo
//
//  Created by hayeon lee on 5/4/25.
//

import Foundation

struct Block {
    let uid: String
    let title: String
    let tagList: [Tag]
}

struct Tag {
    let title: String
}

struct Street {
    let uid: String
    let partType: DayPartType
    let blockList: [Block]
}

struct Day {
    let uid: String
    let title: String
    let streetList: [Street]
}

enum DayPartType: Int16 {
    case 아침
    case 오전
    case 오후
    case 저녁
    case 밤
}
