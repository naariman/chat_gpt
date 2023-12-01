//
//  SendButton.swift
//  gpt-chat-uikit
//
//  Created by Nariman on 01.12.2023.
//

import UIKit

final class SendButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        layer.cornerRadius = 14
        setTitle("Send", for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
