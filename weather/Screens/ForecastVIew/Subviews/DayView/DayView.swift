//
//  DayView.swift
//  weather
//
//  Created by Alexandr Onischenko on 26.02.2024.
//

import Foundation
import UIKit
import SnapKit

final class DayView: UIView {
    var viewModel: DayViewModel

    private lazy var date: UILabel = {
        let label = UILabel()
        label.text = viewModel.formattedDate
        label.textAlignment = .center
        label.font = .common()
        return label
    }()

    private lazy var dayConditionImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "\(viewModel.dayCondition.rawValue)")
        view.contentMode = .scaleAspectFit
        return view
    }()

    private lazy var nightConditionImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "\(viewModel.nightCondition.rawValue)")
        view.contentMode = .scaleAspectFit
        return view
    }()

    private lazy var temperatureNight: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.text = "\(viewModel.night)"
        return view
    }()

    private lazy var temperatureDay: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.text = "\(viewModel.day)"
        return view
    }()

    init(viewModel: DayViewModel) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        addSubview(date)
        addSubview(dayConditionImage)
        addSubview(nightConditionImage)
        addSubview(temperatureDay)
        addSubview(temperatureNight)

        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = CGFloat(Constants.Offset.x)
        stack.distribution = .fillEqually

        stack.addArrangedSubview(date)
        stack.addArrangedSubview(dayConditionImage)
        stack.addArrangedSubview(temperatureDay)
        stack.addArrangedSubview(temperatureNight)
        stack.addArrangedSubview(nightConditionImage)
        addSubview(stack)

        stack.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
