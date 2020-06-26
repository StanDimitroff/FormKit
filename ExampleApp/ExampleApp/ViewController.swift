import UIKit
import FormKit

class ViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!

  let viewClass = UserTableViewCell.self
  var user = User(name: "Steve", age: 34)
  var student = Student(classNumber: 2424, subject: "Programming")

  var form: Form<User>!

  override func viewDidLoad() {
    super.viewDidLoad()

    let header = Header(nibName: "SectionHeaderView")
      .config { view in
        guard let header = view as? SectionHeaderView else { return }
        header.insertSections = {
          self.form?.insertSections([
            Section {
              Row(self.viewClass).bind(self.user, keyPath: \.name).height(40)
            }
          ], at: 1)
        }

        header.addRows = {
          let viewClass = UITableViewCell.self
          self.form?.addRows([Row(viewClass), Row(viewClass)], sectionIndex: 0)
        }

        header.removeSection = {
          self.form?.removeSections(indexes: .exact(0))
        }
    }

    let footer = Footer(nibName: "SectionFooterView")

    let addressClass = AddressTableViewCell.self

    let section1 = Section {
      Row(viewClass).bind(user, keyPath: \.name).height(40)
        Row(viewClass).bind(student, keyPath: \.subject)
        Row(viewClass).bind(student, keyPath: \.classNumber)
          .onSelect {
            print("SELECT Action")
        }
          .onDelete {
            print("DELETE Action")
          }

       Row("TextFieldTVCell").bind(user, keyPath: \.name)
      }
      .header(header)
      .headerHeight(50)
      .headerTitle("HEADER 1")
      .rowAnimation(.left)
      .editingStyle(.delete)
      .deletionTitle("Remove")

    let section2 = Section {
      Row(viewClass).bind(user, keyPath: \.name).height(40)
        Row(viewClass).bind(student, keyPath: \.subject)
        Row(viewClass).bind(student, keyPath: \.classNumber)
          .onSelect {
            print("SELECT Action")
        }
          .onDelete {
            print("DELETE Action")
          }
      }
      .header(header)
      .headerHeight(50)
      .headerTitle("HEADER 2")

      .footer(footer)
      .footerHeight(50)
      .rowAnimation(.left)
      .editingStyle(.delete)
      .deletionTitle("Remove")


    self.form = Form<User>(tableView: self.tableView, object: user) {
      section1
      //section2

    }.headerHeight(40)
  }
  

  @IBAction func addSection(_ sender: Any) {
    //let viewClass = UITableViewCell.self
    let sections: [Section] = [
      Section {
        Row(viewClass)
      },
      Section {
        Row(viewClass)
      }
    ]

    form?.addSections(sections, scrollBottom: true)
  }

  @IBAction func removeSection(_ sender: Any) {
    form?.removeSections(indexes: [.exact(1)])
  }

  @IBAction func scrollBottom(_ sender: Any) {
    form?.scrollToBottom(animated: true)
  }

  @IBAction func scrollTop(_ sender: Any) {
    form?.scrollToTop(animated: true)
  }
}
