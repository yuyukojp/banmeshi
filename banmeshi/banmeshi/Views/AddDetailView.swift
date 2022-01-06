//
//  AddDetailView.swift
//  banmeshi
//
//  Created by 金斗石 on 2022/1/4.
//

import UIKit
import RxSwift
import RxCocoa

class AddDetailView: UIView {
    @IBOutlet var contentView: AddDetailView!
    @IBOutlet weak var detailTextField: UITextField!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var ingredientLabel: UILabel!
    @IBOutlet weak var ingredientTextfield: UITextField!
    @IBOutlet weak var confirmBtn: UIButton!
    @IBOutlet weak var closeBtn: UIButton!
    var disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        Bundle.main.loadNibNamed("AddDetailView", owner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setupView() {
        detailLabel.text = "材料名："
        detailTextField.placeholder = "里脊肉"
        ingredientLabel.text = "需要量："
        ingredientTextfield.placeholder = "100g"
                
        //MARK: - TextFieldの最大文字数設定
        detailTextField.rx.text
            .map { text in
                if let text = text, text.count > 40 {
                    return String(text.prefix(40))
                } else {
                    return text ?? ""
                }
            }
            .bind(to: detailTextField.rx.text)
            .disposed(by: disposeBag)
        
        ingredientTextfield.rx.text
            .map { text in
                if let text = text, text.count > 40 {
                    return String(text.prefix(40))
                } else {
                    return text ?? ""
                }
            }
            .bind(to: ingredientTextfield.rx.text)
            .disposed(by: disposeBag)
                
        //MARK: - TextField入力制限に越した場合ボタン非活性化
        Observable.combineLatest(detailTextField.rx.text.orEmpty.asObservable(), ingredientTextfield.rx.text.orEmpty.asObservable()){
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
    
    func getDetailData() -> String {
        print("+++++dt:\(detailTextField.text)")
        return detailTextField.text ?? ""
    }
    
    func getIngredientData() -> String {
        return ingredientTextfield.text ?? ""
    }
    
    func hideView() {
        detailTextField.endEditing(true)
        ingredientTextfield.endEditing(true)
        UIView.animate(withDuration: 0.3) {
            self.frame.origin.y = -Const.screenHeight
        }
    }
    
    func showView(detail: String?, ingredient: String?) {
        detailTextField.becomeFirstResponder()
        self.frame.origin.y = 0
        if detail != nil && ingredient != nil {
            detailTextField.text = detail
            ingredientTextfield.text = ingredient
        }
    }
}
