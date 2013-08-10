//
//  JPImageDownload.m
//  SuayHair
//
//  Created by Chirag Leuva on 4/5/13.
//  Copyright (c) 2013 Yudiz. All rights reserved.
//

#import "JPImageDownload.h"

@implementation JPImageDownload


+ (void)backgroundImageDownloadFromUrlString:(NSString*)urlString
                             ComplitionBlock:(void(^)(UIImage*))block
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        UIImage *img = [UIImage imageWithData:data];
        if(img) {
            block(img);
        }
    });
}


+ (void)backgroundImageDownloadFromUrlString:(NSString*)urlString
                                   IndexPath:(NSIndexPath*)indexPath
                                   Tableview:(UITableView*)tableView
                             ComplitionBlock:(void(^)(UIImage*))block
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        UIImage *img = [UIImage imageWithData:data];
        if(img) {
            
            UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
            if(cell)
                block(img);
        }
    });
}

- (void)lazyImageDownlaodFromUrlString:(NSString*)urlString
                             IndexPath:(NSIndexPath*)indexPath
                             Tabelview:(UITableView*)tableView
                       ComplitionBlock:(void(^)(UIImage*))block;
{
    self.indexPath = indexPath;
    self.tableView = tableView;
    ComplitionBlock = block;
    self.mutableData = [[NSMutableData alloc]init];
    NSURLRequest *requst = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:requst delegate:self];
    [connection start];
}


-(BOOL)isCellExistAnyMore
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.indexPath];
    
    if(cell)
        return YES;
    else
        return NO;
}


#pragma mark - Connection methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
//    if(![self isCellExistAnyMore]) {
//        [connection cancel];
//        self.mutableData  = nil;
//        ComplitionBlock = nil;
//        return;
//    }
    [self.mutableData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if(![self isCellExistAnyMore]) {
        [connection cancel];
        self.mutableData  = nil;
        ComplitionBlock = nil;
        return;
    }
    [self.mutableData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if(![self isCellExistAnyMore]) {
        [connection cancel];
        self.mutableData  = nil;
        ComplitionBlock = nil;
        return;
    }
	self.mutableData = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    if(![self isCellExistAnyMore]) {
        [connection cancel];
        self.mutableData  = nil;
        ComplitionBlock = nil;
        return;
    }
    
    UIImage *image = [UIImage imageWithData:self.mutableData];
    if(image)
        ComplitionBlock(image);
}


- (void)dealloc
{
    NSLog(@"ImageDownload Dealloc Called");
}

@end
