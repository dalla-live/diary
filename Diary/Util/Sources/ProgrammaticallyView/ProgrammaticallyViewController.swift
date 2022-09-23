//
//  ProgrammaticallyViewController.swift
//  Util
//
//  Created by inforex on 2022/09/23.
//

import Foundation
import UIKit
import RxSwift

open class ProgrammaticallyViewController: UIViewController, Programmaticable {
    public var fileName: String = "" {
        willSet {
            print("\(newValue) init")
        }
    }
    
    public var disposeBag = DisposeBag()

    override open func viewDidLoad() {
        super.viewDidLoad()
        
        commonInit()
    }
    
    func commonInit() {
        addComponent()
        setConstraints()
        bind()
        moreAction()
    }
    
    open func addComponent() { }
    
    open func setConstraints() { }
    
    open func bind() { }
    
    open func moreAction() { }
    
    open func deinitAction() { }
    
    deinit {
        print("\(fileName) deinit")
        deinitAction()
        disposeBag = DisposeBag()
    }
}
