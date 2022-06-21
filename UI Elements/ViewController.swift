//
//  ViewController.swift
//  UI Elements
//
//  Created by arun-13930 on 20/06/22.
//

import UIKit

class ViewController: UIViewController
{
    private let switcher: UISwitch = { let switcherTmp = UISwitch(true)
        switcherTmp.onTintColor = .systemBlue
        return switcherTmp
    }()
    
    private let slider: UISlider = { let sliderTmp = UISlider(true)
        sliderTmp.minimumValue = 0.2
        sliderTmp.maximumValue = 1
        sliderTmp.minimumValueImage = UIImage(systemName: "light.min")
        sliderTmp.maximumValueImage = UIImage(systemName: "light.max")
        //sliderTmp.isContinuous = false
        sliderTmp.setThumbImage(UIImage(systemName: "lightbulb"), for: .normal)
        sliderTmp.setThumbImage(UIImage(systemName: "lightbulb.fill"), for: .highlighted)
        sliderTmp.minimumTrackTintColor = .white
        sliderTmp.maximumTrackTintColor = .darkGray
        return sliderTmp
    }()
    
    private let pickerView1: UIPickerView = { let pView = UIPickerView(true)
        return pView
    }()
    
    private let pickerViewWithMultipleComponents: UIPickerView = { let pView2 = UIPickerView(true)
        return pView2
    }()
    
    private let menu: UIMenu = { let menuTmp = UIMenu(title: "Sample Menu", image: nil, identifier: nil, options: UIMenu.Options.displayInline , children: [
        UIAction(title: "Delete", image: UIImage(systemName: "trash.fill"), attributes: UIMenuElement.Attributes.destructive, handler: { (_) in
            print("Deleted RGB Values !")
        }),
        UIAction(title: "Paste", image: UIImage(systemName: "doc.on.clipboard.fill"), handler: { (_) in
            print("Pasted RGB Values !")
        }),
        UIAction(title: "Copy", image: UIImage(systemName: "doc.on.doc.fill"), handler: { (_) in
            print("Copied RGB Values !")
        }),
        UIAction(title: "Cut", image: UIImage(systemName: "scissors"), handler: { (_) in
            print("Cut RGB Values !")
        }),
    ])
        return menuTmp
    }()
    
    private let showMenuButton: UIButton = { let button = UIButton(type: .system)
        button.enableAutoLayout()
        button.setTitle("Show Menu", for: .normal)
        button.titleLabel?.tintColor = .label
        return button
    }()
    
    private let showAlertButton: UIButton = { let button = UIButton(type: .system)
        button.enableAutoLayout()
        button.setTitle("Show Alert", for: .normal)
        button.titleLabel?.tintColor = .label
        return button
    }()
    
