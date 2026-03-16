import UIKit

class ViewController: UIViewController {
    
    var mainTabBar: UITabBarController?

    // MARK: - UI Elements
    let logoLabel: UILabel = {
        let label = UILabel()
        label.text = "⚡ PokéTrainer"
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textAlignment = .center
        label.accessibilityIdentifier = "app-logo"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let usernameField: UITextField = {
        let field = UITextField()
        field.placeholder = "Trainer Name"
        field.borderStyle = .roundedRect
        field.accessibilityIdentifier = "username-field"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()

    let passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = "Password"
        field.isSecureTextEntry = true
        field.borderStyle = .roundedRect
        field.accessibilityIdentifier = "password-field"
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()

    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .systemYellow
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 8
        button.accessibilityIdentifier = "login-button"
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    let errorLabel: UILabel = {
        let label = UILabel()
        label.text = " "  // ← single space instead of empty string
        label.textColor = .red
        label.textAlignment = .center
        label.accessibilityIdentifier = "error-label"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        loginButton.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
    }

    // MARK: - Setup
    func setupUI() {
        view.addSubview(logoLabel)
        view.addSubview(usernameField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(errorLabel)

        NSLayoutConstraint.activate([
            logoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),

            usernameField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            usernameField.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 40),
            usernameField.widthAnchor.constraint(equalToConstant: 280),

            passwordField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordField.topAnchor.constraint(equalTo: usernameField.bottomAnchor, constant: 16),
            passwordField.widthAnchor.constraint(equalToConstant: 280),

            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 24),
            loginButton.widthAnchor.constraint(equalToConstant: 280),
            loginButton.heightAnchor.constraint(equalToConstant: 48),

            errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16),
            errorLabel.widthAnchor.constraint(equalToConstant: 280),
        ])
    }

    // MARK: - Actions
    @objc func loginTapped() {
        let username = usernameField.text?.lowercased() ?? ""
        let password = passwordField.text ?? ""

        if username == "ash" && password == "pikachu" {
            errorLabel.text = " "
            if let tabBar = mainTabBar {
                navigationController?.pushViewController(tabBar, animated: true)
            }
        } else {
            errorLabel.text = "Invalid trainer Credentials"
        }
    }
}
