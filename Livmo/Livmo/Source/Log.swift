//
//  Log.swift
//  Livmo
//
//  Created by hayeon lee on 5/4/25.
//

import os

class Log {
    
    private static let logger = Logger(subsystem: "com.yourApp", category: "general")
    
    static func debug(_ message: String) {
        logger.debug("\(message)")
    }

    static func info(_ message: String) {
        logger.info("\(message)")
    }

    static func error(_ message: String) {
        logger.error("\(message)")
    }

    static func fault(_ message: String) {
        logger.fault("\(message)")
    }
}
