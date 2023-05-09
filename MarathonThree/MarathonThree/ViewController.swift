//
//  ViewController.swift
//  MarathonThree
//
//  Created by Нахид Гаджалиев on 09.05.2023.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - PRIVATE PROPERTIES
    private lazy var boxView: UIView = {
        let box = UIView()
        box.layer.backgroundColor = UIColor.systemBlue.cgColor
        box.layer.cornerRadius = 8
        box.translatesAutoresizingMaskIntoConstraints = false
        
        return box
    }()
    
    private lazy var sliderView: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 1.0
        slider.translatesAutoresizingMaskIntoConstraints = false
        
        return slider
    }()
    
    private let animator = UIViewPropertyAnimator(duration: 0.2, curve: .easeInOut)
    private let angle: CGFloat = (90.0 * 3.14/180.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
}




// MARK: - ADDING METHODS
extension ViewController {
    
    private func sliderReg() {
        
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { timer in
            self.sliderView.value += 0.1
        }
        
    }
    
    private func setupView() {
        view.addSubview(boxView)
        view.backgroundColor = .white
        setupAnimator()
        setupSlider()
        setupConstraints()
    }
    
    private func setupAnimator() {
        animator.addAnimations {
            self.boxView.transform = CGAffineTransform(rotationAngle: self.angle).scaledBy(x: 1.5, y: 1.5)
            self.boxView.center.x += self.view.frame.width - self.boxView.bounds.width - self.view.layoutMargins.right * 3
        }
    }
    
    private func setupSlider() {
        view.addSubview(sliderView)
        sliderView.addTarget(self, action: #selector(moveSquareView), for: .valueChanged)
        sliderView.addTarget(self, action: #selector(animateView), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            boxView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            boxView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            boxView.heightAnchor.constraint(equalToConstant: 70),
            boxView.widthAnchor.constraint(equalToConstant: 70),
            
            sliderView.topAnchor.constraint(equalTo: boxView.bottomAnchor, constant: 40),
            sliderView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            sliderView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
        ])
    }
    
}




// MARK: - ADDING ACTIONS
extension ViewController {
    @objc private func moveSquareView(sender: UISlider) {
        animator.fractionComplete = CGFloat(sender.value)
    }
    
    @objc private func animateView() {
        
        if animator.isRunning {
            sliderView.value = Float(animator.fractionComplete)
        }
        
        sliderView.setValue(sliderView.maximumValue, animated: true)
        animator.startAnimation()
        animator.pausesOnCompletion = true
        
    }
}
