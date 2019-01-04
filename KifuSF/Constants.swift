//
//  Constants.swift
//  KifuSF
//
//  Created by Alexandru Turcanu on 28/07/2018.
//  Copyright © 2018 Alexandru Turcanu. All rights reserved.
//

import Foundation

// we are not using this helper struct anywhere...
struct KFUserInterface {
    struct TabBarTitle {
        static let indexOne: String = "Home"
        static let indexTwo: String = "Status"
        static let indexThree: String = "Social"
    }
}

struct KFErrorMessage {
    static let unknownCell = "unknown donation table view cell"
    static let imageNotFound = "could not load image"
    static let nibFileNotFound = "could not load nib file"
    static let textStyleNotFount = "could not load text style"
    static let unknownIdentifier = "unknown identifier"
    static let seriousBug = "Somebody is dumb"
    static let failedToDecode = "failed to decode"
    static let inputValidationFailed = "Input Validation Failed"
    static func inputValidationFailed(_ message: String) -> String { return "Input Validation Failed: \(message)" }
}

struct KifuLocalization {
    static let regulations = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."

    static let feedbackMail = "pondorasti@gmail.com"
    static let contactUsMail = "pondorasti@gmail.com"
}
