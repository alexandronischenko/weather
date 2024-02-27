//
//  HourView.swift
//  weather
//
//  Created by Alexandr Onischenko on 26.02.2024.
//

import Foundation
import UIKit

final class HourView: UIView {
    var item: HourViewModel

    private lazy var labelTime: UILabel = {
        let view = UILabel()
        view.text = item.formattedTime
        view.textAlignment = .center
        return view
    }()

    private lazy var image: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: item.condition.rawValue)
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private lazy var labelTemp: UILabel = {
        let view = UILabel()
        view.text = item.formattedTemp
        view.textAlignment = .center
        return view
    }()

    init(item: HourViewModel) {
        self.item = item
        super.init(frame: .zero)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureView() {
        addSubview(labelTime)
        addSubview(image)
        addSubview(labelTemp)

        labelTime.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        image.snp.makeConstraints { make in
            make.top.equalTo(labelTime.snp.bottom).offset(Constants.Offset.x4 / Constants.Offset.x)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(Constants.Offset.x)
        }
        labelTemp.snp.makeConstraints { make in
            make.top.equalTo(image.snp.bottom).offset(Constants.Offset.x4 / Constants.Offset.x)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
    }
}
