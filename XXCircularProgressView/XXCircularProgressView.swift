import UIKit

@IBDesignable
public class XXCircularProgressView: UIView {
    @IBInspectable public var progress: CGFloat = 0.0 {
        didSet {
            progressLayer.strokeEnd = progress
        }
    }
    
    public var iconStyle: XXIconStyle = .Empty {
        didSet {
            iconLayer.path = iconStyle.path(iconLayerBounds)
        }
    }
    
    @IBInspectable public var lineWidth: CGFloat = 3.0 {
        didSet {
            backgroundLayer.lineWidth = lineWidth
            progressLayer.lineWidth = lineWidth
        }
    }
    
    @IBInspectable public var backgroundLayerStrokeColor: UIColor = UIColor(white: 0.90, alpha: 1.0) {
        didSet {
            backgroundLayer.strokeColor = backgroundLayerStrokeColor.CGColor
        }
    }
    
    @IBInspectable public var iconLayerFrameRatio: CGFloat = 0.4 {
        didSet {
            iconLayer.frame = iconLayerFrame(iconLayerBounds, ratio: iconLayerFrameRatio)
            iconLayer.path = iconStyle.path(iconLayerBounds)
        }
    }
    
    public var iconLayerBounds: CGRect {
        return iconLayer.bounds
    }
    
    public func setProgress(progress: CGFloat, animated: Bool = true) {
        if animated {
            self.progress = progress
        } else {
            self.progress = progress
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = progress
            animation.duration = 0.0
            progressLayer.addAnimation(animation, forKey: nil)
        }
    }
    
    public enum XXIconStyle {
        case Play
        case Pause
        case Stop
        case Download
        case Upload
        case Empty
        case Custom(UIBezierPath)
        
        func path(layerBounds: CGRect) -> CGPath {
            switch self {
            case .Play:
                let path = UIBezierPath()
                path.moveToPoint( CGPointMake(layerBounds.width / 5, 0))
                path.addLineToPoint(CGPoint(x: layerBounds.width, y: layerBounds.height / 2))
                path.addLineToPoint( CGPoint(x: layerBounds.width / 5, y: layerBounds.height))
                path.closePath()
                return path.CGPath
            case .Pause:
                var rect = CGRect(origin: CGPoint(x: layerBounds.width * 0.1, y: 0), size: CGSize(width: layerBounds.width * 0.2, height: layerBounds.height))
                let path = UIBezierPath(rect: rect)
                rect = rect.offsetBy(dx: layerBounds.width * 0.6, dy: 0)
                path.appendPath(UIBezierPath(rect: rect))
                return path.CGPath
            case .Stop:
                let insetBounds = layerBounds.insetBy(dx: layerBounds.width / 6, dy: layerBounds.width / 6)
                let path = UIBezierPath(rect: insetBounds)
                return path.CGPath
            case .Download:
                let rect = CGRect(origin: CGPoint(x: layerBounds.width * 0.45, y: 0), size: CGSize(width: layerBounds.width * 0.1, height: layerBounds.height))
                let path = UIBezierPath(rect: rect)
                var line = UIBezierPath()
                line.moveToPoint( CGPoint(x: 0, y: layerBounds.height * 0.7))
                line.addLineToPoint( CGPoint(x: layerBounds.width * 0.45, y: layerBounds.height))
                line.addLineToPoint( CGPoint(x: layerBounds.width * 0.45, y: layerBounds.height-layerBounds.width * 0.1));
                line.addLineToPoint( CGPoint(x: 0, y: layerBounds.height * 0.7-layerBounds.width * 0.1))
                line.closePath();
                path.appendPath(line)
                
                line = UIBezierPath()
                line.moveToPoint( CGPoint(x: layerBounds.width, y: layerBounds.height * 0.7))
                line.addLineToPoint( CGPoint(x: layerBounds.width * 0.55, y: layerBounds.height))
                line.addLineToPoint( CGPoint(x: layerBounds.width * 0.55, y: layerBounds.height-layerBounds.width * 0.1));
                line.addLineToPoint( CGPoint(x: layerBounds.width, y: layerBounds.height * 0.7-layerBounds.width * 0.1))
                line.closePath();
                path.appendPath(line)

                return path.CGPath
            case .Upload:
                let rect = CGRect(origin: CGPoint(x: layerBounds.width * 0.45, y: 0), size: CGSize(width: layerBounds.width * 0.1, height: layerBounds.height))
                let path = UIBezierPath(rect: rect)
                var line = UIBezierPath()
                line.moveToPoint( CGPoint(x: 0, y: layerBounds.height * 0.3))
                line.addLineToPoint( CGPoint(x: layerBounds.width * 0.45, y: 0))
                line.addLineToPoint( CGPoint(x: layerBounds.width * 0.45, y: layerBounds.width * 0.1));
                line.addLineToPoint( CGPoint(x: 0, y: layerBounds.height * 0.3 + layerBounds.width * 0.1))
                line.closePath();
                path.appendPath(line)
                
                line = UIBezierPath()
                line.moveToPoint( CGPoint(x: layerBounds.width, y: layerBounds.height * 0.3))
                line.addLineToPoint( CGPoint(x: layerBounds.width * 0.55, y: 0))
                line.addLineToPoint( CGPoint(x: layerBounds.width * 0.55, y: layerBounds.width * 0.1));
                line.addLineToPoint( CGPoint(x: layerBounds.width, y: layerBounds.height * 0.3+layerBounds.width * 0.1))
                line.closePath();
                path.appendPath(line)
                
                return path.CGPath
            case .Empty:
                return UIBezierPath().CGPath
            case .Custom(let path):
                return path.CGPath
            }
        }
    }
    
