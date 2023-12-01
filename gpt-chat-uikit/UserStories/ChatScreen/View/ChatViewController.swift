//
//  ViewController.swift
//  gpt-chat-uikit
//
//  Created by Nariman on 23.11.2023.
//

import UIKit
import SnapKit

class ChatViewController: UIViewController {
    //MARK: - Proporties
    
    private let viewModel: ChatViewModel = .init()
    private var textFieldText: String = ""
    
    //MARK: - UI Elements
    private lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.register(
            ChatTableViewCell.self,
            forCellReuseIdentifier: ChatTableViewCell.identifier
        )
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.separatorColor = .clear
        return tableView
    }()

    
    private lazy var sendButton: SendButton = {
        let button = SendButton()
        button.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let textField: StyledTextField = {
        let textField = StyledTextField()
        return textField
    }()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        viewModel.onDataUpdate = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    func setupUI() {
        let safeArea = view.safeAreaLayoutGuide
        view.backgroundColor = .white
        
        view.addSubview(sendButton)
        sendButton.snp.makeConstraints { make in
            make.bottom.equalTo(safeArea.snp.bottom)
            make.trailing.equalTo(safeArea.snp.trailing).inset(16)
            make.height.equalTo(40)
            make.width.equalTo(70)
        }
        
        view.addSubview(textField)
        textField.snp.makeConstraints { make in
            make.bottom.equalTo(safeArea.snp.bottom)
            make.trailing.equalTo(sendButton.snp.leading).offset(-16)
            make.leading.equalTo(safeArea.snp.leading).inset(16)
            make.height.equalTo(40)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.trailing.leading.equalTo(safeArea)
            make.bottom.equalTo(textField.snp.top).offset(-16)
        }
    }
    
    func createCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewLayout()
        return layout
    }
    
}

//MARK: - Private Methods
private extension ChatViewController {
    @objc
    func sendButtonTapped() {
        textFieldText = textField.text ?? ""
        let model = ChatMessage(
            id: UUID().uuidString,
            content: textFieldText,
            dateCreated: Date(),
            messageSender: .user
        )
        viewModel.chatMessages.append(model)
        viewModel.sendMessageToGPT(message: textFieldText)
        tableView.reloadData()
        textField.text = ""
    }
    
 }

//MARK: - TextFieldDelegate
extension ChatViewController: UITextFieldDelegate {
}

//MARK: - TableView
extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.chatMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: ChatTableViewCell.identifier,
            for: indexPath
        ) as! ChatTableViewCell
        cell.configure(with: viewModel.chatMessages[indexPath.row])
        
        return cell
    }
    

}

extension ChatViewController: UITableViewDelegate {

}

