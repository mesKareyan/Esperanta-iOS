import UIKit
import JSQMessagesViewController

class ChatViewController: JSQMessagesViewController {
    
    var messages = [JSQMessage]()
    private var navTextAttributes: [NSAttributedStringKey : Any]?
    //JSQMessages UI
    private lazy var outgoingBubbleImageView: JSQMessagesBubbleImage = {
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        let button = bubbleImageFactory!.outgoingMessagesBubbleImage(with: UIColor.esperantaLightGreen)
        return button!
    }()
    
    private lazy var incomingBubbleImageView: JSQMessagesBubbleImage = {
        let bubbleImageFactory = JSQMessagesBubbleImageFactory()
        let bubble =  bubbleImageFactory!.incomingMessagesBubbleImage(with: UIColor.white)
        return bubble!
    }()
    
    private func configureUI(){
        view.backgroundColor = UIColor.clear
        collectionView.backgroundColor = .clear
        collectionView.backgroundColor = UIColor.esperantaBrown
        collectionView.typingIndicatorMessageBubbleColor = UIColor.white
        collectionView!.collectionViewLayout.incomingAvatarViewSize = .zero
        collectionView!.collectionViewLayout.outgoingAvatarViewSize = .zero
        showTypingIndicator = true
        self.inputToolbar.tintColor = UIColor.esperantaGreen
        let button = UIButton(type: .custom)
        button.setImage(#imageLiteral(resourceName: "coloredSent").withRenderingMode(.alwaysTemplate), for: .normal)
        inputToolbar.contentView.rightBarButtonItem = button
        inputToolbar.contentView.leftBarButtonItem = nil
        inputToolbar.contentView.textView.layer.cornerRadius = inputToolbar.contentView.textView.bounds.height / 2
        //nav bar
        self.title = "Mesrop"
        let search = UISearchController(searchResultsController: nil)
        if #available(iOS 11.0, *) {
            self.navigationItem.searchController = search
        } else {
            // Fallback on earlier versions
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        self.senderId = "someID"
        self.senderDisplayName = "some"
        messages.append(JSQMessage(senderId: "someID", senderDisplayName: "ME", date: Date(), text: "Hello worlds"))
        messages.append(JSQMessage(senderId: "worldID", senderDisplayName: "World", date: Date(), text: "Hi men"))
        messages.append(JSQMessage(senderId: "otherID", senderDisplayName: "Mesrop", date: Date(), text: "Bla bla"))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navTextAttributes = self.espNavTextAttributes
        self.espNavTextAttributes =  [
            NSAttributedStringKey.foregroundColor: UIColor.red,
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: 24, weight: .light)
        ]
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.espNavTextAttributes = self.navTextAttributes
    }
    
    // MARK: UITextViewDelegate methods
    override func textViewDidChange(_ textView: UITextView) {
        super.textViewDidChange(textView)
    }
    
}

//MARK: Collection View Delegate
extension ChatViewController {
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
        let message = messages[indexPath.item]
        cell.textView.textColor = UIColor.black.withAlphaComponent(0.8)
        cell.addShadowToImageViews()
        cell.clipsToBounds = false
        return cell
    }
}

extension UIView {
    func addShadowToImageViews(){
        for view in subviews {
            if let imageView = view as? UIImageView {
                imageView.layer.shadowColor = UIColor.lightGray.cgColor
                imageView.layer.shadowOffset = CGSize(width: 0, height: 1)
                imageView.layer.shadowOpacity = 1
                imageView.layer.shadowRadius = 1.0
                imageView.clipsToBounds = false
                continue
            }
            view.addShadowToImageViews()
        }
    }
}

//MARK: JSQMessages
extension ChatViewController {
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let message = messages[indexPath.item]
        if message.senderId == senderId { // 2
            return outgoingBubbleImageView
        } else { // 3
            return incomingBubbleImageView
        }
    }
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    //MARK: Actions
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        messages.append(JSQMessage(senderId: senderId, senderDisplayName: senderDisplayName, date: date, text: text))
        finishSendingMessage()
    }

}


extension UIViewController {
    
    var espNavTextAttributes: [NSAttributedStringKey : Any]? {
        set {
            if #available(iOS 11.0, *) {
                    self.navigationController?
                        .navigationBar
                        .largeTitleTextAttributes = espNavTextAttributes
            } else {
                self.navigationController?.navigationBar.titleTextAttributes = espNavTextAttributes
            }
        }
        get {
            if #available(iOS 11.0, *) {
                return self.navigationController?.navigationBar.largeTitleTextAttributes
            } else {
               return self.navigationController?.navigationBar.titleTextAttributes
            }
        }
    }
    
}
