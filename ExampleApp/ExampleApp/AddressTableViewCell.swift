import UIKit
import FormKit

class AddressTableViewCell: UITableViewCell, FormCellProtocol {
  func configure(row: Row) {
    addressLabel.text = row.value
  }

  var valueChange: ((String) -> Void)?

  @IBOutlet weak var addressLabel: UILabel!
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }

  private func setup() {
    let bundle = Bundle(for: type(of: self))
    let nib    = UINib(nibName: "AddressTableViewCell", bundle: bundle)
    let view   = nib.instantiate(withOwner: self, options: nil).first as! UIView

    view.frame = bounds

    addSubview(view)
  }
}
