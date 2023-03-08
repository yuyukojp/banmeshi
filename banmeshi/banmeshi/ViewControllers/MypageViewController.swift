//
//  MypageViewController.swift
//  banmeshi
//
//  Created by 金斗石 on 2022/1/13.
//

import UIKit
import RealmSwift
import RxSwift
import RxCocoa
import SwiftCSVExport
import PDFKit

class MypageViewController: BaseViewController {
    private var outputButton: CusstomButton!
    private var inputButton:CusstomButton!
    private var testTextField: CustomTextField!
    private var versionLabel: UILabel!
    private var buildLabel: UILabel!
    
    
    let contactInfo = ["テキスト1", "テキスト2", "テキスト3", "テキスト4", "テキスト5", "テキスト6", "テキスト7", "テキスト8"]
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupNavigation()
    }
    
    private func setupNavigation() {
        self.navigationItem.title = "个人信息"
        self.tabBarController?.tabBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = .textColor()
        // NavigationBarを表示したい場合
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.delegate = self
    }
    
    private func setupUI() {
        self.view.backgroundColor = .mainBackgroundColor()
        outputButton = CusstomButton(frame: CGRect(x: (Const.screenWidth - 140) / 2,
                                                   y: (Const.screenHeight - 80) / 2,
                                                   width: 140,
                                                   height: 50))
        outputButton.setTitle("导出CSV数据", for: .normal)
        outputButton.addTarget(self, action: #selector(tapOutputBtn), for: .touchUpInside)
        
        inputButton = CusstomButton(frame: CGRect(x: (Const.screenWidth - 140) / 2,
                                                  y: (Const.screenHeight + 80) / 2,
                                                  width: 140,
                                                  height: 50))
        inputButton.setTitle("导人CSV数据", for: .normal)
        inputButton.addTarget(self, action: #selector(tapInputBtn), for: .touchUpInside)
        self.view.addSubview(outputButton)
        self.view.addSubview(inputButton)
        testTextField = CustomTextField(frame: CGRect(x: 20, y: 120, width: 200, height: 40))
        self.view.addSubview(testTextField)
//        setupViewsLayout()
        versionLabel = UILabel()
        buildLabel = UILabel()
        versionLabel.frame = CGRect(x: 80, y: Const.screenHeight - 130, width: 120, height: 30)
        buildLabel.frame = CGRect(x: (Const.screenWidth / 2) + 20, y: Const.screenHeight - 130, width: 120, height: 30)
        let version: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
        let build: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String
        versionLabel.text = "Version: \(version)"
        buildLabel.text = "Build: \(build)"
        versionLabel.textColor = .lightGray
        buildLabel.textColor = .lightGray
        self.view.addSubview(versionLabel)
        self.view.addSubview(buildLabel)
    }
    
    @objc func tapOutputBtn() {
        newExport()
    }
    
    @objc func tapInputBtn() {
        
    }
}

extension MypageViewController: UINavigationBarDelegate {
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}

private extension MypageViewController {
    private func setupViewsLayout() {
        //selectPointBtn
        versionLabel = UILabel()
        view.addSubview(versionLabel)
        versionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(
            [
                versionLabel.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 130),
                versionLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 30),
                versionLabel.heightAnchor.constraint(equalToConstant: 30),
                versionLabel.widthAnchor.constraint(equalToConstant: 80),
//                versionLabel.centerYAnchor.constraint(equalTo: selectPointTF.centerYAnchor) //bottomAnchor.constraint(equalTo: menuTableView.topAnchor, constant: 40)
            ]
        )
        versionLabel.text = "321321"
        versionLabel.textColor = .lightText

    }
}

// MARK: エクスポート
private extension MypageViewController {
    
    //MARK: UIViewを画像としてPDFを作成
    func exportPDF() {
        // 紙A4のサイズは　210mm　*　297mm　フレームは４倍の：840　*　1188
        let view = TestView(frame: CGRect(x: 0.0, y: 0.0, width: 840.0, height: 1188.0))
        
        //MARK: imageを入れる。
//        let templateView = UIImageView(image: UIImage(named: "template"))
//        templateView.frame = CGRect(x: 0.0, y: 0.0, width: 1366.0, height: 1024.0)
//        templateView.contentMode = .scaleAspectFit
//        view.addSubview(templateView)
        
        
         
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, view.bounds, nil)
        guard let pdfContext = UIGraphicsGetCurrentContext() else { return }
        UIGraphicsBeginPDFPage()
        view.layer.render(in: pdfContext)
        //MARK: ２ページ目
        UIGraphicsBeginPDFPage()
        view.layer.render(in: pdfContext)
        UIGraphicsEndPDFContext()
             
