//
//  JKBlurPopup.swift
//  banmeshi
//
//  Created by 金斗石 on 2022/2/16.
//

import UIKit

class JKBlurPopup: UIView {
    
    var attached = false
    let contentView = UIView()
    
    
    var _w = CGFloat(300)
    var _h = CGFloat(400)
    
    var target: UIView?
    var corner = CGFloat(5)
    
    let dummyStart = CGFloat(32)
    
    var blurEffectView = UIVisualEffectView()
    var blurEffect = UIBlurEffect.Style.light
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func showInView(target: UIView) {
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        self.frame = target.frame
        let btnHide = UIButton(type: .custom)
        btnHide.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        btnHide.addTarget(self, action: #selector(hideKeyboardDismiss), for: .touchUpInside)
        self.addSubview(btnHide)
        
        self.target = target
        self.contentView.frame =  CGRect(x: 0, y: 0, width: target.frame.width, height: target.frame.height)
        for subview in self.contentView.subviews {
            subview.alpha = 0
        }
        

        print(self.corner)
        self.alpha = 0
        self.contentView.alpha = 0
        self.contentView.clipsToBounds = true
        // 设置阴影
        self.layer.shadowOffset = CGSize(width: 3, height: 3);
        self.layer.shadowRadius = 5.0;
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.3
        
        
        self.contentView.backgroundColor = UIColor.white
         
        self.addSubview(contentView)
        
        blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: self.blurEffect))
        blurEffectView.frame = self.bounds
        
        target.addSubview(blurEffectView)
        target.addSubview(self)
        
        UIView.animate(withDuration: 0.15, animations: {
            self.alpha = 1
            self.contentView.alpha = 1
            self.contentView.frame = CGRect(x: (target.frame.width - self._w) / 2, y: (target.frame.height - self._h) / 2 - self.dummyStart, width: self._w, height: self._h)
            
            }, completion: { complete in
                self.contentView.layer.cornerRadius = self.corner
                UIView.animate(withDuration: 0.05, animations: {
                    for subview in self.contentView.subviews {
                        subview.alpha = 1
                    }
                })
        })
        
        self.attached = true
    }
    
    func dismiss() {
        self.attached = false
        if let target = self.target {
            UIView.animate(withDuration: 0.05, animations: {
                for subview in self.contentView.subviews {
                    subview.alpha = 0
                }
                self.contentView.alpha = 0.5
                }, completion: { complete in
                    UIView.animate(withDuration: 0.15, animations: {
                        self.contentView.frame = target.frame
                        self.alpha = 0
                        self.blurEffectView.removeFromSuperview()
                        }, completion: { complete in
                            self.removeFromSuperview()
                    })
            })
            
            
        } else {
            self.removeFromSuperview()
        }
    }
    
    func setWidthHeight(width: CGFloat, _ height: CGFloat) {
        self._w = width
        self._h = height
    }
    
    func setJKCorner(corner: CGFloat) {
        self.corner = corner
    }
    
    func setJKBlurEffect(blurEffect: UIBlurEffect.Style) {
        self.blurEffect = blurEffect
    }
    
    @objc func hideKeyboardDismiss() {
        for v in self.contentView.subviews {
            if(v.isKind(of: UITextField.self) || v.isKind(of: UITextView.self)) {
                v.resignFirstResponder()
            }
        }
        dismiss()
    }
    
    @objc func keyboardShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let y = (self.frame.height - keyboardSize.height - self.contentView.frame.height) / 2 + 42 - dummyStart
            if self.contentView.frame.minY > y {
                UIView.animate(withDuration: 0.2, animations: {
                    self.contentView.frame = CGRect(x: self.contentView.frame.minX, y: (self.frame.height - keyboardSize.height - self.contentView.frame.height) / 2 + 42 - self.dummyStart, width: self.contentView.frame.width, height: self.contentView.frame.height)
                })
            }
        }
    }
    
    @objc func keyboardHide(notification: NSNotification) {
        if let target = self.target {
            UIView.animate(withDuration: 0.2, animations: {
                self.contentView.frame = CGRect(x: (target.frame.width - self._w) / 2, y: (target.frame.height - self._h) / 2 - self.dummyStart, width: self._w, height: self._h)
            })
        }
    }
    
    override func removeFromSuperview() {
        super.removeFromSuperview()
        NotificationCenter.default.removeObserver(self)
    }    
    
}