    private let alertController: UIAlertController = { let alert = UIAlertController(title: "Sample Alert", message: "Hello, this is an Alert !", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Ok", style: .default) { _ in
            print("OK")
//            alert.dismiss(animated: true)
        })
        alert.addAction(UIAlertAction(title: "Dismiss", style: .destructive) { _ in
//            alert.dismiss(animated: true)
        })
        return alert
    }()
    
    private lazy var pickerElements: [Int : UIColor?] = [3 : .systemBlue , 1: .systemRed, 2: .systemGreen, 4: .systemPurple, 0: .systemBackground, 5: nil]
    
    private lazy var colorNames = ["System Background", "System Red", "System Green", "System Blue", "System Purple", "Custom"]
    
    private lazy var arrayFromOto255 = Array(0...255)
    
    private var safeArea: UILayoutGuide!
    
    
    override func loadView()
    {
        super.loadView()
        safeArea = view.safeAreaLayoutGuide
        view.addSubview(switcher)
        view.addSubview(slider)
        view.addSubview(pickerView1)
        view.addSubview(pickerViewWithMultipleComponents)
        view.addSubview(showMenuButton)
        view.addSubview(showAlertButton)
        NSLayoutConstraint.activate([
            switcher.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            switcher.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            slider.topAnchor.constraint(equalTo: switcher.bottomAnchor, constant: 10),
            slider.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            slider.widthAnchor.constraint(equalTo: safeArea.widthAnchor, constant: -40),
            pickerView1.topAnchor.constraint(equalTo: slider.bottomAnchor, constant: 10),
            pickerView1.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            pickerViewWithMultipleComponents.topAnchor.constraint(equalTo: pickerView1.bottomAnchor, constant: 10),
            pickerViewWithMultipleComponents.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            showAlertButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -20),
            showAlertButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            showMenuButton.bottomAnchor.constraint(equalTo: showAlertButton.bottomAnchor, constant: -40),
            showMenuButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
        ])
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        overrideUserInterfaceStyle = .dark
        switcher.thumbTintColor = .gray
        switcher.isOn = overrideUserInterfaceStyle == .dark
        switcher.addTarget(self, action: #selector(onSwitchValueChanged(_:)), for: .valueChanged)
        slider.value = Float(view.alpha)
        slider.addTarget(self, action: #selector(onSliderValueChanged(_:)), for: .valueChanged)
        pickerView1.delegate = self
        pickerView1.dataSource = self
        pickerView1.selectRow(0, inComponent: 0, animated: true)
        pickerViewWithMultipleComponents.delegate = self
        pickerViewWithMultipleComponents.dataSource = self
        let rgbOfSystemBackground = UIColor.systemBackground.getRGB()
        pickerViewWithMultipleComponents.selectRow(Int(rgbOfSystemBackground.red * 255), inComponent: 0, animated: true)
        pickerViewWithMultipleComponents.selectRow(Int(rgbOfSystemBackground.green * 255), inComponent: 1, animated: true)
        pickerViewWithMultipleComponents.selectRow(Int(rgbOfSystemBackground.blue * 255), inComponent: 2, animated: true)
        showMenuButton.menu = menu
        showMenuButton.showsMenuAsPrimaryAction = true
        showAlertButton.addAction(UIAction { _ in
            self.present(self.alertController, animated: true)
        }, for: .touchUpInside)
    }

    @objc func onSwitchValueChanged(_ sender: UISwitch)
    {
        if switcher.isOn
        {
            overrideUserInterfaceStyle = .dark
            switcher.thumbTintColor = .white
            print("Switcher is turned on")
        }
        else
        {
            overrideUserInterfaceStyle = .light
            switcher.thumbTintColor = .gray
            print("Switcher is turned off")
        }
    }
    
    @objc func onSliderValueChanged(_ sender: UISlider)
    {
        print("Slider Value: \(sender.value)")
        view.alpha = CGFloat(sender.value)
    }
}

extension ViewController: UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        if pickerView == pickerView1
        {
            return 1
        }
        else
        {
            return 3
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        if pickerView == pickerView1
        {
            return pickerElements.count
        }
        else
        {
            return arrayFromOto255.count
        }
    }
}

extension ViewController: UIPickerViewDelegate
{
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        if pickerView == pickerView1
        {
            return colorNames[row]
        }
        else
        {
            return arrayFromOto255[row].description
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if pickerView == pickerView1
        {
            guard row != 5 else
            {
                let randomRed = arrayFromOto255.randomElement()!
                let randomGreen = arrayFromOto255.randomElement()!
                let randomBlue = arrayFromOto255.randomElement()!
                view.backgroundColor = .init(red: CGFloat(randomRed)/255, green: CGFloat(randomGreen)/255, blue: CGFloat(randomBlue)/255, alpha: CGFloat(slider.value))
                print("RGB: \(randomRed):\(randomGreen):\(randomBlue)")
                pickerViewWithMultipleComponents.selectRow(randomRed, inComponent: 0, animated: true)
                pickerViewWithMultipleComponents.selectRow(randomGreen, inComponent: 1, animated: true)
                pickerViewWithMultipleComponents.selectRow(randomBlue, inComponent: 2, animated: true)
                return
            }
            let color = pickerElements[row]!
            view.backgroundColor = color
            let rgbOpt = color?.getRGB()
            guard let rgb = rgbOpt else
            {
                return
            }
            pickerViewWithMultipleComponents.selectRow(Int(rgb.red * 255), inComponent: 0, animated: true)
            pickerViewWithMultipleComponents.selectRow(Int(rgb.green * 255), inComponent: 1, animated: true)
            pickerViewWithMultipleComponents.selectRow(Int(rgb.blue * 255), inComponent: 2, animated: true)
        }
        else
        {
            let red = arrayFromOto255[pickerView.selectedRow(inComponent: 0)]
            let green = arrayFromOto255[pickerView.selectedRow(inComponent: 1)]
            let blue = arrayFromOto255[pickerView.selectedRow(inComponent: 2)]
            print("RGB: \(red):\(green):\(blue)")
            view.backgroundColor = .init(red: CGFloat(red)/255, green: CGFloat(green)/255, blue: CGFloat(blue)/255, alpha: CGFloat(slider.value))
            pickerView1.selectRow(5, inComponent: 0, animated: true)
        }
    }
}
