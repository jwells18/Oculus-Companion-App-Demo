//
//  SampleDataManager.m
//  Oculus
//
//  Created by Justin Wells on 6/23/18.
//  Copyright © 2018 SynergyLabs. All rights reserved.
//

#import "SampleDataManager.h"

@implementation SampleDataManager

- (instancetype)init {
    self = [super init];
    
    //Setup Firestore
    self.db = [FIRFirestore firestore];
    self.dateManager = [[DateManager alloc] init];
    
    return self;
}

- (void) uploadSampleAppSections{
    //Create Data Reference
    __block FIRCollectionReference *ref = [self.db collectionWithPath:@"AppSections"];
 
    NSArray *appSectionNames = @[@"Get started with these experiences...", @"Oculus Summer Sale", @"Top Selling", @"Top Free", @"On Sale", @"New Releases", @"360 Experiences", @"Multiplayer & Social", @"Movies", @"Entertainment", @"Horror & Mystery", @"Action & Adventure", @"Racing & Flying", @"Simulators", @"Strategy", @"Sports", @"Games", @"Apps", @"Education", @"Music", @"Travel", @"Browse All"];
    NSDictionary *appSectionApps = @{@"BIGmo2BA19XylXsUT0UB": @{@"objectId": @"BIGmo2BA19XylXsUT0UB",
                                                             @"name": @"Rush",
                                                             @"image": @"https://firebasestorage.googleapis.com/v0/b/ticketmaster-23010.appspot.com/o/App%2FRush%2Fimages%2Frush.jpg?alt=media&token=1d2a9fac-7e68-478e-89d4-09a34e790798",
                                                             @"price": @7.99,
                                                             @"salePrice": @4.99,
                                                             @"isPack": @false},
                                  @"u180KviM7xAlk5Aepdzx": @{@"objectId": @"u180KviM7xAlk5Aepdzx",
                                                             @"name": @"Coaster Combat",
                                                             @"image": @"https://firebasestorage.googleapis.com/v0/b/ticketmaster-23010.appspot.com/o/App%2FCoasterCombat%2Fimages%2FcoasterCombatMain.jpg?alt=media&token=dded0923-4e15-4801-b18d-cb974ad74388",
                                                             @"price": @4.99,
                                                             @"salePrice": @3.49,
                                                             @"isPack": @true},
                                  @"4ryn9Ebw53gdx4xCD4Ss": @{@"objectId": @"4ryn9Ebw53gdx4xCD4Ss",
                                                             @"name": @"Games with Friends",
                                                             @"image": @"https://firebasestorage.googleapis.com/v0/b/ticketmaster-23010.appspot.com/o/App%2FGamesWithFriends%2Fimages%2FgamesWithFriendsMain.jpg?alt=media&token=b204ba05-dfb1-400e-8862-f4e227d5005f",
                                                             @"price": @39.99,
                                                             @"isPack": @false},
                                  @"KNve64UeFzAoCY92zR7B": @{@"objectId": @"KNve64UeFzAoCY92zR7B",
                                                             @"name": @"Virtual Virtual Reality",
                                                             @"image": @"https://firebasestorage.googleapis.com/v0/b/ticketmaster-23010.appspot.com/o/App%2FVirtualVirtualReality%2Fimages%2FvirtualVirtualRealityMain.jpg?alt=media&token=ccd3bd4e-a11d-4dfb-b3c1-f6ffe61ce6e1",
                                                             @"price": @9.99,
                                                             @"salePrice": @7.49,
                                                             @"isPack": @false},
                                  @"7IDeXFrPBLZDtja8XdGi": @{@"objectId": @"7IDeXFrPBLZDtja8XdGi",
                                                             @"name": @"Jurassic World: Blue",
                                                             @"image": @"https://firebasestorage.googleapis.com/v0/b/ticketmaster-23010.appspot.com/o/App%2FJurassicWorldBlue%2Fimages%2FjurassicWorldBlueMain.jpg?alt=media&token=e80dd043-6d00-4a0b-a753-10f9c6bcbec0",
                                                             @"price": @0,
                                                             @"isPack": @false},
                                  @"aMdABQXUASXU13PdbZ04": @{@"objectId": @"aMdABQXUASXU13PdbZ04",
                                                             @"name": @"SWAT Academy",
                                                             @"image": @"https://firebasestorage.googleapis.com/v0/b/ticketmaster-23010.appspot.com/o/App%2FSWATAcademy%2Fimages%2FswatAcademyMain.jpg?alt=media&token=3db76cce-1bde-4682-aa6c-3bdf8048a92d",
                                                             @"price": @7.99,
                                                             @"salePrice": @4.99,
                                                             @"isPack": @false},
                                  @"DoPpZvjl8q4azZCQYB8R": @{@"objectId": @"DoPpZvjl8q4azZCQYB8R",
                                                             @"name": @"Anne Frank House VR",
                                                             @"image": @"https://firebasestorage.googleapis.com/v0/b/ticketmaster-23010.appspot.com/o/App%2FAnneFrankHouseVR%2Fimages%2FanneFrankVRMain.jpg?alt=media&token=5b439071-d605-44a2-a08f-c561b6c794e6",
                                                             @"price": @0,
                                                             @"isPack": @false}};
    NSArray *appSectionSearchConstraints = @[@{}, @{}, @{}, @{}, @{}, @{}, @{}, @{}, @{}, @{}, @{}, @{}, @{}, @{}, @{}, @{}, @{}, @{}, @{}, @{}, @{}, @{}];
    
    NSDictionary *appSectionDictionary;
    for (int i = 0; i < appSectionNames.count; i++) {
        NSString *objectId = [[ref documentWithAutoID] documentID];
        appSectionDictionary = @{@"objectId": objectId,
                                 @"createdAt": [NSDate date],
                                 @"updatedAt": [NSDate date],
                                 @"name": appSectionNames[i],
                                 @"apps": appSectionApps,
                                 @"priority": [NSNumber numberWithInt:i],
                                 @"searchConstraints": appSectionSearchConstraints[i]
                                 };
        
        //Upload Data
        [[ref documentWithPath:appSectionNames[i]] setData:appSectionDictionary completion:^(NSError * _Nullable error) {
            if(error){
                NSLog(@"Error: %@", error);
            }
            else{
                NSLog(@"App Section %@ was uploaded successfully", appSectionNames[i]);
            }
        }];
    }
}

