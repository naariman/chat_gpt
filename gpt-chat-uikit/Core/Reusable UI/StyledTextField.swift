//
//  StyledTextField.swift
//  gpt-chat-uikit
//
//  Created by Nariman on 01.12.2023.
//

import UIKit

class StyledTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        borderStyle = .roundedRect
        layer.cornerRadius = 12
        layer.borderColor = .init(gray: 1, alpha: 1)
        backgroundColor = .systemGray6
        placeholder = "Message ChatGPT"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
