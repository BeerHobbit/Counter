//
//  ViewController.swift
//  Counter
//
//  Created by Артём Коваленко on 30.05.2025.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var countValueLabel: UILabel!
    @IBOutlet weak var countHistoryTextView: UITextView!
    
    private var count: Int = 0 {
        // Обновление счетчика при изменении переменной
        didSet {
            countValueLabel.text = "Значение счетчика:\n\(count)"
        }
    }
    
    // Действие на кнопку +
    @IBAction func addOnTap(_ sender: Any) {
        count += 1
        countHistoryTextView.text += "\n[\(makeCurrentDateString())]: Значение изменено на +1"
        scrollToLastString()
    }
    
    // Действие на кнопку -
    @IBAction func substractOnTap(_ sender: Any) {
        if count > 0 {
            count -= 1
            countHistoryTextView.text += "\n[\(makeCurrentDateString())]: Значение изменено на -1"
            scrollToLastString()
        } else {
            countHistoryTextView.text += "\n[\(makeCurrentDateString())]: Попытка уменьшить значение счётчика ниже 0"
            scrollToLastString()
        }
    }
    
    // Действие на кнопку сброса
    @IBAction func resetOnTap(_ sender: Any) {
        count = 0
        countHistoryTextView.text += "\n[\(makeCurrentDateString())]: Значение сброшено"
        scrollToLastString()
    }
    
    // Функция, возвращающая строку форматированной даты
    private func makeCurrentDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yy HH:mm:ss"
        let currentDate = Date()
        return formatter.string(from: currentDate)
    }
    
    //Функция, скроллящая до последнего символа строки
    private func scrollToLastString() {
        let range = NSMakeRange(countHistoryTextView.text.count, 0)
        countHistoryTextView.scrollRangeToVisible(range)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        countValueLabel.text = "Значение счетчика:\n\(count)"
    }

}

