//
//  String + Extension.swift
//  gpt-chat-uikit
//
//  Created by Nariman on 01.12.2023.
//

import UIKit

extension String {
    func calculateHeight(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
         let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
         let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
         return ceil(boundingBox.height)
     }
}
