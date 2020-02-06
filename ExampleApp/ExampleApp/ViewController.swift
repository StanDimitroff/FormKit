import UIKit
import FormKit

class ViewController: FormViewController {

  @IBOutlet weak var tableView: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()

    let viewClass = UITableViewCell.self

    let form = Form(headerHeight: 40, rowHeight: 50) {
      Section(height: 20) {
        Row(viewClass: viewClass, height: 20)
        Row(viewClass: viewClass)
      }

      Section(rowHeight: 70) {
        Row(viewClass: viewClass)
        Row(viewClass: viewClass, height: 35)
          .onSelect {
          print("SELECT")
        }.editingStyle(.delete)
       }
    }

    formDataSource = FormDataSource(tableView: tableView, form: form)
  }


}

struct Model {
  var name: String = ""
  var age: Int = 0
}

