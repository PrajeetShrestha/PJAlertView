//
//  PJAlertView.h
//  BeautifulAlertView
//
//  Created by Prajeet Shrestha on 3/10/15.
//  Copyright (c) 2015 Prajeet Shrestha. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol PJAlertViewDelegate <NSObject>

@optional
-(void)clickedButtonPJAlertView:(id)sender buttonIndex:(NSInteger)buttonIndex;
@end

@interface PJAlertView : UIView

@property (weak, nonatomic) IBOutlet UIView *titleBackgroundVIew;

@property (weak, nonatomic) IBOutlet UIView *titleViewContainer;

@property (weak, nonatomic) IBOutlet UILabel *title;

@property (weak, nonatomic) IBOutlet UILabel *message;

@property (weak, nonatomic) IBOutlet UIButton *okButton;

@property (weak, nonatomic) IBOutlet UIButton *cancelButton;

@property (strong,nonatomic) UIViewController *controller;

@property (strong,nonatomic) NSArray *buttons;

@property (weak,nonatomic)id <PJAlertViewDelegate> delegate;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *okButtonHeightConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cancelButtonHeightConstraint;
-(void)show;

-(void)setSelfConstraintWithRespectToViewOfViewController;


- (IBAction)okAction:(id)sender;
- (IBAction)cancelAction:(id)sender;

- (id)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle okButtonTitle:(NSString *)okButtonTitle;

@end
