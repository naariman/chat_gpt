//
//  ChatCollectionViewCell.swift
//  gpt-chat-uikit
//
//  Created by Nariman on 01.12.2023.
//

import UIKit
import SnapKit

final class ChatTableViewCell: UITableViewCell {
    static let identifier: String = "ChatTableViewCell"
    
    private let messageLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.layer.cornerRadius = 12
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let bubbleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var lead: NSLayoutConstraint!
    private var trail: NSLayoutConstraint!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: ChatMessage) {
        messageLabel.text = model.content
        messageLabel.textColor = model.messageSender == .user ? .white : .black

        // Обновите ограничения в зависимости от отправителя
        if model.messageSender == .user {
            bubbleView.backgroundColor = .systemBlue
            lead.isActive = false
            trail.isActive = true
        } else {
            bubbleView.backgroundColor = .lightGray
            lead.isActive = true
            trail.isActive = false
        }

    }
}

private extension ChatTableViewCell {
    func setupUI() {
        addSubview(bubbleView)
        addSubview(messageLabel)
        
        NSLayoutConstraint.activate ([
            messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 275),
            
            bubbleView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -8),
            bubbleView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -8),
            bubbleView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 8),
            bubbleView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 8)
        ])
        
        lead = messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        trail = messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
    }
}
