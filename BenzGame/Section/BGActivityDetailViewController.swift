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
    private let contentStr = "<p>试驾报名<em><strong>奔驰GLA系列</strong></em>。</p><p style=\"text-align: center; margin-bottom: 5px;\"><img alt=\"1.jpg\" src=\"http://dstatic.zuimeia.com/media/article/image/2016/6/6/c3082c67-0bfd-413c-8bfa-63c64b4e60a2_750x485.jpeg\" title=\"\"/></p><p style=\"text-align: center;\"><em><span style=\"font-size: 12px; color: rgb(165, 165, 165);\">奔驰GLA</span></em></p><p>说他是骨灰级文艺男青年，大概没人能有意见。</p><p>除了是日本时尚界教父一般的存在，除了是西方人津津乐道的日本设计大师，他还不止一次被国外的报刊杂志评为<strong>「最性感的日本男人」</strong>。 </p><p><img alt=\"2.jpg\" src=\"http://dstatic.zuimeia.com/media/article/image/2016/6/6/1f9c5769-585b-4774-8fc9-7d6edfdf4aa3_800x648.jpeg\" title=\"\"/></p><p><img alt=\"3.jpg\" src=\"http://dstatic.zuimeia.com/media/article/image/2016/6/6/24281162-211d-4b58-9e0b-b1688ae7627a_800x628.jpeg\" title=\"\"/></p><p><img alt=\"4.jpg\" src=\"http://dstatic.zuimeia.com/media/article/image/2016/6/6/29f796ae-a3ae-4a97-9fe6-3a5e4340e422_800x579.jpeg\" title=\"\"/></p><p>看年轻时候的照片，也都是拽得不行：</p><p><img alt=\"5-1.jpg\" src=\"http://dstatic.zuimeia.com/media/article/image/2016/6/6/4fd13a3a-beee-47bb-aa5c-9aa23768c1eb_640x360.jpeg\" title=\"\"/></p><p style=\"margin-bottom: 5px; text-align: center;\"><img alt=\"5.jpg\" src=\"http://dstatic.zuimeia.com/media/article/image/2016/6/6/f9329983-087b-4242-bd64-4e35e9b3259c_800x426.jpeg\" title=\"\"/></p><p style=\"text-align: center;\"><span style=\"font-size: 12px; color: rgb(165, 165, 165);\">山本耀司</span></p><p>他当然不是那种宣称「每个女人都有其可爱之处」的男人，他曾在一次访谈中说过这样一段话：</p><p><strong>「通常，我的顾客都不用自己付钱，都是她们的伴侣帮忙结账，所以我总是在心里大喊：Bitch，我不能忍受为这种女人设计衣服。」</strong></p><p>这么不热爱妇女的话，除了他也没几个人能说得这么理所当然了。</p><p><img alt=\"6.jpg\" src=\"http://dstatic.zuimeia.com/media/article/image/2016/6/6/3d6d0a1a-1078-42c5-aaaa-cf79f764f112_800x498.jpeg\" title=\"\"/></p><p>这样目下无尘的骨灰级文艺男青年，心中也有倾慕的女人吗？</p><p>这几乎是肯定的，男人也许能没有女神，但是设计师不能没有缪斯。</p><p><img alt=\"B97061F5-44BB-44C8-85CB-72565D96BD31.png\" src=\"http://dstatic.zuimeia.com/media/article/image/2016/6/6/0561afd3-e11c-48a3-b6f2-151b8505ee17_595x446.png\" title=\"\"/></p><p>当被问到「设计的时候，有没有具体的女性形象」，山本耀司这么回答:</p><p><strong>脸微微转向一边，吸着烟，头发随风飘起。不是日本女子。她用沙哑的嗓音说：「我呢，放弃了做女人。」这是我心中的缪斯。</strong></p><p><img alt=\"8.jpg\" src=\"http://dstatic.zuimeia.com/media/article/image/2016/6/6/b2990c72-8a50-43d2-bec7-e1aaef9ca678_800x800.jpeg\" title=\"\"/></p><p>这说的是谁呢，似乎并不明确的形象啊，那再来看看这段更直接的表白吧：</p><p><strong>我之前提出过「为什么样的女性制作衣服？」这样的问题，也回答过「为了现实中不存在的理想的女性做衣服」。但自从遇到她之后，就开始回答「为了皮娜」。</strong></p><p><img alt=\"9.jpg\" src=\"http://dstatic.zuimeia.com/media/article/image/2016/6/6/2520d882-f7f0-47b5-a85e-7621a73e0410_800x800.jpeg\" title=\"\"/></p><p><strong>皮娜·鲍什</strong>，德国现代舞的第一夫人。</p><p>她的作品，像她自己，一个永远在抗争的悲伤又充满力量的女人。 </p><p><img alt=\"10.jpg\" src=\"http://dstatic.zuimeia.com/media/article/image/2016/6/6/662c8daa-b1e7-44b0-8c73-386806a677d5_800x423.jpeg\" title=\"\"/></p><p>山本耀司和她相识二十多年，隔了很久回忆起第一次观看皮娜舞蹈：</p><p><strong>「我完全被这种充满爆发力且远远超越现代舞框架的刚柔并济的表演所震撼。」</strong></p><p><img alt=\"11.jpg\" src=\"http://dstatic.zuimeia.com/media/article/image/2016/6/6/5a14b169-a9a2-4d9f-bc62-0959059c5013_800x532.jpeg\" title=\"\"/></p><p>是什么样的舞蹈，让山本耀司震撼？</p><p>在西班牙导演大师阿莫多瓦的《对她说》开头，男主角观看了皮娜著名舞蹈《穆勒咖啡屋》中的一段： </p><p><img alt=\"12-1.jpg\" src=\"http://dstatic.zuimeia.com/media/article/image/2016/6/6/5a6a7bef-7fae-49c1-a713-5f84ccfd3861_640x426.jpeg\" title=\"\"/></p><p><img alt=\"12-2.jpg\" src=\"http://dstatic.zuimeia.com/media/article/image/2016/6/6/db82d4a8-0162-43d7-a752-f8eae410ae8a_640x426.jpeg\" title=\"\"/></p><p><img alt=\"12-3.jpg\" src=\"http://dstatic.zuimeia.com/media/article/image/2016/6/6/1290bd00-6aee-45c1-8f23-fffb2ce90408_640x425.jpeg\" title=\"\"/></p><p><img alt=\"12-4.jpg\" src=\"http://dstatic.zuimeia.com/media/article/image/2016/6/6/7f44eb9b-c872-4f10-b1cb-dcd00d897caf_597x396.jpeg\" title=\"\"/></p><p><img alt=\"12-5.jpg\" src=\"http://dstatic.zuimeia.com/media/article/image/2016/6/6/ef4f7091-748e-482d-8e54-284ba6cb6bf5_598x397.jpeg\" title=\"\"/></p><p><img alt=\"12-6.jpg\" src=\"http://dstatic.zuimeia.com/media/article/image/2016/6/6/8a77fe00-7e5e-47e8-953a-a127615bec78_619x374.jpeg\" title=\"\"/></p><p>后来男主角对失去意识的女主角这样讲述这次舞蹈：</p><p>「舞台上摆满了木头桌椅，然后出来两个穿着睡衣的女人，闭着眼，就像在梦游，真让人担心她们会撞上去，突然，出现了一个男人，面带悲伤，算是我见过最忧伤的一张脸了，他把那些桌椅都搬走了，免得她们磕着碰着。<strong>我无法形容那是多么的感人，我旁边坐着一个四十多岁的男人，挺帅的，他感动得好几次留下了眼泪。不过确实如此，太感人了。</strong>」</p><p><img alt=\"13.jpg\" src=\"http://dstatic.zuimeia.com/media/article/image/2016/6/6/1ab702a0-4838-4b9c-b5ce-67243e1b5e73_800x542.jpeg\" title=\"\"/></p><p>男主角还为失去意识无法再跳舞的女主角要来了皮娜的签名：</p><p><strong>「在</strong><strong>妳</strong><strong>克服一切困难之后，就再跳舞吧。」</strong></p><p><img alt=\"14.jpg\" src=\"http://dstatic.zuimeia.com/media/article/image/2016/6/6/65eac074-9c9d-422d-9585-31c28891b905_800x588.jpeg\" title=\"\"/></p><p>从相识起，山本耀司和皮娜维系了长达二十多年的友情，<strong>两人是随时可以让对方做些什么的关系。</strong></p><p>皮娜的舞团成立二十五周年，皮娜邀请山本为舞团的纪念带来些什么，还在宣传手册上写上「Pina asked something to Yohji（皮娜要求耀司为她做点什么）」，于是纪念晚会当晚，山本为皮娜筹备了一场时装秀，最后自己还登台表演了一段空手道。 </p><p><img alt=\"15.jpg\" src=\"http://dstatic.zuimeia.com/media/article/image/2016/6/6/4b138bf5-e036-4604-ac7e-02c118d51c09_800x590.jpeg\" title=\"\"/></p><p><img alt=\"16.jpg\" src=\"http://dstatic.zuimeia.com/media/article/image/2016/6/6/7019845f-bb9f-4ee7-a4be-56a8a6b6bdc2_800x800.jpeg\" title=\"\"/></p><p>而他对皮娜唯一的请求只是：<strong>「我给妳做一套衣服，皮娜妳可以穿上它跳一段舞吗？」</strong></p><p><img alt=\"17.jpg\" src=\"http://dstatic.zuimeia.com/media/article/image/2016/6/6/ae1944ef-af3a-4aca-b190-9aef4de685e2_800x1233.jpeg\" title=\"\"/></p><p><img alt=\"18.jpg\" src=\"http://dstatic.zuimeia.com/media/article/image/2016/6/6/cf82ded9-fecc-4863-bb16-593d2096f0de_800x1172.jpeg\" title=\"\"/></p><p>皮娜曾说：<strong>「我随时可以出席耀司的时装秀。」</strong>可这一直没有实现。</p><p>2009 年皮娜癌症去世，耀司提及这一段，说：<strong>「让这样一个个性鲜明、超凡脱俗的人穿上我设计的衣服，周围的人都将黯淡无光，所以我从未考虑过真的邀请她参加我的发布会。」</strong></p><p><img alt=\"19.jpg\" src=\"http://dstatic.zuimeia.com/media/article/image/2016/6/6/95d2b4a8-db9b-47cc-9c3f-e05ce64ce2c8_800x1086.jpeg\" title=\"\"/></p><p>在几年前出的自传（就是名字和效果一样像个炸弹的那本）中，山本耀司写了这样一句话：</p><p><strong>「有些女人，他们体验过地狱般的人生，尝遍了人生酸甜苦辣。有时，她们的哀伤如香火般从她们身上升起，灰飞烟灭。但哀伤的味道却不会沾染在她们身上。</strong></p><p><strong>她们才是受过良好教育的，高贵的女人。只有为了她们，我才会奉上用刀片划开的那一道精心设计的、完美的衣兜。」</strong></p><p><img alt=\"20.jpg\" src=\"http://dstatic.zuimeia.com/media/article/image/2016/6/6/25932002-12ee-4c6a-a3bc-267afdc61b64_800x589.jpeg\" title=\"\"/></p><p>而我们也知道，皮娜那句最著名的话：</p><p><strong>「我跳舞，因为我悲伤。」</strong></p><p><img alt=\"21.jpg\" src=\"http://dstatic.zuimeia.com/media/article/image/2016/6/6/5261f345-304a-400f-b17f-851dffa7ad02_800x480.jpeg\" title=\"\"/></p><p><img alt=\"22.jpg\" src=\"http://dstatic.zuimeia.com/media/article/image/2016/6/6/f197d320-6d41-4286-abbe-4b010caf76f8_800x800.jpeg\" title=\"\"/></p><p>我猜，没有比这更纯粹的欣赏。</p><p><strong>我所赞美的，那么恰好地就是</strong><strong>妳</strong><strong>。</strong></p><p><img alt=\"23.jpg\" src=\"http://dstatic.zuimeia.com/media/article/image/2016/6/6/3cffad3d-3364-4653-977b-599a3e5505d5_800x593.jpeg\" title=\"\"/></p><p><img alt=\"24.jpg\" src=\"http://dstatic.zuimeia.com/media/article/image/2016/6/6/80028750-af08-4877-97d7-a71c08dc4df7_800x593.jpeg\" title=\"\"/></p><p><strong>孤僻的我，这一辈子真诚地让我感动的只有海纳·穆勒和皮娜·鲍什，只要是这两个人的话我一定会服从，或者简单地说，就是想待在他们身边。</strong></p><p><strong>——山本耀司</strong></p><p><img alt=\"25.jpg\" src=\"http://dstatic.zuimeia.com/media/article/image/2016/6/6/2a8f0237-2382-4f10-aaa9-43238affa135_800x483.jpeg\" title=\"\"/></p><p><img alt=\"26.jpg\" src=\"http://dstatic.zuimeia.com/media/article/image/2016/6/6/602f2241-fa39-415b-83a7-5574f845272a_800x561.jpeg\" title=\"\"/></p><p><br/></p>"
    
    
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
