
import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var edit: UIBarButtonItem!
    var idCell = "Cell"
    
    var textArray: [String] = {
        var arr: [String] = []
        
        for _ in 0...1000 {
            var text: String = ""
            let count = Int.random(in: 3...8)
            
            for _ in 0...count {
                text += "\(Int.random(in: 0...9))"
            }
            arr.append(text)
        }
        
        return arr
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func editButton(_ sender: Any) {
        myTableView.isEditing = !myTableView.isEditing
    }
    
    
}

//TODO: сделать контролируемое кол-во загрузки строк

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: idCell, for: indexPath)
        cell.textLabel?.text = textArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        
        
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            textArray.remove(at: indexPath.row)
            myTableView.deleteRows(at: [indexPath], with: .top)
            myTableView.del
        }
        
    }
    
}

