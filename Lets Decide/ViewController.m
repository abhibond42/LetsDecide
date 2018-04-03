//
//  ViewController.m
//  Lets Decide
//
//  Created by Abhishek Hiremath on 28/03/17.
//  Copyright © 2017 abhishekhiremath. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#define PI 3.14159265358979323846
static inline float radians(double degrees) { return degrees * PI / 180; }



@interface ViewController ()

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setColorsArray];
    [self setwheel:4.0];
    [self setWinningPointer];
    
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGesture:)];
    [panGesture setMinimumNumberOfTouches:1];
    [panGesture setMaximumNumberOfTouches:1];
    [self.view addGestureRecognizer:panGesture];
    panGesture = nil;
    

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)clicked:(id)sender {
    
     int d = arc4random_uniform(9);
     int r = arc4random_uniform(9);
     int re = arc4random_uniform(9);
     int tv = arc4random_uniform(9);
    
     [self runAnimationOnView:_bdwond duration:1.0 rotations:r repeat:re toValue:tv];

}


-(void)setwheel:(float)numberOfSpokes{
    
    
     _bdwond = [[UIView alloc]initWithFrame:CGRectMake(self.view.center.x, self.view.center.y, 0 , 0)];
    UIRotationGestureRecognizer *rotate=[[UIRotationGestureRecognizer alloc]initWithTarget:self action:@selector(rotation:)];
    [_bdwond addGestureRecognizer:rotate];
    
    CGPoint center = CGPointMake(0,0);
    float radius = 150;
    float equalizer = 360/numberOfSpokes;
    
    for (int i=0; i<numberOfSpokes; i++) {
          int r = arc4random_uniform(9);
       
        CGFloat startAng = i*equalizer;
        CGFloat endAng = startAng + equalizer;
        CALayer *caLay = [CALayer layer];
        CATextLayer *caTextLayer = [CATextLayer layer];
        CAShapeLayer *arc = [CAShapeLayer layer];
        UIBezierPath *portionPath1 = [UIBezierPath bezierPath];
        [portionPath1 moveToPoint:center];
        [portionPath1 addArcWithCenter:center radius:radius startAngle:radians(startAng) endAngle:radians(endAng) clockwise:YES];
        [portionPath1 closePath];
        [portionPath1 fill];
        
        arc.path = [portionPath1 CGPath];
        arc.fillColor = (__bridge CGColorRef _Nullable)(_coloursList[r]);
    
        CGFloat x = portionPath1.bounds.origin.x;
        CGFloat y = portionPath1.bounds.origin.y;
        caTextLayer.string = [NSString stringWithFormat:@"NO.%d",i];
        [caTextLayer setFontSize:20];
        [caTextLayer setForegroundColor:[UIColor redColor].CGColor];
        [self setTextFrame:numberOfSpokes layer:portionPath1 spokeNumber:i catextLayer:caTextLayer];
       // caTextLayer.transform = CGAffineTransformMakeRotation(startAng);
//        caTextLayer.transform = CATransform3DMakeAffineTransform(CGAffineTransformMakeRotation(radians(90)));
    
        [caLay addSublayer:arc];
        [caLay addSublayer:caTextLayer];
       
        [_bdwond.layer addSublayer:caLay];


    }

    [self.view addSubview:_bdwond];
    

}


- (void) runAnimationOnView:(UIView*)view duration:(CGFloat)duration rotations:(CGFloat)rotations repeat:(float)repeat toValue:(float)toValue
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
//    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 /* full rotation*/ * rotations * duration ];
     rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI *2 /toValue];
    rotationAnimation.duration = duration;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = repeat;
    rotationAnimation.removedOnCompletion = NO;
    rotationAnimation.fillMode = kCAFillModeForwards;
    
    [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    

}

-(void)setColorsArray{
    
    UIColor *Color1 = [UIColor colorWithRed:0.0f/255.0f green:155.0f/255.0f blue:218.0f/255.0f alpha:1.0f].CGColor;
    
    UIColor *Color2 =  [UIColor colorWithRed:221.0f/255.0f green:169.0f/255.0f blue:255.0f/255.0f alpha:1.0f].CGColor;
    UIColor *Color3 =  [UIColor colorWithRed:106.0f/255.0f green:220.0f/255.0f blue:255.0f/255.0f alpha:1.0f].CGColor;
    UIColor *Color4 =  [UIColor colorWithRed:106.0f/255.0f green:220.0f/255.0f blue:43.0f/255.0f alpha:1.0f].CGColor;
     UIColor *Color5 =  [UIColor colorWithRed:246.0f/255.0f green:241.0f/255.0f blue:80.0f/255.0f alpha:1.0f].CGColor;
    
    UIColor *Color6 =  [UIColor colorWithRed:170.0f/255.0f green:114.0f/255.0f blue:255.0f/255.0f alpha:1.0f].CGColor;
    UIColor *Color7 =  [UIColor colorWithRed:75.0f/255.0f green:108.0f/255.0f blue:255.0f/255.0f alpha:1.0f].CGColor;
    UIColor *Color8 =  [UIColor colorWithRed:75.0f/255.0f green:239.0f/255.0f blue:226.0f/255.0f alpha:1.0f].CGColor;
    UIColor *Color9 =  [UIColor colorWithRed:223.0f/255.0f green:112.0f/255.0f blue:73.0f/255.0f alpha:1.0f].CGColor;
    NSMutableArray *tempArray = [[NSMutableArray alloc]init];
    
    [tempArray addObject:Color1];
    [tempArray addObject:Color2];
    [tempArray addObject:Color3];
    [tempArray addObject:Color4];
    [tempArray addObject:Color5];
    [tempArray addObject:Color6];
    [tempArray addObject:Color7];
    [tempArray addObject:Color8];
    [tempArray addObject:Color9];
    
    _coloursList = tempArray;

  
    
}

