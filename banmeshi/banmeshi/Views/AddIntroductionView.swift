//
//  AddDetailView.swift
//  banmeshi
//
//  Created by 金斗石 on 2022/1/4.
//

import UIKit
import RxSwift
import RxCocoa

final class AddIntroductionView: UIView {
    @IBOutlet var contentView: AddIntroductionView!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var subView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var introductionTextView: UITextView!
    @IBOutlet weak var closeBtn: UIButton!
    var disposeBag = DisposeBag()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        Bundle.main.loadNibNamed("AddIntroductionView", owner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView() {
        titleLabel.text = "简介内容："
        // 枠のカラー
        introductionTextView.layer.borderColor = UIColor.blue.cgColor
        // 枠の幅
        introductionTextView.layer.borderWidth = 1.0
        // 枠を角丸にする
        introductionTextView.layer.cornerRadius = 8.0
        introductionTextView.layer.masksToBounds = true
//        introductionTextField.placeholder = "请输入简介"
        
        //MARK: - TextFieldの最大文字数設定
        introductionTextView.rx.text
            .map { text in
                if let text = text, text.count > 200 {
                    return String(text.prefix(200))
                } else {
                    return text ?? ""
                }
            }
            .bind(to: introductionTextView.rx.text)
            .disposed(by: disposeBag)
        
        //MARK: - TextField入力制限に越した場合ボタン非活性化
        Observable.combineLatest(introductionTextView.rx.text.orEmpty.asObservable(), introductionTextView.rx.text.orEmpty.asObservable()){
            $0.count > 0 && $1.count > 0
        }
        .bind(to: confirmBtn.rx.isEnabled)
        .disposed(by: disposeBag)
    }

    @IBAction func tapConfirmBtn(_ sender: Any) {
        hideView()
    }
    @IBAction func tapCloseBtn(_ sender: Any) {
        hideView()
    }
    
    func getIngredientData() -> String {
        return introductionTextView.text ?? ""
    }
    
    func hideView() {
        introductionTextView.endEditing(true)
        UIView.animate(withDuration: 0.3) {
            self.frame.origin.y = -Const.screenHeight
        }
    }
    
    func showView() {
        introductionTextView.becomeFirstResponder()
        self.frame.origin.y = 0
    }

    
}