    lazy var backgroundLayer: CAShapeLayer = {
        let backgroundLayer = CAShapeLayer()
        backgroundLayer.fillColor = nil
        backgroundLayer.lineWidth = self.lineWidth
        backgroundLayer.strokeColor = self.backgroundLayerStrokeColor.CGColor
        self.layer.addSublayer(backgroundLayer)
        
        return backgroundLayer
    }()
    
    lazy var progressLayer: CAShapeLayer = {
        let progressLayer = CAShapeLayer()
        progressLayer.fillColor = nil
        progressLayer.lineWidth = self.lineWidth
        progressLayer.strokeColor = self.tintColor.CGColor
        self.layer.insertSublayer(progressLayer, above: self.backgroundLayer)
        
        return progressLayer
    }()
    
    lazy var iconLayer: CAShapeLayer = {
        let iconLayer = CAShapeLayer()
        iconLayer.fillColor = self.tintColor.CGColor
        self.layer.addSublayer(iconLayer)
        
        return iconLayer
    }()
    
    func iconLayerFrame(rect: CGRect, ratio: CGFloat) -> CGRect {
        let insetRatio = (1 - ratio) / 2.0
        return rect.insetBy(dx: rect.width * insetRatio, dy: rect.height * insetRatio)
    }
    
    func getSquareLayerFrame(rect: CGRect) -> CGRect {
        if rect.width != rect.height {
            let width = min(rect.width, rect.height)
            
            let originX = (rect.width - width) / 2
            let originY = (rect.height - width) / 2
            
            return CGRect(x: originX, y: originY, width: width, height: width)
        }
        return rect
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        let squareRect = getSquareLayerFrame(layer.bounds)
        backgroundLayer.frame = squareRect
        progressLayer.frame = squareRect
        
        let innerRect = squareRect.insetBy(dx: lineWidth / 2.0, dy: lineWidth / 2.0)
        iconLayer.frame = iconLayerFrame(innerRect, ratio: iconLayerFrameRatio)
        
        let center = CGPoint(x: squareRect.width / 2.0, y: squareRect.height / 2.0)
        let path = UIBezierPath(arcCenter: center, radius: innerRect.width / 2.0, startAngle: CGFloat(-M_PI_2), endAngle: CGFloat(-M_PI_2 + 2.0 * M_PI), clockwise: true)
        backgroundLayer.path = path.CGPath
        progressLayer.path = path.CGPath
        iconLayer.path = iconStyle.path(iconLayerBounds)
    }
    
    override public func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        iconStyle = .Play
    }

}

