import ProjectDescription
import ProjectDescriptionHelpers
import MyPlugin

// Local plugin loaded
let localHelper = LocalHelper(name: "MyPlugin")

// MARK: - Project String Data
enum Ticlemoa: String {
	static let projectName = "Ticlemoa"
	static let productName = "Ticlemoa"
	static let organizationName = "nyongnyong"
	static let bundleId = "com.nyongnyong"
	static let deploymentTarget = DeploymentTarget
		.iOS(targetVersion: "16.0", devices: [.iphone])
	
	case userInterface = "UserInterface"
	case domain = "Domain"
	case api = "API"
	case share = "ShareExtension"
	
	var name: String { self.rawValue }
	var product: Product {
		switch self {
		case .userInterface:	return .framework
		case .domain:			return .framework
		case .api:			return .framework
		case .share:			return .appExtension
		}
	}
}

// MARK: - Module
func makeModule(_ module: Ticlemoa,
				infoPlist: InfoPlist? = nil,
				dependencies: [TargetDependency],
				hasTest: Bool
) -> [Target] {
	let sources = Target(
		name: module.name,
		platform: .iOS,
		product: module.product,
		bundleId: "\(Ticlemoa.bundleId).\(Ticlemoa.projectName)",
		deploymentTarget: Ticlemoa.deploymentTarget,
		infoPlist: infoPlist ?? .default,
		sources: ["Targets/\(module.name)/Sources/**"],
		resources: ["Targets/\(module.name)/Resources/**"],
		dependencies: dependencies
	)
	if hasTest {
		let tests = Target(
			name: "\(module.name)Tests",
			platform: .iOS,
			product: .unitTests,
			bundleId: "\(Ticlemoa.bundleId).DomainTests",
			deploymentTarget: Ticlemoa.deploymentTarget,
			infoPlist: .default,
			sources: ["Targets/\(module.name)/Tests/**"],
			resources: [],
			dependencies: [
				.target(name: "\(module.name)")
			]
		)
		return [sources, tests]
	} else {
		return [sources]
	}
}

// MARK: - Module

let shareInfoPlist: InfoPlist = .extendingDefault(with: [
		"CFBundleDisplayName": "\(Ticlemoa.productName)",
		"CFBundleShortVersionString": "1.0.0",
		"NSExtension": [
			"NSExtensionAttributes": [
				"NSExtensionActivationSupportsText": true
			],
			"NSExtensionMainStoryboard": "MainInterface",
			"NSExtensionPointIdentifier": "com.apple.share-services"
		]
	]
)

let userInterface = makeModule(
	.userInterface,
	dependencies: [
		.external(name: "KakaoSDK"),
		.external(name: "Collections")
	],
	hasTest: true
)
let api = makeModule(
	.api,
	dependencies: [],
	hasTest: true
)
let domain = makeModule(
	.domain,
	dependencies: [
		.target(name: Ticlemoa.api.name)
	],
	hasTest: true
)
let share = makeModule(
	.share,
	infoPlist: shareInfoPlist,
	dependencies: [],
	hasTest: false
)


// MARK: - Project

let infoPlist: InfoPlist = .extendingDefault(with: [
		"CFBundleShortVersionString": "1.0.0",
		"CFBundleVersion": "1",
		"UIMainStoryboardFile": "",
		"UISupportedInterfaceOrientations" : ["UIInterfaceOrientationPortrait"],
		"UILaunchStoryboardName": "LaunchScreen",
        "LSApplicationQueriesSchemes" : [
            "kakaokompassauth",
            "kakaolink"
        ]
	]
)

let mainAppTarget = [
	Target.init(
		name: Ticlemoa.projectName,
		platform: .iOS,
		product: .app,
		productName: Ticlemoa.productName,
		bundleId: "\(Ticlemoa.bundleId).\(Ticlemoa.projectName)",
		deploymentTarget: Ticlemoa.deploymentTarget,
		infoPlist: infoPlist,
		sources: ["Targets/\(Ticlemoa.projectName)/Sources/**"],
		resources: ["Targets/\(Ticlemoa.projectName)/Resources/**"],
		dependencies: [
			.target(name: Ticlemoa.userInterface.name),
			.target(name: Ticlemoa.domain.name),
            .target(name: Ticlemoa.share.name)
		]
	),
	Target.init(
		name: "\(Ticlemoa.projectName)Tests",
		platform: .iOS,
		product: .unitTests,
		bundleId: "\(Ticlemoa.bundleId).\(Ticlemoa.projectName)Tests",
		deploymentTarget: Ticlemoa.deploymentTarget,
		infoPlist: .default,
		sources: ["Targets/\(Ticlemoa.projectName)/Tests/**"],
		scripts: [],
		dependencies: [
			.target(name: Ticlemoa.projectName),
		],
		settings: nil,
		coreDataModels: [],
		environment: [:],
		launchArguments: [],
		additionalFiles: []
	)
]

let project = Project.init(
	name: Ticlemoa.projectName,
	organizationName: Ticlemoa.organizationName,
	targets: [
		mainAppTarget,
		userInterface,
		domain,
		api,
		share
	].flatMap { $0 }
)
