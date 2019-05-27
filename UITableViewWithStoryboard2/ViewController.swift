
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

extension ViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        
        for _ in indexPaths {
            //print("first \(indexPath) method \(indexPaths)")
        }
        
    }
    
    func tableView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        for _ in indexPaths {
            //print("second method \(indexPaths)")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: idCell, for: indexPath)
        cell.textLabel?.text = textArray[indexPath.row]
        // print(indexPath.row)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            textArray.remove(at: indexPath.row)
            myTableView.deleteRows(at: [indexPath], with: .top)
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        let item = textArray[sourceIndexPath.row]
        textArray.remove(at: sourceIndexPath.row)
        textArray.insert(item, at: destinationIndexPath.row)
        
    }
    
    func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        //добавляет действия
        if action == #selector(copy(_:)) {
            print("copy true")
            return true
            
        } else if action == #selector(paste(_:)) {
            print("paste true")
            return true
        }
        
        return false //если ставить тру - то добавит все возможные действия
    }
    
    func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) {
        
        if action == #selector(copy(_:)) {
            let cell = tableView.cellForRow(at: indexPath)
            let pasteBoard = UIPasteboard.general //синглтон обращение к буферу обмена
            pasteBoard.string = cell?.textLabel?.text
            
        } else if action == #selector(paste(_:)) {
            
//            let cell = tableView.cellForRow(at: indexPath)
            let pasteBoard = UIPasteboard.general //синглтон обращение к буферу обмена
            print("copy cell = \(pasteBoard.string!)")
            
            textArray[indexPath.row] = pasteBoard.string!
            
            tableView.reloadData()
        }
        
    }
    
    
}

