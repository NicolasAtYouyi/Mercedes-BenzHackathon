//
//  BGActivityDetailViewController.swift
//  BenzGame
//
//  Created by wangyangyang on 16/9/4.
//  Copyright © 2016年 AndyVan. All rights reserved.
//

import UIKit

class BGActivityDetailViewController: UIViewController,DTAttributedTextContentViewDelegate, DTLazyImageViewDelegate{

    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var contentTextView: DTAttributedTextView!
    private var attributeTextOption: [String: AnyObject]!
    private let contentStr = "<p></p><p>试驾报名<em><strong>奔驰GLA系列</strong></em>。</p><p style=\"text-align: center; margin-bottom: 5px;\"><img alt=\"1.jpg\" src=\"http://dstatic.zuimeia.com/media/article/image/2016/6/6/c3082c67-0bfd-413c-8bfa-63c64b4e60a2_750x485.jpeg\" title=\"\"/></p><p style=\"text-align: center;\"><em><span style=\"font-size: 12px; color: rgb(165, 165, 165);\">奔驰GLA</span></em></p><p>有缩小版的S级迈巴赫之称的全新奔驰长轴距E级车正式公布了售价，先期推出的两款发动机六款车型价格区间在43.68万-49.98万。这个价格一公布，就有人大呼“厚道”。</p><p><img alt=\"2.jpg\" src=\"http://dstatic.zuimeia.com/media/article/image/2016/6/6/1f9c5769-585b-4774-8fc9-7d6edfdf4aa3_800x648.jpeg\" title=\"\"/></p><p><img alt=\"3.jpg\" src=\"http://dstatic.zuimeia.com/media/article/image/2016/6/6/24281162-211d-4b58-9e0b-b1688ae7627a_800x628.jpeg\" title=\"\"/></p><p><img alt=\"4.jpg\" src=\"http://dstatic.zuimeia.com/media/article/image/2016/6/6/29f796ae-a3ae-4a97-9fe6-3a5e4340e422_800x579.jpeg\" title=\"\"/></p><p>聊聊这款关注度极高的豪华C级车之前，先带你们感受下上市发布会的现场，绝对能晃瞎双眼。</p><p><img alt=\"5-1.jpg\" src=\"http://dstatic.zuimeia.com/media/article/image/2016/6/6/4fd13a3a-beee-47bb-aa5c-9aa23768c1eb_640x360.jpeg\" title=\"\"/></p><p style=\"margin-bottom: 5px; text-align: center;\"><img alt=\"5.jpg\" src=\"http://dstatic.zuimeia.com/media/article/image/2016/6/6/f9329983-087b-4242-bd64-4e35e9b3259c_800x426.jpeg\" title=\"\"/></p><p style=\"text-align: center;\"><span style=\"font-size: 12px; color: rgb(165, 165, 165);\">GLA系列</span></p><p>首先这款重磅车型放在北京科技大学，就很直白的告诉你了，科技是它的最大卖点之一。进到会场，经历无数发布会的兔某就晕了，各种眼花缭乱的布景。</p><p><img alt=\"6.jpg\" src=\"http://dstatic.zuimeia.com/media/article/image/2016/6/6/3d6d0a1a-1078-42c5-aaaa-cf79f764f112_800x498.jpeg\" title=\"\"/></p><p>机器人也是无处不在。而等到发布会开始，在场的每位朋友都领到了一副3D眼镜，观看了一场极为酷炫的开场大片，碍于这个效果没法用照相机体现，大家只能自行脑补了。</p><p><img alt=\"B97061F5-44BB-44C8-85CB-72565D96BD31.png\" src=\"http://dstatic.zuimeia.com/media/article/image/2016/6/6/0561afd3-e11c-48a3-b6f2-151b8505ee17_595x446.png\" title=\"\"/></p><p>其实这款车之前已经和大家见过两次面了，在4月24日北京车展前夜的全球首发仪式上，可是有戴姆勒股份公司董事会主席、梅赛德斯-奔驰汽车集团全球总裁蔡澈博士站台的。</p><p><strong>全新长轴距E级车之所以被称为中号“S”级，就是它的家族化设计风格。</strong></p><p><img alt=\"9.jpg\" src=\"http://dstatic.zuimeia.com/media/article/image/2016/6/6/2520d882-f7f0-47b5-a85e-7621a73e0410_800x800.jpeg\" title=\"\"/></p><p><strong>经典车型</strong>2</p><p>比如经典的百叶窗进气格栅搭配星徽立标，以及双横幅进气格栅搭配星徽盾标两种不同的造型风格，都能找到很多S级的影子，这也是它最吸引消费者的一大卖点。 </p><p><img alt=\"10.jpg\" src=\"http://dstatic.zuimeia.com/media/article/image/2016/6/6/662c8daa-b1e7-44b0-8c73-386806a677d5_800x423.jpeg\" title=\"\"/></p>"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        titleView.backgroundColor = UIColor.init(hexStr: kMainBkgColorStr)
        
//        contentTextView.shouldDrawImages = false;
//        contentTextView.shouldDrawLinks = false;
        contentTextView.textDelegate = self
//        contentTextView.scrollEnabled = true
//        contentTextView.scrollsToTop = false
//        contentTextView.attributedTextContentView.edgeInsets = UIEdgeInsetsMake(0.0, 20.0 , 0.0, 20.0);
        
