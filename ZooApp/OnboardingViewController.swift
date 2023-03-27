import UIKit

class OnboardingViewController: UIViewController {
    @IBOutlet weak var pageControlOnboarding: UIPageControl!
    @IBOutlet weak var collectionViewOnboarding: UICollectionView!
    
    var slides = [OnboardingSlide]()
    var currentPage = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        jsonFileRead()
 }
    
    func jsonFileRead() {
        if let jsonFile = Bundle.main.url(forResource: "zooApp", withExtension: "json") {
            let data = (try? Data(contentsOf: jsonFile))!
            do {
                slides = try JSONDecoder().decode([OnboardingSlide].self, from: data)
                collectionViewOnboarding.reloadData()
            } catch {
                print(error.localizedDescription)
            }
            print(jsonFile)
        }
    }
    
    @IBAction func skipOnboardingButton(_ sender: Any) {
//        let vc = storyboard?.instantiateViewController(withIdentifier: "tabbar")
//        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabbar") as! UITabBarController
       // navigationController?.show(vc, sender: nil)
//        vc?.modalPresentationStyle = .fullScreen
//        present(vc!, animated: true)
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = scene.delegate as? SceneDelegate{
            sceneDelegate.setOnboardingRootController(windowScene: scene)
            UserDefaults.standard.set(true, forKey: "onboarded")
        }
    }
    
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCellCollectionViewCell", for: indexPath) as! OnboardingCellCollectionViewCell
        cell.textSlider.text = slides[indexPath.item].text
        cell.titleSlider.text = slides[indexPath.item].title
        cell.imgSlider.image = UIImage(named: slides[indexPath.item].image ?? "" ) 
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! OnboardingCellCollectionViewCell
//        cell.setup(slides[indexPath.row])
      return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return  CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
        pageControlOnboarding.currentPage = currentPage
        
    }
}
