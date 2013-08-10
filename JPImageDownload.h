//
//  JPImageDownload.h
//  SuayHair
//
//  Created by Chirag Leuva on 4/5/13.
//  Copyright (c) 2013 Yudiz. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface JPImageDownload : NSObject <NSURLConnectionDataDelegate>{
    
    void (^ComplitionBlock) (UIImage*);
}


+ (void)backgroundImageDownloadFromUrlString:(NSString*)urlString
                             ComplitionBlock:(void(^)(UIImage*))block;

+ (void)backgroundImageDownloadFromUrlString:(NSString*)urlString
                                   IndexPath:(NSIndexPath*)indexPath
                                   Tableview:(UITableView*)tableView
                             ComplitionBlock:(void(^)(UIImage*))block;

- (void)lazyImageDownlaodFromUrlString:(NSString*)urlString
                             IndexPath:(NSIndexPath*)indexPath
                             Tabelview:(UITableView*)tableView
                       ComplitionBlock:(void(^)(UIImage*))block;

@property(nonatomic,weak) NSIndexPath *indexPath;
@property(nonatomic,weak) UITableView *tableView;
@property(nonatomic,strong) NSMutableData *mutableData;

@end
