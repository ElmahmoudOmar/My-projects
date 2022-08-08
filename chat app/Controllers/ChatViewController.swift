


import UIKit
import Firebase

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    var messages = [Message]()
    
    
    let dataBase = Firestore.firestore()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        navigationItem.title = K.navigationTitle
        navigationItem.hidesBackButton = true
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        loadMessages()
    }
    
    
        func loadMessages(){
            
            dataBase.collection(K.FStore.collectionName).order(by:K.FStore.dateField)
                .addSnapshotListener() { (querySnapshot, error) in
                self.messages = []
                    if let error = error {
                    
                    print("there was an issue retrieving data from firestore.\(error)")
                } else {
                    if let snapshotDocuments = querySnapshot?.documents {
                        
                        for document in snapshotDocuments {
                            
                            let data = document.data()
                            
                            if let messageSender = data[K.FStore.senderField] as? String,let messageBody = data[K.FStore.bodyField] as? String {
                                
                                let newMessage = Message(sender: messageSender, body: messageBody)
                                self.messages.append(newMessage)
                                
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                    let indexPath = IndexPath(row: self.messages.count-1, section: 0)
                                    self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                                }
                            }
                            
                        }
                    }
                    
                }
                
                
            }
        }
   
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
        if let messageBody = messageTextfield.text,let messageSender = Auth.auth().currentUser?.email{
            
            dataBase.collection(K.FStore.collectionName).addDocument(data: [K.FStore.senderField:messageSender,K.FStore.bodyField:messageBody,K.FStore.dateField:Date().timeIntervalSince1970]) { (error) in
                
                if let error = error{
                    print("there was an issue saving data to firestore,\(error)")
                } else {
                    print("data saved successfully.")
                    
                    DispatchQueue.main.async {
                        self.messageTextfield.text = ""
                    }
                   

                }
            }
        }
        
    }
    
    @IBAction func LogOutButton(_ sender: UIBarButtonItem) {
        
        
    do {
      try Auth.auth().signOut()
        
        navigationController?.popToRootViewController(animated: true)
        
    } catch let signOutError as NSError {
      print("Error signing out: %@", signOutError)
    }
      
        
    }
    
}


extension ChatViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier) as! MessageCell
        
        cell.label.text = message.body
        
        if Auth.auth().currentUser?.email == message.sender  {
            
            cell.leftAvatar.isHidden = true
            cell.rightAvatar.isHidden = false
            cell.messageBubble.backgroundColor = UIColor.init(named: K.BrandColors.lighBlue)
            cell.label.textColor = UIColor.black
            
            
            
        } else {
            
            cell.rightAvatar.isHidden = true
            cell.leftAvatar.isHidden = false
            cell.messageBubble.backgroundColor = UIColor.init(named: K.BrandColors.lightPurple)
            cell.label.textColor = UIColor.black
            
            
        }
       
       
        return cell
    }
    
    
    
}






