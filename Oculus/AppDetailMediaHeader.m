//
//  AppDetailMediaHeader.m
//  Oculus
//
//  Created by Justin Wells on 6/20/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "AppDetailMediaHeader.h"
#import "Constants.h"
#import <SDWebImage/UIView+WebCache.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface AppDetailMediaHeader ()

@property (strong, nonatomic) OCApp *app;
@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation AppDetailMediaHeader

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self setupView];
    }
    return self;
}

- (void) setupView{
    self.backgroundColor = COLOR_SECONDARY;
}

- (void) setupMediaPlayerView{
    self.mediaPlayerView = [[OCMediaPlayerView alloc] initWithFrame:self.frame videoString:self.app.video];
    self.mediaPlayerView.frame = self.frame;
    [self addSubview:self.mediaPlayerView];
}

- (void) setupImageView{
    self.imageView = [[UIImageView alloc] initWithFrame:self.frame];
    if(self.app.image != nil){
        [self.imageView sd_setShowActivityIndicatorView:true];
        [self.imageView sd_setIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.app.image]];
    }
    else{
        self.imageView.image = [UIImage imageNamed:@"oculusPlaceholder"];
    }
    [self addSubview:self.imageView];
}

- (void) configure:(OCApp *)app{
    if(app != nil){
        self.app = app;
        if(app.video != nil && ![app.video isEqual:[NSNull null]]){
            //Setup Media Player View
            [self setupMediaPlayerView];
        }
        else{
            //Setup ImageView
            [self setupImageView];
        }
    }
}

@end
