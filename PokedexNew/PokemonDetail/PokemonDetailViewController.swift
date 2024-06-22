//
//  PokemonDetailViewController.swift
//  PokedexNew
//
//  Created by Diplomado on 21/06/24.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    private let viewModel: PokemonDetailViewModel
    
    // Define scrollView as a stored property instead of a computed property
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .purple
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        return view
    }()
    
    private lazy var pokemonImagenView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "lizard")
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100)
        ])
        return imageView
    }()
    
    private lazy var pokemonName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = viewModel.pokemonName
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
//    private lazy pokemonLocationButton: UIButton = {
//        
//    }
    
    init(pokemon: Pokemon) {
            viewModel = PokemonDetailViewModel(with: pokemon)
            super.init(nibName: nil, bundle: nil)
        }
    
    deinit {
        print("")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        let contentViewHeightAnchor = contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        contentViewHeightAnchor.isActive = true
        contentViewHeightAnchor.priority = .required - 1
        
//        let redView = UIView()
//        redView.backgroundColor = .red
//        redView.translatesAutoresizingMaskIntoConstraints = false
        
//        contentView.addSubview(redView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
            
//            redView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            redView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
//            redView.widthAnchor.constraint(equalToConstant: 50),
//            redView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
//            redView.heightAnchor.constraint(equalToConstant: 1000),
        ])
        
        let pokemonInfoStack = UIStackView()
        pokemonInfoStack.translatesAutoresizingMaskIntoConstraints = false
        pokemonInfoStack.axis = .vertical
        pokemonInfoStack.distribution = .fillProportionally
        
        pokemonInfoStack.addArrangedSubview(pokemonImagenView)
        pokemonInfoStack.addArrangedSubview(pokemonName)
        //pokemonInfoStack.addArrangedSubview(pokemonLocationButton)
        
        contentView.addSubview(pokemonInfoStack)
        
        NSLayoutConstraint.activate([
            pokemonInfoStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            pokemonInfoStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            pokemonInfoStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            pokemonInfoStack.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor)
        ])
        
        //pokemonLocationButton.addTarget(self, action: #selector(locationButtonTapped), for)
    }
}

extension PokemonDetailViewController: PokemonDetailViewModelDelegate {
    func updatePokemonImage(to image: UIImage) {
        pokemonImagenView.image = image
    }
}
