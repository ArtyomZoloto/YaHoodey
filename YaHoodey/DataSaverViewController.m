//
//  DataSaverViewController.m
//  YaHoodey
//
//  Created by iMac on 09/05/2019.
//  Copyright © 2019 Artem. All rights reserved.
//

#import "DataSaverViewController.h"
#import "WeightService.h"
#import "WeightServiceProtocol.h"

@interface DataSaverViewController ()
@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) id<WeightServiceProtocol> service;
@property (strong, nonatomic) UILabel *statusLabel;
@property (strong, nonatomic) UIStackView *mainStackView;
-(void) status: (BOOL) result;
@end

@implementation DataSaverViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        UIImage *orig_img = [UIImage imageNamed:@"addBarItem"];
        UIImage *img = [orig_img imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        self.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"Добавить" image:img tag:2];
    }
    return self;
}

- (instancetype)initWithService:(id<WeightServiceProtocol>)service
{
    self = [self init];
    if (self) {
        _service = service;
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)loadView
{
    [super loadView];

    
    UIImageView *scales = [UIImageView new];
    scales.translatesAutoresizingMaskIntoConstraints = NO;
    [scales.widthAnchor constraintEqualToAnchor:scales.heightAnchor].active = YES;
    [scales setContentHuggingPriority:40 forAxis:UILayoutConstraintAxisVertical];
    scales.image = [UIImage imageNamed:@"scales"];
    
    self.statusLabel = [UILabel new];
    self.statusLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.statusLabel setFont:[UIFont systemFontOfSize:36.0f]];
    self.statusLabel.text = @" ";
    self.statusLabel.textAlignment = NSTextAlignmentCenter;
    
    UILabel *label = [UILabel new];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.text = @"Сейчас я вешу:";
    
    self.textField = [UITextField new];
    self.textField.translatesAutoresizingMaskIntoConstraints = NO;
    [self.textField setContentHuggingPriority:200 forAxis:UILayoutConstraintAxisHorizontal];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.keyboardType = UIKeyboardTypeDecimalPad;
    self.textField.delegate = self;
    
    UILabel *kgLabel = [UILabel new];
    kgLabel.translatesAutoresizingMaskIntoConstraints = NO;
    kgLabel.text = @"Кг";
    
    
    UIStackView* textFieldStackView = [[UIStackView alloc] initWithArrangedSubviews:@[label, self.textField,kgLabel]];
    textFieldStackView.translatesAutoresizingMaskIntoConstraints = NO;
    textFieldStackView.axis = UILayoutConstraintAxisHorizontal;
    textFieldStackView.distribution = UIStackViewDistributionFill;
    textFieldStackView.spacing = 20.0f;
    
    UIButton *clearButton = [UIButton buttonWithType:UIButtonTypeSystem];
    clearButton.translatesAutoresizingMaskIntoConstraints = NO;
    [clearButton addTarget:self action:@selector(clear) forControlEvents:UIControlEventTouchUpInside];
    [clearButton setTitle:@"Очистить" forState:UIControlStateNormal];
    
    
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeSystem];
    saveButton.translatesAutoresizingMaskIntoConstraints = NO;
    [saveButton addTarget:self action:@selector(save) forControlEvents:UIControlEventTouchUpInside];
    [saveButton setTitle:@"Сохранить" forState:UIControlStateNormal];
    
    UIStackView *buttonsStackView = [[UIStackView alloc] initWithArrangedSubviews:@[clearButton, saveButton]];
    buttonsStackView.translatesAutoresizingMaskIntoConstraints = NO;
    buttonsStackView.axis = UILayoutConstraintAxisHorizontal;
    buttonsStackView.spacing = 20.0f;
    
    NSLayoutConstraint *buttonsEqualConstraints = [NSLayoutConstraint
                                                   constraintWithItem:clearButton
                                                   attribute:NSLayoutAttributeWidth
                                                   relatedBy:NSLayoutRelationEqual
                                                   toItem:saveButton
                                                   attribute:NSLayoutAttributeWidth
                                                   multiplier:1
                                                   constant:0];
    [buttonsStackView addConstraint:buttonsEqualConstraints];
    
    self.mainStackView = [[UIStackView alloc] initWithArrangedSubviews:@[self.statusLabel,textFieldStackView, buttonsStackView, scales]];
    self.mainStackView.translatesAutoresizingMaskIntoConstraints = NO;
    self.mainStackView.distribution = UIStackViewDistributionFill;
    self.mainStackView.alignment = UIStackViewAlignmentFill;
    self.mainStackView.spacing = 30.0f;
    
    self.mainStackView.axis = UILayoutConstraintAxisVertical;
    [self.view addSubview:self.mainStackView];
    
    //UILayoutGuide *safeArea = self.view.safeAreaLayoutGuide;
    UILayoutGuide *safeArea = self.view.layoutMarginsGuide;
    [self.mainStackView.topAnchor constraintEqualToAnchor:safeArea.topAnchor].active = YES;
    [self.mainStackView.leadingAnchor constraintEqualToAnchor:safeArea.leadingAnchor].active = YES;
    [self.mainStackView.trailingAnchor constraintEqualToAnchor:safeArea.trailingAnchor].active = YES;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{

    if ((range.location == 0 && [string rangeOfString:@"."].location != NSNotFound) ||
        (range.location == 0 && [string rangeOfString:@","].location != NSNotFound)){
        return NO;
    }
    return YES;
//    NSCharacterSet *digits = [NSCharacterSet decimalDigitCharacterSet];
//
//    return [string rangeOfCharacterFromSet:digits].location != NSNotFound
//    || [string rangeOfString:@"."].location != NSNotFound
//    || [string rangeOfString:@","].location != NSNotFound;
}




#pragma mark - Action Capture
-(void) save
{
    [self.textField resignFirstResponder];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    __weak DataSaverViewController *weakSelf = self;
    NSString *string = [weakSelf.textField.text stringByReplacingOccurrencesOfString:@"," withString:@"."];
    CGFloat value = [string floatValue];
    dispatch_async(queue, ^{
        BOOL result =  [weakSelf.service save: value];
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf status:result];
        });
    });
}

-(void) clear {
    self.textField.text = nil;
}

-(void) status:(BOOL)result
{
    self.statusLabel.textColor = result ? [UIColor greenColor] : [UIColor redColor];
    [UIView transitionWithView:self.statusLabel
                      duration:0.3f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        self.statusLabel.text = result ? @"Сохранено" : @"Ошибка";
                    }
                    completion:^(BOOL finished) {
                        [UIView transitionWithView:self.statusLabel
                                          duration:0.3f
                                           options:UIViewAnimationOptionTransitionCrossDissolve
                                        animations:^{
                                            self.statusLabel.text = @" ";
                                        }
                                        completion: nil];
                    }];
}



@end