        setAttributeContentStr(contentStr)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func backBtnAction(sender: UIButton) {
        if navigationController != nil {
            navigationController?.popViewControllerAnimated(true)
        } else {
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    
    //MARK: Handle ContentStr Method
    private func rebuildImageSize(contentStr: String) -> String {
        
        var rebuildStr = String.init(format: "%@", arguments: [contentStr])
        
        //寻找图片标签
        let pattern = "<img [^>]*>"
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions.CaseInsensitive)
            let range = NSMakeRange(0, contentStr.characters.count)
            let arr = regex.matchesInString(contentStr, options: NSMatchingOptions(rawValue: 0), range:range)
            for result in arr.reverse(){
                //图片标签中是否已经包含「宽高」标签
                let s = (contentStr as NSString).substringWithRange(result.range)
                let w = s.containsString("width")
                let h = s.containsString("height")
                if !w && !h {
                    let patternSize = "_.*x.*."
                    let regularSize = try NSRegularExpression(pattern: patternSize, options: NSRegularExpressionOptions.CaseInsensitive)
                    let arr = regularSize.matchesInString(s as String, options: NSMatchingOptions(rawValue: 0), range:NSMakeRange(0, s.characters.count))
                    for sizeResult in arr {
                        let p = (s as NSString).substringWithRange(sizeResult.range) as NSString
                        
                        let firstRange = p.rangeOfString("x")
                        let twoRange = p.rangeOfString(".")
                        let width = p.substringWithRange(NSMakeRange(1, firstRange.location - 1))
                        let height = p.substringWithRange(NSMakeRange(firstRange.location + firstRange.length, twoRange.location - firstRange.location - firstRange.length))
                        let pSize = p.stringByReplacingOccurrencesOfString("/>", withString: "style=\"width:\(width)px;height:\(height)px\"/>")
                        rebuildStr = rebuildStr.stringByReplacingOccurrencesOfString(p as String, withString: pSize)
                    }
                }
            }
        } catch {
        }
        return rebuildStr
    }
    
    private func rebuildContentStr(contentStr: String) -> String {
        var mStr = NSMutableString(string: contentStr)
        let pattern = "/><img"
        do {
            let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions.CaseInsensitive)
            let range = NSMakeRange(0, contentStr.characters.count)
            let arr = regex.matchesInString(contentStr, options: NSMatchingOptions(rawValue: 0), range:range)
            for result in arr.reverse(){
                //图片标签中是否已经包含「p」标签
                let s = (contentStr as NSString).substringWithRange(result.range)
                let pS = s.stringByReplacingOccurrencesOfString("/>", withString: "/></p><p>")
                
                let a = mStr.stringByReplacingOccurrencesOfString(s, withString: pS)
                mStr = NSMutableString(string: a)
            }
        } catch {}
        
