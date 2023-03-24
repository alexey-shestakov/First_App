//
//  ScrollView.swift
//  First_App
//
//  Created by Alexey Shestakov on 08.03.2023.
//

import UIKit

class NewWorkoutScrollView: UIScrollView {
    
    let contentView : UIView = {
        let content = UIView()
        content.backgroundColor = .specialBackground        // Тамик у contentView не вырубаем!
        return content
    }()
    
    //MARK: Elements
    private let titleLabel = TitleLabel(textTitle: "NEW WORKOUT", textColor: .specialBlack, textAlignment: .center)
    
    let closeButton = CloseButton()
    
    let nameView = NameView()
    let imageWorkout = ImageWorkoutView()
    let dateAndRepeat = DateAndRepeatView()
    let repsOrTimer = RepsOrTimerView()

    lazy var saveButton = GreenButton(text: "SAVE")
    
    private var stack = UIStackView()                           // объявили пустой стэк
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(contentViewWidth: Double, contentViewHeight: Double) {
        self.init(frame: .zero)
        configure(contentViewWidth: contentViewWidth, contentViewHeight: contentViewHeight)
        setUpViews()
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(contentViewWidth: Double, contentViewHeight: Double) {
        self.backgroundColor = .specialBackground
        self.translatesAutoresizingMaskIntoConstraints = false
        self.keyboardDismissMode = .onDrag
        
        self.contentSize = CGSize(width: contentViewWidth, height: contentViewHeight + 3*20 + 100)
        contentView.frame.size = self.contentSize
    }
    
    private func setUpViews() {
        self.addSubview(contentView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(closeButton)
        
        self.stack = UIStackView(arrangedSubviews: [nameView, imageWorkout, dateAndRepeat, repsOrTimer],
                                 axis: .vertical,
                                 spacing: 20)
        contentView.addSubview(stack)
        self.addSubview(saveButton)
    }
}


//MARK: Constraints
extension NewWorkoutScrollView {
    private func setUpConstraints() {
        
        titleLabel.setUpConstraints(atView: contentView)
        closeButton.setUpConstraints(atView: contentView, atOneYWith: titleLabel)
        
        NSLayoutConstraint.activate([
            
            stack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            nameView.heightAnchor.constraint(equalToConstant: 60),
            imageWorkout.heightAnchor.constraint(equalToConstant: 110),
            dateAndRepeat.heightAnchor.constraint(equalToConstant: 115),
            repsOrTimer.heightAnchor.constraint(equalToConstant: 340),

            saveButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            saveButton.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 100),                    // эта сотка это и будет эти extra points
            saveButton.heightAnchor.constraint(equalToConstant: 55),
            saveButton.widthAnchor.constraint(equalToConstant: 340),
            saveButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10)
        ])
    }
}
