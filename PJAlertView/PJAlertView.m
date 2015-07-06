//
//  PJAlertView.m
//  BeautifulAlertView
//
//  Created by Prajeet Shrestha on 3/10/15.
//  Copyright (c) 2015 Prajeet Shrestha. All rights reserved.
//

#import "PJAlertView.h"

#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface PJAlertView ()
{
    NSLayoutConstraint *centerVerticallyToSuperView;
    
    NSLayoutConstraint *centerHorizontallyToSuperView;
    
    UIView *backView;
}
@end

@implementation PJAlertView

@synthesize controller;

- (id)init
{
    self = [super init];
    if (self)
    {
        self= [self getPJViewFromMainBundle];
        
        [self makeCommonInitializations];
    }
    return self;
}

- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle okButtonTitle:(NSString *)okButtonTitle
{
    {
        self = [super init];
        if (self)
        {
            self = [self getPJViewFromMainBundle];
            
            [self.okButton setTitle:okButtonTitle forState:UIControlStateNormal];
            
            [self.cancelButton setTitle:cancelButtonTitle forState:UIControlStateNormal];
            
            self.title.text = title;
            
            self.message.text = message;
            
            self.delegate = delegate;
            
            [self makeCommonInitializations];
        }
        return self;
    }
}

-(PJAlertView *)getPJViewFromMainBundle
{
    NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:@"PJAlert"
                                                      owner:nil
                                                    options:nil];
    
    return (PJAlertView *)[nibViews objectAtIndex:0];
}

-(void)makeCommonInitializations
{
    backView = [UIView new];
    
    backView.backgroundColor = [UIColor blackColor];
    
    backView.alpha = 0.3f;
    
    self.buttons = [[NSArray alloc]initWithObjects:self.cancelButton,self.okButton , nil];
    
    for (UIButton *btn in self.buttons){
        
        [btn addTarget:self action:@selector(removeViewsFromScreen) forControlEvents:UIControlEventTouchUpInside];
    }
}

-(void)show
{
    UIWindow *window = [[UIApplication sharedApplication]windows][0];
    
    backView.frame = window.rootViewController.view.frame;
    
    [window.rootViewController.view addSubview:backView];
    
    [window.rootViewController.view layoutIfNeeded];
    
    [window.rootViewController.view addSubview:self];
    
    [self setSelfConstraintWithRespectToViewOfViewController];
    
    [self setShadow:self];
    
    [self beginAnimations];
    
    [self setConstraintsOfSuperviewAccordingToInitializations];
}

-(void)setSelfConstraintWithRespectToViewOfViewController
{
    self.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *viewsDictionary = @{@"PJAlertView":self};
    
    NSDictionary *metrics =@{@"offset":@30};
    
    NSArray *widthConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-offset-[PJAlertView]-offset-|"
                                                                       options:0
                                                                       metrics:metrics
                                                                         views:viewsDictionary];
    
    centerVerticallyToSuperView = [NSLayoutConstraint constraintWithItem:self
                                                               attribute:NSLayoutAttributeCenterY
                                                               relatedBy:NSLayoutRelationEqual
                                                                  toItem:self.superview
                                                               attribute:NSLayoutAttributeCenterY
                                                              multiplier:1
                                                                constant:0
                                   ];
    
    
    
    centerHorizontallyToSuperView = [NSLayoutConstraint constraintWithItem:self
                                                                 attribute:NSLayoutAttributeCenterX
                                                                 relatedBy:NSLayoutRelationEqual
                                                                    toItem:self.superview
                                                                 attribute:NSLayoutAttributeCenterX
                                                                multiplier:1
                                                                  constant:0
                                     ];
    
    [self.superview addConstraint:centerVerticallyToSuperView];
    
    [self.superview addConstraint:centerHorizontallyToSuperView];
    
    [self.superview addConstraints:widthConstraint];
}

-(void)setShadow:(UIView *)view
{
    view.layer.shadowOffset = CGSizeMake(1, 1);
    
    view.layer.shadowRadius = 2;
    
    view.layer.shadowOpacity = 0.7;
}

-(void)beginAnimations
{
    self.transform = CGAffineTransformMakeScale(1.1, 1.1);
    
    [UIView animateWithDuration:0.2 animations:^(void){
        
        self.transform = CGAffineTransformMakeScale(1.0, 1.0);
        
    } completion:^(BOOL finished) {
        
    }];
}


-(void)setConstraintsOfSuperviewAccordingToInitializations
{
    if (self.okButton.titleLabel.text == nil && self.cancelButton.titleLabel.text !=nil) {
        
        [self removeView:self.okButton andSetConstraintOfView:self.cancelButton];
    }
    
    else if (self.cancelButton.titleLabel.text == nil && self.okButton.titleLabel.text != nil) {
        
        [self removeView:self.cancelButton andSetConstraintOfView:self.okButton];
    }
    
    else if (self.cancelButton.titleLabel.text == nil && self.okButton.titleLabel.text == nil)
    {
        
        self.okButtonHeightConstraint.constant = 0;
        
        self.cancelButtonHeightConstraint.constant = 0;
    }
    
    if (self.title.text == nil) {
        
        [self.titleViewContainer removeFromSuperview];
        
        NSDictionary *viewsDictionary = @{@"Message":self.message};
        
        NSDictionary *metrics = @{@"offset":@0};
        
        NSArray *widthConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-offset-[Message]-50-|"
                                                                           options:0
                                                                           metrics:metrics
                                                                             views:viewsDictionary];
        [self addConstraints:widthConstraint];
        
    }
}

-(void)removeView:(id)view andSetConstraintOfView:(id)changedConstraintView

{
    [view removeFromSuperview];
    
    NSDictionary *viewsDictionary = @{@"changedConstraintView":changedConstraintView};
    
    NSDictionary *metrics =@{@"offset":@0};
    
    NSArray *widthConstraint = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-offset-[changedConstraintView]-offset-|"
                                                                       options:0
                                                                       metrics:metrics
                                                                         views:viewsDictionary];
    
    [self addConstraints:widthConstraint];
}

-(void)removeViewsFromScreen
{
    
    [self removeFromSuperview];
    
    [UIView animateWithDuration:0.2f animations:^(void)
     {
         backView.alpha = 0.0f;
         
     }completion:^(BOOL finished){
         
         [backView removeFromSuperview];
     }];
    
}

- (IBAction)okAction:(id)sender {
    
    if (self.delegate) {
        [self.delegate clickedButtonPJAlertView:self
                                    buttonIndex:[self.buttons indexOfObject:sender]];
    }
}

- (IBAction)cancelAction:(id)sender {
    
    if (self.delegate) {
        [self.delegate clickedButtonPJAlertView:self
                                    buttonIndex:[self.buttons indexOfObject:sender]];
    }
}

@end
