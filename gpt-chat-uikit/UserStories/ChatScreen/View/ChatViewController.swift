//
//  ViewController.swift
//  gpt-chat-uikit
//
//  Created by Nariman on 23.11.2023.
//

import UIKit
import SnapKit
import MessageKit

class ChatViewController: MessagesViewController {
    //MARK: - Proporties
    
    let userSender = SenderModel(senderId: "user", displayName: "Nariman")
    private let viewModel: ChatViewModel = .init()
    private var textFieldText: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
    }

    func setupCollectionView() {
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messageInputBar.sendButton.addTarget(
            self,
            action: #selector(sendButtonTapped),
            for: .touchUpInside
        )
        messageInputBar.sendButton.tintColor = .systemBlue
        messageInputBar.sendButton.layer.cornerRadius = 12
        messageInputBar.sendButton.layer.borderWidth = 0.2
        
        messageInputBar.inputTextView.placeholder = "Message ChatGPT..."
    
        
        viewModel.onDataUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.messagesCollectionView.reloadData()
            }
        }
        
    }
}

//MARK: - Private Methods
private extension ChatViewController {
    @objc
    func sendButtonTapped() {
        let model = Message(
            role: "user",
            content: messageInputBar.inputTextView.text
        )
        viewModel.chatMessages.append(model)
        viewModel.sendMessageToGPT(message: viewModel.chatMessages)
        
        let modelForUI = MessageModel(
            sender: userSender,
            messageId: UUID().uuidString,
            sentDate: Date(),
            kind: .text(messageInputBar.inputTextView.text)
        )
        
        viewModel.UIchatMessages.append(modelForUI)
        messagesCollectionView.reloadData()
        messageInputBar.inputTextView.text = ""
    }
    
 }

extension ChatViewController: MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate {
    func currentSender() -> MessageKit.SenderType {
        userSender
    }
    
    func messageForItem(
        at indexPath: IndexPath,
        in messagesCollectionView: MessageKit.MessagesCollectionView
    ) -> MessageKit.MessageType {
        viewModel.UIchatMessages[indexPath.section]
    }
    
    func numberOfSections(
        in messagesCollectionView: MessageKit.MessagesCollectionView
    ) -> Int {
        viewModel.UIchatMessages.count
    }
    
    func configureAvatarView(
        _ avatarView: AvatarView,
        for message: MessageType,
        at indexPath: IndexPath,
        in messagesCollectionView: MessagesCollectionView
    ) {
        if message.sender.senderId == "chatGPT" {
            avatarView.image = UIImage(named: "chatGPT")
            avatarView.adjustsFontSizeToFitWidth = true
            avatarView.backgroundColor = .white
        } else {
            avatarView.image = UIImage(systemName: "person.fill")
            avatarView.backgroundColor = .white
        }
    }
}
