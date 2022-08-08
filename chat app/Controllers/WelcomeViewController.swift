

import UIKit


class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
     
        titleLabel.text = ""
        let titleText = "⚡️FlashChat"
        var letterIndex = 0
        for letter in titleText {

         Timer.scheduledTimer(withTimeInterval: 0.1 * Double(letterIndex), repeats: false) { (timer) in

            self.titleLabel.text?.append(letter)
            }
            letterIndex += 1
        }
        
        
        
        
    }
    

}
