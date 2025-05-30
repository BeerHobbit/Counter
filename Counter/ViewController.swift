import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet private weak var countValueLabel: UILabel!
    @IBOutlet private weak var countHistoryTextView: UITextView!
    
    private var count: Int = 0 {
        didSet {
            countValueLabel.text = "Значение счетчика:\n\(count)"
        }
    }
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy HH:mm:ss"
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        countValueLabel.text = "Значение счетчика:\n\(count)"
    }
    
    private func makeCurrentDateString() -> String {
        let currentDate = Date()
        return dateFormatter.string(from: currentDate)
    }
    
    private func scrollToLastString() {
        let range = NSMakeRange(countHistoryTextView.text.count, 0)
        countHistoryTextView.scrollRangeToVisible(range)
    }
    
    @IBAction private func addOnTap(_ sender: Any) {
        count += 1
        countHistoryTextView.text += "\n[\(makeCurrentDateString())]: Значение изменено на +1"
        scrollToLastString()
    }
    
    @IBAction private func substractOnTap(_ sender: Any) {
        if count > 0 {
            count -= 1
            countHistoryTextView.text += "\n[\(makeCurrentDateString())]: Значение изменено на -1"
            scrollToLastString()
        } else {
            countHistoryTextView.text += "\n[\(makeCurrentDateString())]: Попытка уменьшить значение счётчика ниже 0"
            scrollToLastString()
        }
    }
    
    @IBAction private func resetOnTap(_ sender: Any) {
        count = 0
        countHistoryTextView.text += "\n[\(makeCurrentDateString())]: Значение сброшено"
        scrollToLastString()
    }
}