-(void)setTextFrame:(int)numberOfspokes layer:(UIBezierPath *)beizerPath spokeNumber:(int)spoke catextLayer:(CATextLayer *)caTextLay{
    
    
    
    switch (numberOfspokes) {
        case 2:
            if (spoke==0) {
                caTextLay.frame = CGRectMake(beizerPath.bounds.origin.x+90, beizerPath.bounds.origin.y +60, 90.0, 50.0);
               caTextLay.transform = CATransform3DMakeAffineTransform(CGAffineTransformMakeRotation(radians(90)));
            }else{
                caTextLay.frame = CGRectMake(beizerPath.bounds.origin.x+110, beizerPath.bounds.origin.y+40 , 90.0, 50.0);
                caTextLay.transform = CATransform3DMakeAffineTransform(CGAffineTransformMakeRotation(radians(270)));
            }
    
            break;
        case 3:
            
            if (spoke==0) {
                caTextLay.frame = CGRectMake(beizerPath.bounds.origin.x+70, beizerPath.bounds.origin.y +60, 90.0, 50.0);
                caTextLay.transform = CATransform3DMakeAffineTransform(CGAffineTransformMakeRotation(radians(45)));
            }
            
            else if(spoke==1){
                caTextLay.frame = CGRectMake(beizerPath.bounds.origin.x+30, beizerPath.bounds.origin.y+90 , 90, 50.0);
                caTextLay.transform = CATransform3DMakeAffineTransform(CGAffineTransformMakeRotation(radians(180)));
            }
            else{
                caTextLay.frame = CGRectMake(beizerPath.bounds.origin.x+90, beizerPath.bounds.origin.y+60 , 90, 50.0);
                caTextLay.transform = CATransform3DMakeAffineTransform(CGAffineTransformMakeRotation(radians(315)));
            }
            break;
        case 4:
            
            if (spoke==0){
                caTextLay.frame = CGRectMake(beizerPath.bounds.origin.x+15, beizerPath.bounds.origin.y +40, 90.0, 50.0);
                caTextLay.transform = CATransform3DMakeAffineTransform(CGAffineTransformMakeRotation(radians(45)));
                
            }
            else if(spoke==1){
                caTextLay.frame = CGRectMake(beizerPath.bounds.origin.x+30, beizerPath.bounds.origin.y+20 , 90, 50.0);
                caTextLay.transform = CATransform3DMakeAffineTransform(CGAffineTransformMakeRotation(radians(135)));
            }
            else if(spoke==2){
                caTextLay.frame = CGRectMake(beizerPath.bounds.origin.x+60, beizerPath.bounds.origin.y+60 , 90, 50.0);
                caTextLay.transform = CATransform3DMakeAffineTransform(CGAffineTransformMakeRotation(radians(225)));
            }
            else{
                caTextLay.frame = CGRectMake(beizerPath.bounds.origin.x+25, beizerPath.bounds.origin.y+70 , 90, 50.0);
                caTextLay.transform = CATransform3DMakeAffineTransform(CGAffineTransformMakeRotation(radians(315)));
            }
            
            break;
        default:
            break;
    }

}

-(void)setWinningPointer{
    
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGRect bounds = self.view.bounds;
    CGFloat radius = 20;
    CGFloat a = radius * sqrt((CGFloat)3.0) / 2;
    CGFloat b = radius / 2;
    [path moveToPoint:CGPointMake(0, -radius)];
    [path addLineToPoint:CGPointMake(a, b)];
    [path addLineToPoint:CGPointMake(-a, b)];
    
    [path closePath];
    [path applyTransform:CGAffineTransformMakeTranslation(CGRectGetMidX(bounds), CGRectGetMidY(bounds))];
    shapeLayer.path = path.CGPath;
    
    shapeLayer.strokeColor = [UIColor blueColor].CGColor;
    shapeLayer.fillColor = [UIColor colorWithRed:0.02 green:0.75 blue:0.96 alpha:1.0].CGColor;
    
    [self.view.layer addSublayer:shapeLayer ];
    
  
    
}


-(void)handlePanGesture:(UIPanGestureRecognizer *)gesture{
    
//       CGPoint wln = [gesture velocityInView:self.view];
//    
//      [self runAnimationOnView:_bdwond duration:0.4 rotations:wln.x/1000 repeat:0 toValue:wln.x/1000];
}

-(void) rotation:(UIRotationGestureRecognizer *) sender
{
   
    
}
@end
