//
//  TestMenu.swift
//  FinalProject-Test
//
//  Created by Михаил Зайцев on 06.04.2022.
//

import UIKit

final class TestMenu: UIViewController {
        
    private var collectionView: UICollectionView?
    private let standardSpacing: CGFloat = 16
    
    private let data = [
        TestModel(testName: "Touch",
                  testImage: UIImage(systemName: "scribble.variable")!),
        TestModel(testName: "RGB",
                  testImage: UIImage(systemName: "rectangle.split.3x1")!),
        TestModel(testName: "BWG",
                  testImage: UIImage(systemName: "rectangle.split.3x1.fill")!),
        TestModel(testName: "Contrast",
                  testImage: UIImage(systemName: "checkerboard.rectangle")!),
        TestModel(testName: "Main Speaker",
                  testImage: UIImage(systemName: "speaker.wave.2.fill")!),
        TestModel(testName: "Front Speaker",
                  testImage: UIImage(systemName: "iphone.homebutton.radiowaves.left.and.right")!),
        TestModel(testName: "Headphones",
                  testImage: UIImage(systemName: "beats.earphones")!),
        TestModel(testName: "Wi-Fi",
                  testImage: UIImage(systemName: "wifi")!),
        TestModel(testName: "Cellular",
                  testImage: UIImage(systemName: "simcard.fill")!),
        TestModel(testName: "Bluetooth",
                  testImage: UIImage(systemName: "airplayaudio")!),
        TestModel(testName: "Location",
                  testImage: UIImage(systemName: "mappin.and.ellipse")!),
        TestModel(testName: "Camera",
                  testImage: UIImage(systemName: "camera.fill")!),
        TestModel(testName: "Flash",
                  testImage: UIImage(systemName: "flashlight.on.fill")!),
        TestModel(testName: "AmbiLight",
                  testImage: UIImage(systemName: "light.max")!),
        TestModel(testName: "Accelerometer",
                  testImage: UIImage(systemName: "iphone.homebutton.landscape")!),
        TestModel(testName: "Distanсe",
                  testImage: UIImage(systemName: "ruler.fill")!),
        TestModel(testName: "Authorization",
                  testImage: UIImage(systemName: "faceid")!),
        TestModel(testName: "Compass",
                  testImage: UIImage(systemName: "location.north.circle")!)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configCollectionView()
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Mega Test"
    }
}

extension TestMenu {
    private func configCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.itemSize = CGSize(width: (view.frame.size.width/3)-standardSpacing, height: (view.frame.size.width/3)-standardSpacing)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        guard let collectionView = collectionView else { return }
        collectionView.register(TestMenuCollectionViewCell.self, forCellWithReuseIdentifier: TestMenuCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: standardSpacing),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -standardSpacing),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    private func newVC(viewController: UIViewController) {
        let newViewController = viewController
        newViewController.modalPresentationStyle = .fullScreen
        present(newViewController, animated: true, completion: nil)
    }
}

extension TestMenu: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TestMenuCollectionViewCell.identifier, for: indexPath) as! TestMenuCollectionViewCell
        cell.configCell(label: "\(data[indexPath.row].testName)", image: data[indexPath.row].testImage)
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected cell \(data[indexPath.row].testName)!")
        
        let route = routeVC.init(rawValue: indexPath.row)
        switch route {
        case .touch:
            newVC(viewController: TouchVC(CanvasTouch()))
        case .rgb:
            newVC(viewController: RGB_VC(RGB_View()))
        case .bwg:
            newVC(viewController: BWG_VC(BWG_View()))
        case .contrast:
            newVC(viewController: ContrastAndGammaVC())//ContrastAndGammaVC(ViewController()))
        case .mainSpeaker:
            newVC(viewController: MainSpeakVC(MainSpeakView()))
        case .frontSpeaker:
            newVC(viewController: FrontSpeakVC(FrontSpeakView()))
        case .headphones:
            newVC(viewController: HeadphonesSpeakVC(HeadphonesSpeakView()))
        case .wifi:
            newVC(viewController: WiFi_VC(StandartConnectionTestView()))
        case .cellular:
            newVC(viewController: CellularVC(StandartConnectionTestView()))
        case .bluetooth:
            newVC(viewController: BluetoothVC(StandartConnectionTestView()))
        case .location:
            newVC(viewController: LocationVC(LocationView()))
        case .camera:
            newVC(viewController: PhotoVC(PhotoView()))
        case .flash:
            newVC(viewController: FlashVC(FlashView()))
        case .ambiLight:
            newVC(viewController: AmbientLightSensorVC(StandartSensorsTestView()))
        case .accelerometer:
            newVC(viewController: AccelerVC(StandartSensorsTestView()))
        case .distanсe:
            newVC(viewController: DistanсeVC(StandartSensorsTestView()))
        case .authorization:
            newVC(viewController: AuthorizationVC(AuthorizationView()))
        case .compass:
            newVC(viewController: CompassVC())
        case .none:
            print("none")
        }
    }
}
