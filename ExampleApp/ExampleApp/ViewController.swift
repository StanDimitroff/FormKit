import UIKit
import FormKit

class ViewController: FormViewController {

  @IBOutlet weak var tableView: UITableView!

  let viewClass = UserTableViewCell.self
  var user = User(name: "Steve", age: 34)
  var student = Student(classNumber: 2424, subject: "Programming")


  override func viewDidLoad() {
    super.viewDidLoad()


    let headerView = UILabel()
    headerView.text = "Header custom view"
    headerView.backgroundColor = .lightGray


    form = Form(tableView: self.tableView, headerHeight: 40) {
      Section {

        Row(viewClass, height: 40).bind(user, keyPath: \.name)
        Row(viewClass).bind(student, keyPath: \.subject)
        Row(viewClass).bind(student, keyPath: \.classNumber)
          .onSelect {
            print("SELECT Action")
        }
          .onDelete {
            print("DELETE Action")
          }
      }
      .headerHeight(30)
      .headerTitle("Test")
      .rowAnimation(.left)
      .editingStyle(.delete)
      .deleteTitle("Remove")
    }
  }

  @IBAction func addSection(_ sender: Any) {
    let viewClass = UITableViewCell.self
    let sections: [Section] = [
      Section(headerTitle: "Section1") {
        Row(viewClass)
      },
      Section(headerTitle: "Section2") {
        Row(viewClass)
      }
    ]

    form?.addSections(sections, scrollBottom: true)
  }

  @IBAction func removeSection(_ sender: Any) {
    form?.removeSection(at: 0)
  }

  @IBAction func scrollBottom(_ sender: Any) {
    form?.scrollToBottom(animated: true)
  }

  @IBAction func scrollTop(_ sender: Any) {
    form?.scrollToTop(animated: true)
  }
}
