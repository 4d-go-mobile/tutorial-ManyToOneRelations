//
//  ___TABLE___DetailsForm.swift
//  ___PACKAGENAME___
//
//  Created by ___FULLUSERNAME___ on ___DATE___
//  ___COPYRIGHT___

import UIKit
import QMobileUI

/// Generated details form for ___TABLE___ table.
@IBDesignable

class ___TABLE___CustomProgressBarDetail: UIView {

    @IBInspectable var percent: CGFloat = 0.9
    @IBInspectable var barColor: UIColor = UIColor.blue
    @IBInspectable var bgColor: UIColor = UIColor.clear
    @IBInspectable var thickness: CGFloat = 20
    @IBInspectable var bgThickness: CGFloat = 20
    @IBInspectable var isHalfBar: Bool = false
    @IBInspectable var oldpercent: CGFloat = 0

    var arc = CAShapeLayer()
    let arc2 = CAShapeLayer()
    let nilPercent: CGFloat = -1

    @objc dynamic public var graphnumber: NSNumber? {
        get {
            return (percent / 100) as NSNumber
        }
        set {
            oldpercent = self.percent
            guard let number = newValue else {
                self.percent = nilPercent
                return
            }
            percent = (CGFloat(number.doubleValue)) / 100
            setNeedsDisplay()
        }
    }

    override func draw(_ rect: CGRect) {
        let X = self.bounds.midX
        let Y = self.bounds.midY
        var strokeStart: CGFloat = self.oldpercent
        var strokeEnd: CGFloat = percent
        var size = self.frame.size.width
        if self.frame.size.height < size {
            size = self.frame.size.height
        }
        size -= 0
        if self.isHalfBar == true {
            strokeStart = 0.2
            strokeEnd = (strokeEnd / 1.2) + 0.18
            let degrees = 55.0
            let radians = CGFloat(degrees * Double.pi / 180)
            layer.transform = CATransform3DMakeRotation(radians, 0.0, 0.0, 1.0)
        }
        let path = UIBezierPath(ovalIn: CGRect(x: (X - (260/2)), y: (Y - (260/2)), width: 260, height: 260)).cgPath
        self.addOval(self.bgThickness, path: path, strokeStart: strokeStart, strokeEnd: 1.0, strokeColor: self.bgColor, fillColor: UIColor.clear, shadowRadius: 0, shadowOpacity: 0, shadowOffsset: CGSize.zero)
        self.addOval2(self.thickness, path: path, strokeStart: strokeStart, strokeEnd: strokeEnd, strokeColor: self.barColor, fillColor: UIColor.clear, shadowRadius: 0, shadowOpacity: 0, shadowOffsset: CGSize.zero)
    }

    // swiftlint:disable:next function_parameter_count
    func addOval(_ lineWidth: CGFloat, path: CGPath, strokeStart: CGFloat, strokeEnd: CGFloat, strokeColor: UIColor, fillColor: UIColor, shadowRadius: CGFloat, shadowOpacity: Float, shadowOffsset: CGSize) {

        arc.lineWidth = lineWidth
        arc.opacity = 0.2
        arc.path = path
        arc.strokeStart = strokeStart
        arc.strokeEnd = strokeEnd
        arc.strokeColor = strokeColor.cgColor
        arc.fillColor = fillColor.cgColor
        arc.shadowColor = UIColor.black.cgColor
        arc.shadowRadius = shadowRadius
        arc.shadowOpacity = shadowOpacity
        arc.shadowOffset = shadowOffsset
        arc.lineCap = .round
        layer.addSublayer(arc)
    }

    // swiftlint:disable:next function_parameter_count
    func addOval2(_ lineWidth: CGFloat, path: CGPath, strokeStart: CGFloat, strokeEnd: CGFloat, strokeColor: UIColor, fillColor: UIColor, shadowRadius: CGFloat, shadowOpacity: Float, shadowOffsset: CGSize) {

        arc2.lineWidth = lineWidth
        arc2.path = path
        arc2.strokeStart = strokeStart
        arc2.strokeEnd = strokeEnd
        arc2.strokeColor = strokeColor.cgColor
        arc2.fillColor = fillColor.cgColor
        arc2.shadowColor = UIColor.black.cgColor
        arc2.shadowRadius = shadowRadius
        arc2.shadowOpacity = shadowOpacity
        arc2.shadowOffset = shadowOffsset
        arc2.lineCap = .round
        layer.addSublayer(arc2)
    }
    
    func animateGraph() {
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        
        animation.fromValue = arc.strokeStart
        animation.toValue = arc.strokeEnd
        animation.duration = 1.5
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        arc.add(animation, forKey: "drawLineAnimation")
        
        animation.fromValue = arc2.strokeStart
        animation.toValue = arc2.strokeEnd
        animation.duration = 1.5
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        arc2.add(animation, forKey: "drawLineAnimation")
    }
}

class ___TABLE___DetailsForm: DetailsFormBare {

    /// The record displayed in this form
    var record: ___TABLE___ {
        return super.record as! ___TABLE___
    }

    @IBOutlet weak var labelDate1: UILabel!
    @IBOutlet weak var labelDate2: UILabel!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var graphView: ___TABLE___CustomProgressBarDetail!
    
    let pickerColor = UIColor(red: 67/255, green: 117/255, blue: 203/255, alpha: 1.0)
    
    let doneButton = UIButton()
    let cancelButton = UIButton()
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction override func nextRecord(_ sender: Any!) {
        nextRecord()
    }
    
    @IBAction override func previousRecord(_ sender: Any!) {
        previousRecord()
    }

    let dateFormatter = DateFormatter()
   
    
    
    // MARK: Events
    override func onLoad() {
        // Do any additional setup after loading the view.
        
        backButton.transform = CGAffineTransform(scaleX: 0, y: 0)
        previousButton.transform = CGAffineTransform(scaleX: 0, y: 0 )
        nextButton.transform = CGAffineTransform(scaleX: 0, y: 0)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.graphView.animateGraph()
        }

    }
    
    override func onWillAppear(_ animated: Bool) {
        // Called when the view is about to made visible. Default does nothing
    }
    
    override func onDidAppear(_ animated: Bool) {
        // Called when the view has been fully transitioned onto the screen. Default does nothing

        
        UIView.animate(withDuration: 1.5,
                       delay: 0.2,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 1.0,
                       options: [.curveEaseOut, .allowUserInteraction],
                       animations: {
                        self.backButton.transform = .identity
        },
                       completion: nil)
        
        UIView.animate(withDuration: 1.5,
                       delay: 0.4,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 1.0,
                       options: [.curveEaseOut, .allowUserInteraction],
                       animations: {
                        self.previousButton.transform = .identity
        },
                       completion: nil)
        
        UIView.animate(withDuration: 1.5,
                       delay: 0.6,
                       usingSpringWithDamping: 0.6,
                       initialSpringVelocity: 1.0,
                       options: [.curveEaseOut, .allowUserInteraction],
                       animations: {
                        
                        self.nextButton.transform = .identity
        },
                       completion: nil)
        
    }
    
    override func onWillDisappear(_ animated: Bool) {
        // Called when the view is dismissed, covered or otherwise hidden. Default does nothing
    }
    
    override func onDidDisappear(_ animated: Bool) {
        // Called after the view was dismissed, covered or otherwise hidden. Default does nothing
    }
    // MARK: Custom actions
}
