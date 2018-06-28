//
//  EventDetailController.m
//  Oculus
//
//  Created by Justin Wells on 6/20/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "EventDetailController.h"
#import "EventDetailScrollView.h"
#import "AlertsManager.h"
#import "EventManager.h"
#import "Constants.h"

@interface EventDetailController ()

@property (strong, nonatomic) OCEvent *event;
@property (strong, nonatomic) NSString *eventId;
@property (strong, nonatomic) EventDetailScrollView *eventDetailView;
@property (strong, nonatomic) AlertsManager *alertsManager;

@end

@implementation EventDetailController

- (instancetype)initWithEvent:(OCEvent *)event eventId:(NSString *)eventId{
    self = [super init];
    if (self){
        self.event = event;
        self.eventId = eventId;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = COLOR_SECONDARY;

    //Setup NavigationBar
    [self setupNavigationBar];
    
    if (self.event == nil){
        EventManager *eventManager = [[EventManager alloc] init];
        [eventManager downloadEvent:self.eventId completion:^(NSArray *events, NSError *error) {
            if(events.count > 0){
                self.event = [events firstObject];
                //Setup View
                self.navigationItem.title = self.event.name;
                [self setupView];
            }
        }];
    }
    else{
        //Setup View
        [self setupView];
    }
}

- (void) setupNavigationBar{
    //Set Navigation Items
    self.navigationItem.title = self.event.name;
    
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back"] style: UIBarButtonItemStylePlain target:self action:@selector(backButtonPressed:)];
    self.navigationItem.leftBarButtonItem = backButtonItem;
}

- (void) setupView{
    //Setup EventDetail View
    [self setupEventDetailView];
    
    //Setup Constraints
    [self setupConstraints];
    
    //Setup AlertsManager
    self.alertsManager = [[AlertsManager alloc] init];
}

- (void) setupEventDetailView{
    self.eventDetailView = [[EventDetailScrollView alloc] init];
    [self.eventDetailView configure:self.event];
    [self.eventDetailView.interestedButton addTarget:self action:@selector(interestedButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.eventDetailView.translatesAutoresizingMaskIntoConstraints = false;
    [self.view addSubview:self.eventDetailView];
}

- (void) setupConstraints{
    //Width & Horizontal Constraints
    [self.view addConstraint: [NSLayoutConstraint constraintWithItem:self.eventDetailView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1 constant:0]];
    [self.view addConstraint: [NSLayoutConstraint constraintWithItem:self.eventDetailView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    //Height & Vertical Constraints
    [self.view addConstraint: [NSLayoutConstraint constraintWithItem:self.eventDetailView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0]];
    [self.view addConstraint: [NSLayoutConstraint constraintWithItem:self.eventDetailView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
}

- (void)interestedButtonPressed:(id) sender{
    //Show Alert that this feature is not available
    [self presentViewController:[self.alertsManager createFeatureUnavailableAlert] animated:true completion:nil];
}

//Bar Button Delegate
- (void) backButtonPressed:(id) sender{
    [self.navigationController popViewControllerAnimated:true];
}


@end
