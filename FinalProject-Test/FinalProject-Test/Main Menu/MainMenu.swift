//
//  ViewController.swift
//  FinalProject-Test
//
//  Created by Михаил Зайцев on 06.04.2022.
//

import UIKit

final class MainMenu: UIViewController {
        
    private var collectionView: UICollectionView?
    private let standardSpacing: CGFloat = 16
    
    private let data = [
        MenuModel(testName: "Touch", testImage: UIImage(systemName: "scribble.variable")!,
                  viewController: TouchVC()),
        MenuModel(testName: "RGB", testImage: UIImage(systemName: "rectangle.split.3x1")!,
                  viewController: RGB_VC(RGB_View())),
        MenuModel(testName: "BWG", testImage: UIImage(systemName: "rectangle.split.3x1.fill")!,
                  viewController: BWG_VC(BWG_View())),
        MenuModel(testName: "Contrast", testImage: UIImage(systemName: "checkerboard.rectangle")!,
                  viewController: ContrastAndGammaVC(ContrastAndGammaView())),
        MenuModel(testName: "Main Speaker", testImage: UIImage(systemName: "speaker.wave.2.fill")!,
                  viewController: MainSpeakVC(MainSpeakView())),
        MenuModel(testName: "Front Speaker", testImage: UIImage(systemName: "iphone.homebutton.radiowaves.left.and.right")!,
                  viewController: FrontSpeakVC(FrontSpeakView())),
        MenuModel(testName: "Headphones", testImage: UIImage(systemName: "beats.earphones")!,
                  viewController: HeadphonesSpeakVC(HeadphonesSpeakView())),
        MenuModel(testName: "Wi-Fi", testImage: UIImage(systemName: "wifi")!,
                  viewController: WiFi_VC(StandartConnectionTestView())),
        MenuModel(testName: "Cellular", testImage: UIImage(systemName: "simcard.fill")!,
                  viewController: CellularVC(StandartConnectionTestView())),
        MenuModel(testName: "Bluetooth", testImage: UIImage(systemName: "airplayaudio")!,
                  viewController: BluetoothVC(StandartConnectionTestView())),
        MenuModel(testName: "Location", testImage: UIImage(systemName: "mappin.and.ellipse")!,
                  viewController: LocationVC(LocationView())),
        MenuModel(testName: "Camera", testImage: UIImage(systemName: "camera.fill")!,
                  viewController: PhotoVC(PhotoView())),
        MenuModel(testName: "Flash", testImage: UIImage(systemName: "flashlight.on.fill")!,
                  viewController: FlashVC(FlashView())),
        MenuModel(testName: "AmbiLight", testImage: UIImage(systemName: "light.max")!,
                  viewController: AmbientLightSensorVC(StandartSensorsTestView())),
        MenuModel(testName: "Accelerometer", testImage: UIImage(systemName: "iphone.homebutton.landscape")!,
                  viewController: AccelerVC(StandartSensorsTestView())),
        MenuModel(testName: "Distanсe", testImage: UIImage(systemName: "ruler.fill")!,
                  viewController: DistanсeVC(StandartSensorsTestView())),
        MenuModel(testName: "Authorization", testImage: UIImage(systemName: "faceid")!,
                  viewController: AuthorizationVC(AuthorizationView())),
        MenuModel(testName: "Compass", testImage: UIImage(systemName: "location.north.circle")!,
                  viewController: CompassVC())
                  ]

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configCollectionView()
//        collectionView?.register(HeaderCollectionReusableView.self,
//                                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
//                                 withReuseIdentifier: HeaderCollectionReusableView.identifier)

    }
}

extension MainMenu {
    private func configCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        layout.itemSize = CGSize(width: (view.frame.size.width/3)-standardSpacing, height: (view.frame.size.width/3)-standardSpacing)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        guard let collectionView = collectionView else { return }
        collectionView.register(MainMenuCollectionViewCell.self, forCellWithReuseIdentifier: MainMenuCollectionViewCell.identifier)
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
}

extension MainMenu: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainMenuCollectionViewCell.identifier, for: indexPath) as! MainMenuCollectionViewCell
        cell.configCell(label: "\(data[indexPath.row].testName)", image: data[indexPath.row].testImage)
    
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderCollectionReusableView.identifier, for: indexPath as IndexPath) as! HeaderCollectionReusableView
//        header.configure()
//
//        return header
//    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSelection selection: Int) -> CGSize {
//        return CGSize(width: view.frame.size.width-40, height: 60)
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected cell \(data[indexPath.row].testName)!")
        let newViewController = data[indexPath.row].viewController
        navigationController?.pushViewController(newViewController, animated: true)
    }
}