- (void) uploadSampleApps{
    //Create Data Reference
    __block FIRCollectionReference *ref = [self.db collectionWithPath:@"Apps"];
    
    NSArray *appNames = @[@"Rush", @"Coaster Combat", @"Games with Friends", @"Virtual Virtual Reality", @"Jurassic World: Blue", @"SWAT Academy", @"Anne Frank House VR"];
    NSArray *appCategories = @[@"games", @"games", @"", @"games", @"entertainment", @"games", @"apps"];
    NSArray *appGenres = @[@{@"action": [NSDate date], @"adventure": [NSDate date], @"exploration": [NSDate date], @"racing": [NSDate date], @"simulation": [NSDate date]}, @{@"action": [NSDate date], @"casual": [NSDate date], @"rollerCoaster": [NSDate date]}, [NSNull null], @{@"adventure": [NSDate date], @"exploration": [NSDate date], @"narrative": [NSDate date]}, @{@"adventure": [NSDate date], @"dinosaurs": [NSDate date], @"movie": [NSDate date]}, @{@"action": [NSDate date], @"shooter": [NSDate date]}, @{@"documentaryAndHistory": [NSDate date], @"educational": [NSDate date]}];
    NSArray *appPrices = @[@7.99, @4.99, @39.99, @9.99, @0, @7.99, @0];
    NSArray *appSalePrices = @[@4.99, @3.49,[NSNull null], @7.49, [NSNull null], @4.99, [NSNull null]];
    NSArray *appImages = @[@"https://firebasestorage.googleapis.com/v0/b/ticketmaster-23010.appspot.com/o/App%2FRush%2Fimages%2Frush.jpg?alt=media&token=1d2a9fac-7e68-478e-89d4-09a34e790798", @"https://firebasestorage.googleapis.com/v0/b/ticketmaster-23010.appspot.com/o/App%2FCoasterCombat%2Fimages%2FcoasterCombatMain.jpg?alt=media&token=dded0923-4e15-4801-b18d-cb974ad74388", @"https://firebasestorage.googleapis.com/v0/b/ticketmaster-23010.appspot.com/o/App%2FGamesWithFriends%2Fimages%2FgamesWithFriendsMain.jpg?alt=media&token=b204ba05-dfb1-400e-8862-f4e227d5005f", @"https://firebasestorage.googleapis.com/v0/b/ticketmaster-23010.appspot.com/o/App%2FVirtualVirtualReality%2Fimages%2FvirtualVirtualRealityMain.jpg?alt=media&token=ccd3bd4e-a11d-4dfb-b3c1-f6ffe61ce6e1", @"https://firebasestorage.googleapis.com/v0/b/ticketmaster-23010.appspot.com/o/App%2FJurassicWorldBlue%2Fimages%2FjurassicWorldBlueMain.jpg?alt=media&token=e80dd043-6d00-4a0b-a753-10f9c6bcbec0", @"https://firebasestorage.googleapis.com/v0/b/ticketmaster-23010.appspot.com/o/App%2FSWATAcademy%2Fimages%2FswatAcademyMain.jpg?alt=media&token=3db76cce-1bde-4682-aa6c-3bdf8048a92d", @"https://firebasestorage.googleapis.com/v0/b/ticketmaster-23010.appspot.com/o/App%2FAnneFrankHouseVR%2Fimages%2FanneFrankVRMain.jpg?alt=media&token=5b439071-d605-44a2-a08f-c561b6c794e6"];
    NSArray *appImagesArray = @[@[@"https://firebasestorage.googleapis.com/v0/b/ticketmaster-23010.appspot.com/o/App%2FRush%2Fimages%2Frush.jpg?alt=media&token=1d2a9fac-7e68-478e-89d4-09a34e790798", @"https://firebasestorage.googleapis.com/v0/b/ticketmaster-23010.appspot.com/o/App%2FRush%2Fimages%2Frush.jpg?alt=media&token=1d2a9fac-7e68-478e-89d4-09a34e790798", @"https://firebasestorage.googleapis.com/v0/b/ticketmaster-23010.appspot.com/o/App%2FRush%2Fimages%2Frush.jpg?alt=media&token=1d2a9fac-7e68-478e-89d4-09a34e790798"], @[@"https://firebasestorage.googleapis.com/v0/b/ticketmaster-23010.appspot.com/o/App%2FCoasterCombat%2Fimages%2FcoasterCombatMain.jpg?alt=media&token=dded0923-4e15-4801-b18d-cb974ad74388", @"https://firebasestorage.googleapis.com/v0/b/ticketmaster-23010.appspot.com/o/App%2FCoasterCombat%2Fimages%2FcoasterCombatMain.jpg?alt=media&token=dded0923-4e15-4801-b18d-cb974ad74388", @"https://firebasestorage.googleapis.com/v0/b/ticketmaster-23010.appspot.com/o/App%2FCoasterCombat%2Fimages%2FcoasterCombatMain.jpg?alt=media&token=dded0923-4e15-4801-b18d-cb974ad74388"], [NSNull null], @[@"https://firebasestorage.googleapis.com/v0/b/ticketmaster-23010.appspot.com/o/App%2FVirtualVirtualReality%2Fimages%2FvirtualVirtualRealityMain.jpg?alt=media&token=ccd3bd4e-a11d-4dfb-b3c1-f6ffe61ce6e1", @"https://firebasestorage.googleapis.com/v0/b/ticketmaster-23010.appspot.com/o/App%2FVirtualVirtualReality%2Fimages%2FvirtualVirtualRealityMain.jpg?alt=media&token=ccd3bd4e-a11d-4dfb-b3c1-f6ffe61ce6e1", @"https://firebasestorage.googleapis.com/v0/b/ticketmaster-23010.appspot.com/o/App%2FVirtualVirtualReality%2Fimages%2FvirtualVirtualRealityMain.jpg?alt=media&token=ccd3bd4e-a11d-4dfb-b3c1-f6ffe61ce6e1"], @[@"https://firebasestorage.googleapis.com/v0/b/ticketmaster-23010.appspot.com/o/App%2FJurassicWorldBlue%2Fimages%2FjurassicWorldBlueMain.jpg?alt=media&token=e80dd043-6d00-4a0b-a753-10f9c6bcbec0", @"https://firebasestorage.googleapis.com/v0/b/ticketmaster-23010.appspot.com/o/App%2FJurassicWorldBlue%2Fimages%2FjurassicWorldBlueMain.jpg?alt=media&token=e80dd043-6d00-4a0b-a753-10f9c6bcbec0", @"https://firebasestorage.googleapis.com/v0/b/ticketmaster-23010.appspot.com/o/App%2FJurassicWorldBlue%2Fimages%2FjurassicWorldBlueMain.jpg?alt=media&token=e80dd043-6d00-4a0b-a753-10f9c6bcbec0"], @[@"https://firebasestorage.googleapis.com/v0/b/ticketmaster-23010.appspot.com/o/App%2FSWATAcademy%2Fimages%2FswatAcademyMain.jpg?alt=media&token=3db76cce-1bde-4682-aa6c-3bdf8048a92d", @"https://firebasestorage.googleapis.com/v0/b/ticketmaster-23010.appspot.com/o/App%2FSWATAcademy%2Fimages%2FswatAcademyMain.jpg?alt=media&token=3db76cce-1bde-4682-aa6c-3bdf8048a92d", @"https://firebasestorage.googleapis.com/v0/b/ticketmaster-23010.appspot.com/o/App%2FSWATAcademy%2Fimages%2FswatAcademyMain.jpg?alt=media&token=3db76cce-1bde-4682-aa6c-3bdf8048a92d"], @[@"https://firebasestorage.googleapis.com/v0/b/ticketmaster-23010.appspot.com/o/App%2FAnneFrankHouseVR%2Fimages%2FanneFrankVRMain.jpg?alt=media&token=5b439071-d605-44a2-a08f-c561b6c794e6"]];
    NSArray *appVideos = @[@"https://firebasestorage.googleapis.com/v0/b/ticketmaster-23010.appspot.com/o/App%2FRush%2Fvideo%2Frush.mp4?alt=media&token=d7c5186f-9666-45dd-946c-f338efd91a1d", @"https://firebasestorage.googleapis.com/v0/b/ticketmaster-23010.appspot.com/o/App%2FCoasterCombat%2Fvideo%2FcoasterCombat.mp4?alt=media&token=48839639-d643-4693-868a-d83b1dbf28e6", [NSNull null], @"https://firebasestorage.googleapis.com/v0/b/ticketmaster-23010.appspot.com/o/App%2FVirtualVirtualReality%2Fvideo%2FvirtualVirtualReality.mp4?alt=media&token=1ad45885-79b4-4a7f-8935-fef86a72c38c", @"https://firebasestorage.googleapis.com/v0/b/ticketmaster-23010.appspot.com/o/App%2FJurassicWorldBlue%2Fvideo%2FjurassicBlue.mp4?alt=media&token=5984142d-9519-4d16-909f-606a7e16a115", @"https://firebasestorage.googleapis.com/v0/b/ticketmaster-23010.appspot.com/o/App%2FSWATAcademy%2Fvideo%2FswatAcademy.mp4?alt=media&token=72dd75ef-49b4-46bb-8c78-680a34a673fc", @"https://firebasestorage.googleapis.com/v0/b/ticketmaster-23010.appspot.com/o/App%2FAnneFrankHouseVR%2Fvideo%2FanneFrankVR.mp4?alt=media&token=2d2f7cb2-6af1-4aa0-b048-5c4fe40bb002"];
    NSArray *appIsPack = @[@false, @false, @true, @false, @false, @false, @false];
    NSArray *appPackApps = @[[NSNull null], [NSNull null], [NSNull null], [NSNull null], [NSNull null], [NSNull null], [NSNull null]];
    NSArray *appRatings = @[@4.1, @4.4, [NSNull null], @4.8, @4.0, @4.2, @4.7];
    NSArray *appRatingsCount = @[@414, @184, [NSNull null], @469, @662, @180, @163];
    NSArray *appIntensities = @[@"comfortable", @"moderate", [NSNull null], @"comfortable", @"comfortable", @"comfortable", @"comfortable"];
    NSArray *appDetails = @[@"Take a dive into the adrenaline-pumping world of wingsuit flying with RUSH. Soar down mountainsides at breakneck speeds. Weave through canyons, dodge outcrops, and plummet down sheer drops as you race towards the finish line.\n\nDo you have what it takes to walk a tightrope at near terminal velocity?\n\nFEATURES\n- Stunning environments: Soar down four breathtaking mountainsides\n- Challenging races: 80 unique mountain paths to master, from basic downhill trails to expert-level suicide runs through the narrowest of spaces.\n- Multiple game modes: Race to the finish, Time Attack, and Score Challenge, each requiring a different set of skills and strategies to succeed.\n- Epic multiplayer jumps: Challenge up to 3 of your friends online via Oculus home parties, or quick race against random jumpers.\n\nStrap on your headset and hold on tight; you're in for a RUSH!", @"Get ready for one of the most enjoyable roller coaster experiences ever! Part roller coaster experience, part action game, Coaster Combat is one of the most addictive and immersive VR apps on the store. Embark on extremely exhilarating yet amazingly comfortable rides with an unlimited number of different track combinations! No two rides are ever the same! Engage in ‘coaster combat’ as you rack up scores by hitting treasure targets with a range of differently themed weapons! Invite your VR friends to your own personal score challenges for social multiplayer fun, all against the backdrop of a wide variety of different worlds, ranging from beautiful pirate paradises to cursed castles filled with jump scares!", @"Join forces or play against new friends to conquer the galaxy, confront zombies or race down a mountainside in a wing-suit! Start playing Games with Friends now!", @"V-VR is a narrative-driven comedy-adventure game about VR and AI. In a future where AI has transformed society, can humans still find purpose? Find out with Activitude, a service that lets humans aid AI clients in increasingly curious ways. Follow the instructions of Activitude’s AI overlord, Chaz, and find your calling in this tech-fueled future – or try to break free and reclaim your humanity before it’s too late. Use virtual VR headsets to explore over 50 unique virtual virtual realities, going deeper into the inner workings of Activitude as the story unfolds.", @"Jurassic World: BLUE\nDinosaurs have overtaken the turbulent Isla Nublar, but the threat of a natural disaster erupting looms eerily over the island. Follow Blue, a highly intelligent Velociraptor, on her quest for survival, using VR to experience her extraordinary sensorial abilities and awareness as she scours for food and water, searches for signs of life, and fights against some of the island’s most threatening predators.", @"SWAT Academy puts you to the test as you master the weapons and tactics needed to become the best of the best. Hone your skills in the intense combat training simulations, face off against waves of hostile targets, and survive the onslaught of the zombie horde.\n\nDesigned to use the new 3DOF controller, SWAT Academy gives you full tactical control, letting you take the action into your hands. Combine that with the insanely detailed weapon models and atmospheric environments, and you've got a visceral VR experience like you've never felt before.", @"In 1942, during the Second World War, Anne Frank, a thirteen-year-old Jewish girl and her family were forced to go into hiding to escape persecution from the Nazis. For more than two years, the Franks and 4 others would live in the “Secret Annex” of an old office building in Amsterdam, sharing the burden of living in hiding in confined quarters with the constant threat of discovery.\n\nAnne Frank House VR offers a unique and emotional insight into these two years. Experience the world-famous Secret Annex in a never before seen way. Travel back to the years of the Second World War and wander through the rooms of the Annex that housed the group of 8 Jewish people as they hid from the Nazis. Immerse yourself in Anne’s thoughts as you traverse each faithfully recreated room, thanks to the power of VR, and find out what happened to the Annex’ brave inhabitants."];
    NSArray *appESRBRatings = @[@"everyone", @"everyone", [NSNull null], @"teen", @"everyone10+", @"everyone10+", @"everyone"];
    NSArray *appESRBRatingDetails = @[@{@"usersInteract": @true}, @{@"digitalPurchases": @true}, [NSNull null], @{@"language": @true, @"fantasyViolence":@true}, @{@"mildViolence": @true}, @{@"fantasyViolence":@true}, @{}];
    NSArray *appRefundPolicies = @[@"https://www.oculus.com/legal/rift-content-refund-policy/", @"https://www.oculus.com/legal/rift-content-refund-policy/", [NSNull null], @"https://www.oculus.com/legal/rift-content-refund-policy/", @"https://www.oculus.com/legal/rift-content-refund-policy/", @"https://www.oculus.com/legal/rift-content-refund-policy/", @"https://www.oculus.com/legal/rift-content-refund-policy/"];
    NSArray *appPlatforms = @[@{@"oculusGo": @true}, @{@"oculusGo": @true}, [NSNull null], @{@"oculusGo": @true}, @{@"oculusGo": @true}, @{@"oculusGo": @true}, @{@"oculusGo": @true}];
    NSArray *appIsInternetRequired = @[@false, @false, [NSNull null], @false, @true, @false, @false];
    NSArray *appStorageSizes = @[@274, @741, [NSNull null], @315, @37, @202, @365];
    NSArray *appRequirements = @[@{@"oculusGoController": @true}, @{@"oculusGoController": @true}, [NSNull null], @{@"oculusGoController": @true}, @{@"oculusGoController": @true}, @{@"oculusGoController": @true}, @{@"oculusGoController": @true}];
    NSArray *appGameModes = @[@{@"singleUser": @true, @"multiplayer": @true, @"co-op": @true}, @{@"singleUser": @true}, [NSNull null], @{@"singleUser": @true}, @{@"singleUser": @true}, @{@"singleUser": @true}, @{@"singleUser": @true}];
    NSArray *appReleaseDates = @[[self.dateManager createDateFromString: @"2017/05/24 00:00"],[self.dateManager createDateFromString: @"2018/04/20 00:00"], [NSNull null], [self.dateManager createDateFromString: @"2018/05/01 00:00"], [self.dateManager createDateFromString: @"2018/04/30 00:00"], [self.dateManager createDateFromString: @"2017/04/21 00:00"], [self.dateManager createDateFromString: @"2018/06/12 00:00"]];
    NSArray *appLanguages = @[@{@"english": @true}, @{@"english": @true}, [NSNull null], @{@"english": @true, @"chineseChina": @true, @"chineseTaiwan": @true, @"german": @true, @"spanishMexico": @true, @"frenchFrance": @true, @"italian": @true, @"japanese": @true, @"korean": @true}, @{@"english": @true}, @{@"english": @true}, @{@"english": @true, @"frenchFrance": @true, @"spanishSpain": @true, @"portuguesePortugal": @true, @"hebrew": @true, @"german": @true, @"dutch": @true}];
    NSArray *appTermsURLs = @[@"http://www.thebinarymill.com/terms.php", @"https://forcefieldvr.com/terms-of-service", [NSNull null], @"http://tenderclaws.com/privacy/EULA.html", @"http://www.felixandpaul.com/license", @"http://www.thebinarymill.com/terms.php", @"https://forcefieldvr.com/terms-of-service"];
    NSArray *appPrivacyPoliciesURLs = @[@"http://www.thebinarymill.com/privacy.php", @"https://forcefieldvr.com/privacy-policy", [NSNull null], @"http://tenderclaws.com/privacy/PrivacyPolicy.html", @"http://www.felixandpaul.com/privacy", @"http://www.thebinarymill.com/privacy.php", @"https://forcefieldvr.com/privacy-policy"];

    NSDictionary *appDictionary;
    for (int i = 0; i < appNames.count; i++) {
        NSString *objectId = [[ref documentWithAutoID] documentID];
        appDictionary = @{@"objectId": objectId,
                          @"createdAt": [NSDate date],
                          @"updatedAt": [NSDate date],
                          @"name": appNames[i],
                          @"category": appCategories[i],
                          @"genres": appGenres[i],
                          @"price": appPrices[i],
                          @"salePrice": appSalePrices[i],
                          @"image": appImages[i],
                          @"images": appImagesArray[i],
                          @"video": appVideos[i],
                          @"isPack": appIsPack[i],
                          @"packApps": appPackApps[i],
                          @"rating": appRatings[i],
                          @"ratingCount": appRatingsCount[i],
                          @"intensity": appIntensities[i],
                          @"details": appDetails[i],
                          @"esrbRating": appESRBRatings[i],
                          @"esrbRatingDetails": appESRBRatingDetails[i],
                          @"refundPolicy": appRefundPolicies[i],
                          @"platforms": appPlatforms[i],
                          @"isInternetRequired": appIsInternetRequired[i],
                          @"storageSize": appStorageSizes[i],
                          @"requirements": appRequirements[i],
                          @"gameModes": appGameModes[i],
                          @"releaseDate": appReleaseDates[i],
                          @"languages": appLanguages[i],
                          @"termsURL": appTermsURLs[i],
                          @"privacyPolicyURL": appPrivacyPoliciesURLs[i]
                          };
        
        //Upload Data
        [[ref documentWithPath:objectId] setData:appDictionary completion:^(NSError * _Nullable error) {
            if(error){
                NSLog(@"Error: %@", error);
            }
            else{
                NSLog(@"App %@ was uploaded successfully", appNames[i]);
            }
        }];
    }
}