        if let documentDirectories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
            let documentsFileName = documentDirectories + "/" + "testPDF.pdf"
            print("++++++Save path:\(documentDirectories)")
            textView.text = "Saved path:\n\(documentDirectories)"
            pdfData.write(toFile: documentsFileName, atomically: true)
        }
    }
    
    //MARK: テキストを選択できるPDFを作成
    func newExport() {
        let format = UIGraphicsPDFRendererFormat()
        let metaData = [
            kCGPDFContextTitle: "Hello, World!",
            kCGPDFContextAuthor: "John Doe"
          ]
        format.documentInfo = metaData as [String: Any]
        
        // US Letter
//        Width: 8.5 inches * 72 DPI = 612 points
//        Height: 11 inches * 72 DPI = 792 points
        // A4 would be [W x H] 595 x 842 points
        
        let pageRect = CGRect(x: 0, y: 0, width: 595, height: 842)
        let renderer = UIGraphicsPDFRenderer(bounds: pageRect,
                                             format: format)
        
        let data = renderer.pdfData { (context) in
          context.beginPage()
          
          let paragraphStyle = NSMutableParagraphStyle()
          paragraphStyle.alignment = .center
          let attributes = [
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14),
            NSAttributedString.Key.paragraphStyle: paragraphStyle
          ]
          let text = "Hello, World!"
          let textRect = CGRect(x: 100, // left margin
                                y: 100, // top margin
                            width: 200,
                           height: 20)

          text.draw(in: textRect, withAttributes: attributes)
            let context = context.cgContext
            drawTearOffs(context, pageRect: pageRect, tearOffY: pageRect.height * 1.0 / 5.0,
                         numberTabs: 8)
        }
        
        let pdfDocument = PDFDocument(data: data)
        if let documentDirectories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
            let documentsFileName = documentDirectories + "/" + "testPDF.pdf"
            print("++++++Save path:\(documentDirectories)")
            textView.text = "Saved path:\n\(documentDirectories)"
            pdfDocument?.write(toFile: documentsFileName)
        }
        
    }
    
    //MARK: 枠組描画
    func drawTearOffs(_ drawContext: CGContext, pageRect: CGRect,
                      tearOffY: CGFloat, numberTabs: Int) {
        // 2
        drawContext.saveGState()
        // 3
        drawContext.setLineWidth(2.0)
        
        // 4　上の線
        drawContext.move(to: CGPoint(x: 0, y: tearOffY))
        drawContext.addLine(to: CGPoint(x: pageRect.width, y: tearOffY))
        drawContext.strokePath()
        drawContext.restoreGState()

        
        // 5
        drawContext.saveGState()
//        let dashLength = CGFloat(72.0 * 0.2)  // 点線の幅
//        drawContext.setLineDash(phase: 0, lengths: [dashLength, dashLength])
        //縦線
        drawContext.addLine(to: CGPoint(x: pageRect.width, y: 10))
        // 6
        let tabWidth = pageRect.width / CGFloat(numberTabs)
        for tearOffIndex in 1..<numberTabs {
            // 7
            let tabX = CGFloat(tearOffIndex) * tabWidth
            drawContext.move(to: CGPoint(x: tabX, y: tearOffY)) // 縦線開始の座標
            drawContext.addLine(to: CGPoint(x: tabX, y: tearOffY + 50)) //縦線終了の座標
            drawContext.strokePath()
        }
        // 7
        drawContext.restoreGState()
        
        drawContactLabels(drawContext, pageRect: pageRect, numberTabs: 8)
        //8 下の枠線
        drawContext.move(to: CGPoint(x: 0, y: tearOffY + 50))
        drawContext.addLine(to: CGPoint(x: pageRect.width, y: tearOffY + 50))
        drawContext.strokePath()
        drawContext.restoreGState()
    }
    
    //MARK: 枠組のテキスト
    func drawContactLabels(
        _ drawContext: CGContext,
        pageRect: CGRect, numberTabs: Int) {
            let contactTextFont = UIFont.systemFont(ofSize: 10.0, weight: .regular)
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .natural
            paragraphStyle.lineBreakMode = .byWordWrapping
            let contactBlurbAttributes = [
                NSAttributedString.Key.paragraphStyle: paragraphStyle,
                NSAttributedString.Key.font: contactTextFont
            ]

            // 2 180度回転
//            drawContext.rotate(by: -90.0 * CGFloat.pi / 180.0)
            for tearOffIndex in 0..<numberTabs {
                //テキストを設置
                let attributedContactText = NSMutableAttributedString(
                    string: contactInfo[tearOffIndex],
                    attributes: contactBlurbAttributes
                )
                // 1
                let textHeight = attributedContactText.size().height
                let tabWidth = pageRect.width / CGFloat(numberTabs)
                let horizontalOffset = (tabWidth - textHeight) / 2.0
                drawContext.saveGState()
                
                let tabX = CGFloat(tearOffIndex) * tabWidth + horizontalOffset
                // 3 テキストの位置
                attributedContactText.draw(at: CGPoint(x: tabX - 17, y: 188))
            }
            drawContext.restoreGState()
        }
    

}
