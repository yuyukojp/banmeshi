//
//  AddPointView.swift
//  banmeshi
//
//  Created by 金斗石 on 2022/1/19.
//

import UIKit
import RxSwift
import RxCocoa

class AddPointView: UIView {
    @IBOutlet var contentView: AddPointView!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var pointTextField: UITextField!
    @IBOutlet weak var regestButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    var disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        Bundle.main.loadNibNamed("AddPointView", owner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        pointTextField.keyboardType = UIKeyboardType.numberPad
        //MARK: - TextFieldの最大文字数設定
        pointTextField.rx.text
            .map { text in
                if let text = text, text.count > 2 {
                    return String(text.prefix(2))
                } else {
                    return text ?? ""
                }
            }
            .bind(to: pointTextField.rx.text)
            .disposed(by: disposeBag)
                
        //MARK: - TextField入力制限に越した場合ボタン非活性化
        Observable.combineLatest(pointTextField.rx.text.orEmpty.asObservable(), pointTextField.rx.text.orEmpty.asObservable()){
            $0.count > 0 && $1.count > 0
        }
        .bind(to: regestButton.rx.isEnabled)
        .disposed(by: disposeBag)
    }
    @IBAction func tapRegestBtn(_ sender: Any) {
    }
    @IBAction func tapCloseBtn(_ sender: Any) {
        hideView()
    }
    
    func getPointData() -> String {
        return pointTextField.text ?? ""
    }
    
    func hideView() {
        pointTextField.endEditing(true)
        UIView.animate(withDuration: 0.3) {
            self.frame.origin.y = -Const.screenHeight
        }
    }
    
    func showView(point: Int) {
        pointTextField.becomeFirstResponder()
        self.frame.origin.y = 0
        var pointString = "\(point)"
        if point == -1 {
            pointString = ""
        }
        pointTextField.text = pointString
    }
    
}

