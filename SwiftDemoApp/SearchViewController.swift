import UIKit

class SearchViewController: UIViewController {

    // MARK: - UI Elements
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "🔍 Search Pokémon"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        label.accessibilityIdentifier = "search-title"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let searchField: UITextField = {
        let field = UITextField()
        field.placeholder = "Enter Pokémon name..."
        field.borderStyle = .roundedRect
        field.accessibilityIdentifier = "search-field"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()

    let searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Search", for: .normal)
        button.backgroundColor = .systemRed
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.layer.cornerRadius = 8
        button.accessibilityIdentifier = "search-button"
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let activityIndicator: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.accessibilityIdentifier = "loading-spinner"
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()

    let pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.accessibilityIdentifier = "pokemon-image"
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    let resultLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.accessibilityIdentifier = "result-label"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let typeBadgeLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.accessibilityIdentifier = "type-badge"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let statsLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14)
        label.accessibilityIdentifier = "stats-label"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "PokéTrainer"
        setupUI()
        searchButton.addTarget(self, action: #selector(searchTapped), for: .touchUpInside)
    }

    // MARK: - Setup
    func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(searchField)
        view.addSubview(searchButton)
        view.addSubview(activityIndicator)
        view.addSubview(pokemonImageView)
        view.addSubview(resultLabel)
        view.addSubview(typeBadgeLabel)
        view.addSubview(statsLabel)

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),

            searchField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            searchField.widthAnchor.constraint(equalToConstant: 280),

            searchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchButton.topAnchor.constraint(equalTo: searchField.bottomAnchor, constant: 12),
            searchButton.widthAnchor.constraint(equalToConstant: 280),
            searchButton.heightAnchor.constraint(equalToConstant: 44),

            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: 20),

            pokemonImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pokemonImageView.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 10),
            pokemonImageView.widthAnchor.constraint(equalToConstant: 150),
            pokemonImageView.heightAnchor.constraint(equalToConstant: 150),

            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultLabel.topAnchor.constraint(equalTo: pokemonImageView.bottomAnchor, constant: 12),
            resultLabel.widthAnchor.constraint(equalToConstant: 280),

            typeBadgeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            typeBadgeLabel.topAnchor.constraint(equalTo: resultLabel.bottomAnchor, constant: 8),
            typeBadgeLabel.widthAnchor.constraint(equalToConstant: 120),
            typeBadgeLabel.heightAnchor.constraint(equalToConstant: 30),

            statsLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statsLabel.topAnchor.constraint(equalTo: typeBadgeLabel.bottomAnchor, constant: 12),
            statsLabel.widthAnchor.constraint(equalToConstant: 280),
        ])
    }

    // MARK: - Actions
    @objc func searchTapped() {
        guard let name = searchField.text?.lowercased(), !name.isEmpty else {
            resultLabel.text = "Please enter a Pokémon name"
            return
        }
        activityIndicator.startAnimating()
        pokemonImageView.image = nil
        resultLabel.text = ""
        statsLabel.text = ""
        typeBadgeLabel.text = ""
        fetchPokemon(name: name)
    }

    // MARK: - Type Color
    func colorForType(_ type: String) -> UIColor {
        switch type.lowercased() {
        case "fire": return .systemRed
        case "water": return .systemBlue
        case "grass": return .systemGreen
        case "electric": return .systemYellow
        case "psychic": return .systemPink
        case "ice": return .cyan
        case "dragon": return .systemIndigo
        case "dark": return .darkGray
        case "fairy": return .systemPink
        case "fighting": return .brown
        case "poison": return .purple
        case "ground": return .systemOrange
        case "rock": return .gray
        case "ghost": return .systemPurple
        case "steel": return .systemGray
        case "bug": return .systemGreen
        case "normal": return .systemGray
        case "flying": return .systemTeal
        default: return .systemGray
        }
    }

    // MARK: - API Call
    func fetchPokemon(name: String) {
        let urlString = "https://pokeapi.co/api/v2/pokemon/\(name)"
        guard let url = URL(string: urlString) else { return }

        let delegate = InsecureURLSessionDelegate()
        let session = URLSession(configuration: .default, delegate: delegate, delegateQueue: nil)

        session.dataTask(with: url) { data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.resultLabel.text = "Error: \(error.localizedDescription)"
                }
                return
            }

            guard let data = data,
                  let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.resultLabel.text = "Pokémon not found!"
                }
                return
            }

            let pokemonName = (json["name"] as? String ?? "").capitalized

            var statsText = ""
            if let stats = json["stats"] as? [[String: Any]] {
                for stat in stats {
                    let baseStat = stat["base_stat"] as? Int ?? 0
                    if let statInfo = stat["stat"] as? [String: Any],
                       let statName = statInfo["name"] as? String {
                        statsText += "\(statName.capitalized): \(baseStat)\n"
                    }
                }
            }

            var primaryType = ""
            var typesText = ""
            if let types = json["types"] as? [[String: Any]] {
                let typeNames = types.compactMap { typeEntry -> String? in
                    if let typeInfo = typeEntry["type"] as? [String: Any] {
                        return (typeInfo["name"] as? String)?.capitalized
                    }
                    return nil
                }
                primaryType = typeNames.first ?? ""
                typesText = typeNames.joined(separator: ", ")
            }

            var imageUrl: String? = nil
            if let sprites = json["sprites"] as? [String: Any] {
                imageUrl = sprites["front_default"] as? String
            }

            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.resultLabel.text = "🎮 \(pokemonName)"
                self.typeBadgeLabel.text = "  \(typesText)  "
                self.typeBadgeLabel.backgroundColor = self.colorForType(primaryType)
                self.typeBadgeLabel.textColor = .white
                self.statsLabel.text = statsText

                if let imageUrlString = imageUrl, let url = URL(string: imageUrlString) {
                    let imageDelegate = InsecureURLSessionDelegate()
                    let imageSession = URLSession(configuration: .default, delegate: imageDelegate, delegateQueue: nil)
                    imageSession.dataTask(with: url) { data, _, _ in
                        if let data = data, let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                self.pokemonImageView.image = image
                            }
                        }
                    }.resume()
                }
            }
        }.resume()
    }
}

// MARK: - SSL Bypass
class InsecureURLSessionDelegate: NSObject, URLSessionDelegate {
    func urlSession(_ session: URLSession,
                    didReceive challenge: URLAuthenticationChallenge,
                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if let trust = challenge.protectionSpace.serverTrust {
            completionHandler(.useCredential, URLCredential(trust: trust))
        } else {
            completionHandler(.cancelAuthenticationChallenge, nil)
        }
    }
}
