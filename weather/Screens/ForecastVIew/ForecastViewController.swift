//
//  ForecastViewController.swift
//  weather
//
//  Created by Alexandr Onischenko on 26.02.2024.
//

import UIKit
import Combine

class ForecastViewController: UIViewController {
    private var viewModel: ForecastViewModel
    @Published var hourViewModels: [HourViewModel] = []
    @Published var dayViewModels: [DayViewModel] = []

    private var cancellable: Set<AnyCancellable> = []

    private lazy var mainScrollView: UIScrollView = {
        let view = UIScrollView()
        view.indicatorStyle = .black
        return view
    }()

    // MARK: INFOVIEW
    private lazy var cityLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30, weight: .medium)
        label.textAlignment = .center
        return label
    }()

    private lazy var temperatureLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 50, weight: .semibold)
        label.textAlignment = .center
        return label
    }()

    private lazy var conditionImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: IconCondition.cloud.rawValue)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    // MARK: DAYVIEW
    private lazy var dayLabel: UILabel = {
        let view = UILabel()
        view.text = Localizable.hourlyForecast.localized
        view.font = .systemFont(ofSize: 24, weight: .medium)
        return view
    }()

    private lazy var dayScrollView: UIScrollView = {
        let view = UIScrollView()
        view.layer.cornerRadius = 8
        return view
    }()

    private lazy var dayStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 16
        return view
    }()

    // MARK: WEEKVIEW
    private lazy var weekLabel: UILabel = {
        let view = UILabel()
        view.text = Localizable.weeklyForecast.localized
        view.font = .systemFont(ofSize: 24, weight: .medium)
        return view
    }()

    private lazy var weekStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()

    init(viewModel: ForecastViewModel, hours: [HourViewModel], days: [DayViewModel]) {
        self.viewModel = viewModel
        self.hourViewModels = hours
        self.dayViewModels = days
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        binding()
        viewModel.fetchData()
    }

    func binding() {
        viewModel.$info.sink { [weak self] info in
            guard let info = info.first else { return }
            self?.cityLabel.text = info.city
            self?.temperatureLabel.text = info.temp
            self?.conditionImage.image = UIImage(systemName: "\(info.condition.rawValue)")
        }.store(in: &cancellable)

        viewModel.$itemsByTheDay.sink { [weak self] days in
            self?.dayViewModels = days
            self?.weekStackView.removeAllArrangedSubviews()
            for day in days {
                let view = DayView(viewModel: day)
                self?.weekStackView.addArrangedSubview(view)
            }

        }.store(in: &cancellable)

        viewModel.$itemsByTheHour.sink { [weak self] hours in
            self?.hourViewModels = hours
            self?.dayStackView.removeAllArrangedSubviews()
            for hour in hours {
                let view = HourView(item: hour)
                self?.dayStackView.addArrangedSubview(view)
            }
        }.store(in: &cancellable)
    }

    func configureView() {
        configureNavigationBar()
        view.backgroundColor = .white
        view.addSubview(mainScrollView)

        // MARK: SCROLLVIEW
        mainScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        // MARK: INFOVIEW
        mainScrollView.addSubview(cityLabel)
        mainScrollView.addSubview(temperatureLabel)
        mainScrollView.addSubview(conditionImage)

        cityLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        temperatureLabel.snp.makeConstraints { make in
            make.top.equalTo(cityLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        conditionImage.snp.makeConstraints { make in
            make.top.equalTo(temperatureLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.height.width.equalTo(100)
        }

        // MARK: DAYVIEW
        mainScrollView.addSubview(dayLabel)
        mainScrollView.addSubview(dayScrollView)
        dayScrollView.addSubview(dayStackView)

        dayLabel.snp.makeConstraints { make in
            make.top.equalTo(conditionImage.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview()
        }
        dayScrollView.snp.makeConstraints { make in
            make.top.equalTo(dayLabel.snp.bottom).offset(8)
            make.leading.equalTo(mainScrollView.snp.leading).offset(16)
            make.trailing.equalTo(mainScrollView.snp.trailing).inset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(100)
        }
        dayStackView.snp.makeConstraints { make in
            make.top.equalTo(dayScrollView.snp.top).offset(8)
            make.leading.equalTo(dayScrollView.snp.leading).offset(8)
            make.trailing.equalTo(dayScrollView.snp.trailing).inset(8)
            make.bottom.equalTo(dayScrollView.snp.bottom).inset(8)
        }

        // MARK: WEEKVIEW

        mainScrollView.addSubview(weekLabel)
        mainScrollView.addSubview(weekStackView)

        weekLabel.snp.makeConstraints { make in
            make.top.equalTo(dayScrollView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().inset(16)
        }
        weekStackView.snp.makeConstraints { make in
            make.top.equalTo(weekLabel.snp.bottom).offset(16)
            make.leading.equalTo(mainScrollView.snp.leading).offset(32)
            make.trailing.equalTo(mainScrollView.snp.trailing).inset(32)
            make.bottom.equalTo(mainScrollView.snp.bottom).inset(8)
        }
    }

    func configureNavigationBar() {
        let button = UIBarButtonItem(image: UIImage(systemName: "location.fill"), style: .done, target: self, action: #selector(getLocationForecast))
        navigationItem.leftBarButtonItem = button
        let buttonRight = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .done, target: self, action: #selector(searchButtonTapped))
        navigationItem.rightBarButtonItem = buttonRight
    }

    @objc func getLocationForecast() {
        viewModel.fetchDataFromLocation()
    }

    @objc func searchButtonTapped() {
        let searchViewModel = SearchViewModel()
        let viewController = SearchViewController(viewModel: searchViewModel)

        searchViewModel.$city.sink { receive in
        } receiveValue: { [weak self] value in
            guard let value = value else { return }
            self?.viewModel.city = value
            self?.viewModel.clearData()
            self?.viewModel.fetchData()
        }.store(in: &cancellable)

        navigationController?.pushViewController(viewController, animated: true)
    }
}