        return mStr as String
    }
    
    private func reloadContentStr(contentStr: String) -> String {
        var str = rebuildImageSize(contentStr)
        str = rebuildContentStr(str)
        let r: CGFloat = 0.0, g: CGFloat = 0.0, b: CGFloat = 0.0, a: CGFloat = 0.9
        var html = String(format: "<div style=\"font-size:%fpx; color:rgba(%f,%f,%f,%f); line-height:24px; height=20px;\">", arguments: [17.0,r,g,b,a])
        html += str
        html += "</div>"
        return html
    }
    
    private func setAttributeContentStr(str: String) {
        let contentStr = reloadContentStr(str)
        if attributeTextOption == nil {
            attributeTextOption = [:]
            
            attributeTextOption[NSTextSizeMultiplierDocumentOption] = (1.0)
            
            let maxImageSize = CGSizeMake(UIScreen.mainScreen().bounds.size.width - 20.0 * 2, CGFloat.max)
            attributeTextOption[DTMaxImageSize] = NSValue(CGSize: maxImageSize)
            
            attributeTextOption[DTDefaultFontFamily] = kFontName
            attributeTextOption[DTDefaultFontName] = kFontName
            attributeTextOption[DTDefaultLinkColor] = "rgba(40,159,206,1)"
            attributeTextOption[DTDefaultLinkHighlightColor] = "purple"
            attributeTextOption[DTDefaultLinkDecoration] = (0)
        }
        let attStr = NSAttributedString(HTMLData: contentStr.dataUsingEncoding(NSUTF8StringEncoding)!, options: attributeTextOption, documentAttributes: nil)
        contentTextView.alpha = 0.0
        contentTextView.attributedString = attStr
        UIView.animateWithDuration(0.3, delay: 0.2, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
            self.contentTextView.alpha = 1.0
            }, completion: nil)
    }

    //MARK: DTAttributedTextContentViewDelegate
    func attributedTextContentView(attributedTextContentView: DTAttributedTextContentView!, viewForAttributedString string: NSAttributedString!, frame: CGRect) -> UIView! {
        
        let attributes = string.attributesAtIndex(0, effectiveRange: nil)
        let URL = attributes[DTLinkAttribute] as? NSURL
        let identifier = attributes[DTGUIDAttribute] as? String
        
        let button = DTLinkButton(frame: frame)
        button.URL = URL;
        button.minimumHitSize = CGSizeMake(25, 25); // adjusts it's bounds so that button is always large enough
        button.GUID = identifier;
        
        // get image with normal link text
        let normalImage = attributedTextContentView.contentImageWithBounds(frame, options: DTCoreTextLayoutFrameDrawingOptions.Default)
        button.setImage(normalImage, forState: UIControlState.Normal)
        
        // get image for highlighted link text
        let highlightImage = attributedTextContentView.contentImageWithBounds(frame, options: DTCoreTextLayoutFrameDrawingOptions.DrawLinksHighlighted)
        button.setImage(highlightImage, forState: UIControlState.Highlighted)
        return button;
    }
    
    
    private var imgCount:Int = 0
    func attributedTextContentView(attributedTextContentView: DTAttributedTextContentView!, viewForAttachment attachment: DTTextAttachment!, frame: CGRect) -> UIView! {
        if attachment.isKindOfClass(DTImageTextAttachment.self){
            let v = UIView(frame: frame)
            v.backgroundColor = contentTextView.backgroundColor
            
            let imageView = UIImageView(frame: CGRectMake(0.0, 0.0, frame.size.width, frame.size.height))
            imageView.backgroundColor = contentTextView.backgroundColor;
            imageView.contentMode = UIViewContentMode.ScaleAspectFit;
            imageView.clipsToBounds = true
            imageView.center = CGPointMake(view.frame.size.width / 2 - frame.origin.x, imageView.center.y);
//            imageView.sd_setImageWithURL(attachment.contentURL, placeholderImage: nil)
            let s = String.init(format: "shop_%d.jpeg", imgCount % 3 + 1);
            imageView.image = UIImage.init(named: s)
            imgCount += 1
            v.addSubview(imageView)
            return v;
        }
        return nil
    }


}