- (void) uploadSampleEvents{
    //Create Data Reference
    __block FIRCollectionReference *ref = [self.db collectionWithPath:@"Events"];
                                         
    NSArray *eventNames = @[@"MLB: Kansas City Royals @ Milwaukee Brewers", @"SingSpace Sing With Devs", @"Mingle and Chill", @"Late Sea Live on Endless Riff", @"Gotham Comedy Live", @"Gotham Comedy LIVE in NextVR", @"Rocket Party: SpaceX/CRS-15", @"Friday Night Dogfight - EU Time Zones", @"Free-to-play Social Poker Tournament", @"Friday Night Dogfight - NA Time Zones", @"Sci-fi Night: Anshar Online!", @"Catan VR Saturday"];
    NSArray *eventStartDateStrings = @[@"2018/06/27 14:10", @"2018/06/27 15:00", @"2018/06/27 20:00", @"2018/06/27 22:45", @"2018/06/28 22:00", @"2018/06/28 22:00", @"2018/06/29 05:15", @"2018/06/29 12:00", @"2018/06/29 22:00", @"2018/06/29 23:00", @"2018/06/30 13:00", @"2018/06/30 16:00"];
    NSMutableArray *eventStartDates = [[NSMutableArray alloc] init];
    for (NSString *dateString in eventStartDateStrings){
        NSDate *date = [self.dateManager createDateFromString: dateString];
        [eventStartDates addObject: date];
    }
    NSArray *eventEndDateStrings = @[@"2018/06/27 23:59", @"2018/06/27 23:59", @"2018/06/27 23:59", @"2018/06/27 23:59", @"2018/06/28 23:59", @"2018/06/28 23:59", @"2018/06/29 23:59", @"2018/06/29 23:59", @"2018/06/29 23:59", @"2018/06/29 23:59", @"2018/06/30 23:59", @"2018/06/30 23:59"];
    NSMutableArray *eventEndDates = [[NSMutableArray alloc] init];
    for (NSString *dateString in eventEndDateStrings){
        NSDate *date = [self.dateManager createDateFromString: dateString];
        [eventEndDates addObject: date];
    }
    NSArray *eventVenues = @[@"Oculus Venues", @"SingSpace", @"AltspaceVR", @"Endless Riff", @"Oculus Venues", @"Next VR - Sports and Entertainment", @"AltspaceVR", @"Overflight", @"Poker VR", @"Overflight", @"Anshar Online", @"Catan VR"];
    NSArray *eventImages = @[@"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @"", @""];
    NSArray *eventDetails = @[@"Watch the Royals face the Brewers in Milwaukee.", @"Sing with Harmonix, the developers of SingSpace! Look for the Karaoke room hosted by 'HarmonixTeam' to join and sing your heart out.", @"Mingle and Chill is a weekly event where you get to meet Keegan, your friendly neighborhood bard and newsletter-write\n\nHang out with some AltspaceVR team members and meet people from our community.\n\nNew people are very welcome!", @"Late Sea performs live from New York City's Rockwood Music Hall Wednesday, June 27 at 10:45pm ET.", @"Don't miss this opportunity to be a part of a live virtual reality event with Oculus & Next VR.\n\nThe Gotaham All-Stars Show is a professional Showcase featuring comics from the 'Tonight Show with Jimmy Fallon', 'Late Night with Seth Myers', 'The Late Show', 'The Daily Show', Conan on TBS, Comedy Central, HBO and various TV shows and films.", @"Stand up comedy in immersive 3D virtual reality, live from New York. Grab the best seat in the house at this iconic club every Thursday night in the NextVR app.", @"Ever wanted to see an explosion go only in one direction? Come see a rocket launch! We're watching the live stream from Florida.\n\n* Rocket: SpaceX Falcon 9\n* Payload: Dragon Capsule + supplies and experiments, bound for the International Space Station\n* Destination: Low Earth Orbit (LEO)\n* Launch site: SLC-40, Cape Canaveral, FL\n* Booster previous flight count: 1 [TESS]\n* Landing attempt: No\n* Launch window: Friday June 29th 2018, 05:41 EDT", @"This event is for EU Time Zones.\n\nJoin the Friday night dogfight in Overflight. Take to the skies and challenge friends and community members alike as you pilot your way through a breathtaking virtual world.", @"Just download our free-to-play game and join this costless social poker tournament!\nSurvive the field, have fun and win this prestigious event!\n\nPoker tournaments are a great way to show off your competitive poker skills and to meet new people in VR.\n\nDon't forget to join our Discord community at http://discord.gg/PokerVR !\n\nRules of the game:\nBuyin: Freeroll\nStarting Stack: 5,000 chips\nBlinds increase every 5 min\nPrize Pool: 190,000 chips - 35k 1st, 30k 2nd, 25k, 3rd. 20k 4th and 5th. 15k 6th and 7th. 10k 8th 9th and 10th.\n\nLate registration open for 30 min.", @"This event is for NA Time Zones.\n\nJoin the Friday night dogfight in Overflight. Take to the skies and challenge friends and community members alike as you pilot your way through a breathtaking virtual world.", @"Wanna have fun on Saturday?\n Head to Anshar Online gathering on Saturday 30 June from 7-9pm CET. It's party time! Don't forget to join the event!", @"Join us for Catan VR Saturdays!\nPlay some games, meet new friends and, trade sheep for wood and display your settling skills.\n\nThe fun begins at 1m PST / 4pm EST / 9pm GMT and lasts until everything's settled."];
    NSArray *eventInterestedCount = @[@814, @50, @150, @19, @835, @128, @715, @69, @49, @17, @16, @74];
    
    NSDictionary *eventDictionary;
    for (int i = 0; i < eventNames.count; i++) {
        NSString *objectId = [[ref documentWithAutoID] documentID];
        eventDictionary = @{@"objectId": objectId,
                            @"createdAt": [NSDate date],
                            @"updatedAt": [NSDate date],
                            @"name": eventNames[i],
                            @"startDate": eventStartDates[i],
                            @"endDate": eventEndDates[i],
                            @"venue": eventVenues[i],
                            @"image": eventImages[i],
                            @"details": eventDetails[i],
                            @"interestedCount": eventInterestedCount[i],
                            };
        //Upload Data
        [[ref documentWithPath:objectId] setData:eventDictionary completion:^(NSError * _Nullable error) {
            if(error){
                NSLog(@"Error: %@", error);
            }
            else{
                NSLog(@"Event %@ was uploaded successfully", eventNames[i]);
            }
        }];
    }
}

- (void) uploadSampleNotifications{
    //Create Data Reference
    __block FIRCollectionReference *ref = [self.db collectionWithPath:@"Notifications"] ;
    
    NSArray *notificationTitles = @[@"Join the event in Oculus Venues now"];
    NSArray *notificationPaths = @[@"zcaa1rM8t1R7BRc1KyPOn7y7Wud2"];//Path is the objectId for notification receiver
    NSArray *notificationUserIds = @[[NSNull null]];
    NSArray *notificationUserImages = @[@"https://firebasestorage.googleapis.com/v0/b/ticketmaster-23010.appspot.com/o/OculusAssets%2Fbrand%2FoculusStadiumSmall.png?alt=media&token=9315a501-78e1-4171-acd5-60532472f0ec"];
    NSArray *notificationMessages = @[@"MLB: Kansas City Royals @ Milwaukee Brewers is starting!"];
    NSArray *notificationEventIds = @[@"SIP36cfTdQnn1wArGOCg"];
    
    NSDictionary *notificationDictionary;
    for (int i = 0; i < notificationTitles.count; i++) {
        NSString *objectId = [[ref documentWithAutoID] documentID];
        notificationDictionary = @{@"objectId": objectId,
                                    @"createdAt": [NSDate date],
                                    @"updatedAt": [NSDate date],
                                    @"userId": notificationUserIds[i],
                                    @"userImage": notificationUserImages[i],
                                    @"title": notificationTitles[i],
                                    @"message": notificationMessages[i],
                                    @"eventId": notificationEventIds[i],
                                    @"isUnread": @false
                                    };
        //Upload Data
        [[[[ref documentWithPath:notificationPaths[i]] collectionWithPath:@"Notifications"]documentWithPath: objectId] setData:notificationDictionary completion:^(NSError * _Nullable error) {
            if(error){
                NSLog(@"Error: %@", error);
            }
            else{
                NSLog(@"Notification %@ was uploaded successfully", notificationTitles[i]);
            }
        }];
    }
}

@end
