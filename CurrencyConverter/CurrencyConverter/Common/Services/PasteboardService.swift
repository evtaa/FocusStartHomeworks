//
//  PasteboardService.swift
//  CurrencyConverter
//
//  Created by Alexandr Evtodiy on 24.12.2021.
//

import UIKit

protocol IPasteboardService
{
    func copyToBuffer(string: String)
}

final class PasteboardService {
    
}

// MARK: - IPasteboardService
extension PasteboardService: IPasteboardService {
    func copyToBuffer(string: String) {
        UIPasteboard.general.string = string
    }
}
