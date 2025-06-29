import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet private weak var countValueLabel: UILabel!
    @IBOutlet private weak var countHistoryTextView: UITextView!
    
    private var count: Int = 0 {
        didSet {
            countValueLabel.text = "Значение счетчика:\n\(count)"
            UserDefaults.standard.set(count, forKey: "Saved counter value")
        }
    }
    
    private var currentHistory: String = "История изменений" {
        didSet {
            UserDefaults.standard.set(currentHistory, forKey: "Saved counter history")
        }
    }
    
    private lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy HH:mm:ss"
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        count = UserDefaults.standard.integer(forKey: "Saved counter value")
        countValueLabel.text = "Значение счетчика:\n\(count)"
        
        currentHistory = UserDefaults.standard.string(forKey: "Saved counter history") ?? "История изменений"
        countHistoryTextView.text = currentHistory
    }
    
    private func makeCurrentDateString() -> String {
        let currentDate = Date()
        return dateFormatter.string(from: currentDate)
    }
    
    private func scrollToLastString() {
        let range = NSMakeRange(countHistoryTextView.text.count, 0)
        countHistoryTextView.scrollRangeToVisible(range)
    }
    
    private func updateHistory(_ message: String) {
        currentHistory += "\n[\(makeCurrentDateString())]: \(message)"
        countHistoryTextView.text = currentHistory
        scrollToLastString()
    }
    
    @IBAction private func addOnTap(_ sender: Any) {
        count += 1
        updateHistory("Значение изменено на +1")
    }
    
    @IBAction private func substractOnTap(_ sender: Any) {
        if count > 0 {
            count -= 1
            updateHistory("Значение изменено на -1")
        } else {
            updateHistory("Попытка уменьшить значение счётчика ниже 0")
        }
    }
    
    @IBAction private func resetOnTap(_ sender: Any) {
        count = 0
        updateHistory("Значение сброшено")
    }
    
    @IBAction func clearHistoryOnTap(_ sender: Any) {
        currentHistory = "История изменений"
        countHistoryTextView.text = currentHistory
    }
    
}

