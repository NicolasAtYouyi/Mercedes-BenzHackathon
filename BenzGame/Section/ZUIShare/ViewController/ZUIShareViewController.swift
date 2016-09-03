//
//  ZUIShareViewController.swift
//  ZUIVogue
//
//  Created by wangyangyang on 16/6/15.
//  Copyright © 2016年 ___ZUI___. All rights reserved.
//

import UIKit

protocol ZUIShareViewControllerDelegate:NSObjectProtocol {
    func clickShareControllerBtn(title:String,finishBlock:(isSuccess:Bool,isCancel:Bool,err:NSError?) -> Void)
}

class ZUIShareViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    @IBOutlet weak var containerViewAspectConstraint: NSLayoutConstraint!
    @IBOutlet weak var containerViewLeaderConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLabelTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var collectionViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var collectionViewAspectConstraint: NSLayoutConstraint!
    private let ZUIScreenBounds = UIScreen.mainScreen().bounds
    
    
    private var arr:[[String: String]] {
        get {
            if showCollection {
               return  [["ImageName":"shareicon_weixin","Title":"微信好友"],["ImageName":"share_moments","Title":"微信朋友圈"],["ImageName":"shareicon_sina","Title":"新浪微博"],["ImageName":"share_qq","Title":"QQ好友"],["ImageName":"share_qzone","Title":"QQ空间"],["ImageName":"share_more","Title":"更多分享"],["ImageName":"collection_normal","Title":"收藏"],["ImageName":"share_copylink","Title":"复制链接"]]
            } else {
               return [["ImageName":"shareicon_weixin","Title":"微信好友"],["ImageName":"share_moments","Title":"微信朋友圈"],["ImageName":"shareicon_sina","Title":"新浪微博"],["ImageName":"share_qq","Title":"QQ好友"],["ImageName":"share_qzone","Title":"QQ空间"],["ImageName":"share_more","Title":"更多分享"]]
            }
        }
        set {}
    }

//    let arr = [["ImageName":"shareicon_weixin","Title":"微信好友"],["ImageName":"share_moments","Title":"微信朋友圈"],["ImageName":"shareicon_sina","Title":"新浪微博"],["ImageName":"share_qq","Title":"QQ好友"],["ImageName":"share_qzone","Title":"QQ空间"],["ImageName":"share_more","Title":"更多分享"],["ImageName":"collection_normal","Title":"收藏"],["ImageName":"share_copylink","Title":"复制链接"]]
    
    var isMarked:Bool = false
    var showCollection = true //是否显示收藏，如果只是单纯的分享，则不需要显示收藏
    weak var delegate:ZUIShareViewControllerDelegate?
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        let constant = ceil(48 * min(ZUIScreenBounds.size.width,375.0)/375.0)
        collectionViewLeadingConstraint.constant = constant
        collectionViewTrailingConstraint.constant = constant
        collectionViewBottomConstraint.constant = constant
        
        let titleTopConstant = ((ZUIScreenBounds.size.width - 2 * containerViewLeaderConstraint.constant)/containerViewAspectConstraint.multiplier - ((ZUIScreenBounds.size.width - 2 * containerViewLeaderConstraint.constant - 2 * constant)/collectionViewAspectConstraint.multiplier + constant) - 18.0)/2.0
        titleLabelTopConstraint.constant = titleTopConstant
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupCollectionView()
        setupTapGes()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func setupCollectionView() {
        let constant = ceil(48 * min(ZUIScreenBounds.size.width,375.0)/375.0)

        let cellWidth:CGFloat = ceil((ZUIScreenBounds.size.width - 2 * containerViewLeaderConstraint.constant) * 76.0/348.0)
        let cellHeight:CGFloat = ceil(cellWidth/(76.0/91.0))
        
        flowLayout.itemSize = CGSizeMake(cellWidth,cellHeight)
        
        let collectionViewWidth = ceil(ZUIScreenBounds.size.width - 2 * containerViewLeaderConstraint.constant - constant * 2)
        let collectionViewHeight = ceil(collectionViewWidth/collectionViewAspectConstraint.multiplier)
        
        flowLayout.minimumLineSpacing = (collectionViewHeight - cellHeight * 3) / 2.0
        flowLayout.minimumInteritemSpacing = (collectionViewWidth - cellWidth * 3)/2.0
        
        collectionView.registerNib(UINib(nibName: "ZUIShareCollectionViewCell", bundle: nil),forCellWithReuseIdentifier: ZUIShareCollectionViewCellID)
        
        collectionView.scrollEnabled = false
    }
    
    func setupTapGes(){
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.handlePageViewTap(_:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
        tapGestureRecognizer.numberOfTouchesRequired = 1
        
        backgroundView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func handlePageViewTap(tages:UITapGestureRecognizer){
        dismissViewControllerAnimated(true, completion: nil)
    }

    // MARK: Delegate Methods
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let dic = arr[indexPath.row]
        let title = dic["Title"]
        if delegate != nil{
            delegate?.clickShareControllerBtn(title!, finishBlock: {[weak self] (isSuccess, isCancel, err) in
                if let _self = self {
                    if title == "收藏" || title == "已收藏" {
                        if isSuccess {
                            _self.isMarked = !isCancel
                            _self.collectionView.reloadItemsAtIndexPaths([NSIndexPath.init(forRow: indexPath.row, inSection: indexPath.section)])
                        }
                    }
                }
            })
        }
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arr.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(ZUIShareCollectionViewCellID, forIndexPath: indexPath) as! ZUIShareCollectionViewCell
        let item = arr[indexPath.row]
        cell.titleLabel.text = item["Title"]
//        cell.imageView.image = UIImage.init(named: item["ImageName"]!)
        cell.imageButton.setImage(UIImage.init(named: item["ImageName"]!), forState: .Normal)
        cell.titleLabel.font = UIFont.init(name: kFontName, size: 13.0/76.0 * cell.bounds.size.width)
        cell.imageButton.addTarget(self, action: #selector(self.clickShareBtn(_:)), forControlEvents: .TouchUpInside)
        cell.imageButton.tag = indexPath.row
        
        if cell.titleLabel.text == "收藏" || cell.titleLabel.text == "已收藏" {
            if isMarked {
//                cell.imageView.image = UIImage.init(named: "collection_pressed")
                cell.imageButton.setImage(UIImage.init(named: "collection_pressed"), forState: .Normal)
                cell.titleLabel.text = "已收藏"
            } else {
                cell.titleLabel.text = "收藏"                
            }
        }
        
        return cell
    }
    
    func clickShareBtn(button:UIButton){
        self.collectionView(collectionView,didSelectItemAtIndexPath: NSIndexPath.init(forRow: button.tag, inSection: 0))
    }

}
