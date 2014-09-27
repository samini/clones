//
//  CVWrapper.m
//  CVOpenTemplate
//
//  Created by Washe on 02/01/2013.
//  Copyright (c) 2013 foundry. All rights reserved.
//

#import "CVWrapper.h"
#import "UIImage+OpenCV.h"
#import "stitching.h"


@implementation CVWrapper

+ (UIImage*) processImageWithOpenCV: (UIImage*) inputImage
{
    NSArray* imageArray = [NSArray arrayWithObject:inputImage];
    UIImage* result = [[self class] processWithArray:imageArray];
    return result;
}

+ (UIImage*) processWithOpenCVImage1:(UIImage*)inputImage1 image2:(UIImage*)inputImage2;
{
    NSArray* imageArray = [NSArray arrayWithObjects:inputImage1,inputImage2,nil];
    UIImage* result = [[self class] processWithArray:imageArray];
    return result;
}

+ (UIImage*) processWithArray:(NSArray*)imageArray
{
    if ([imageArray count]==0){
        NSLog (@"imageArray is empty");
        return 0;
        }
    cv::vector<cv::Mat> matImages;

    for (id image in imageArray) {
        if ([image isKindOfClass: [UIImage class]]) {
            cv::Mat matImage = [image CVMat3];
            NSLog (@"matImage: %@",image);
            matImages.push_back(matImage);
        }
    }
    NSLog (@"stitching...");
    cv::Mat stitchedMat = stitch (matImages);
    UIImage* result =  [UIImage imageWithCVMat:stitchedMat];
    return result;
}

//http://docs.opencv.org/doc/tutorials/imgproc/histograms/histogram_comparison/histogram_comparison.html
/*
 Method	Base - Base	Base - Half	Base - Test 1	Base - Test 2
 Correlation	1.000000	0.930766	0.182073	0.120447
 Chi-square	0.000000	4.940466	21.184536	49.273437
 Intersection	24.391548	14.959809	3.889029	5.775088
 Bhattacharyya	0.000000	0.222609	0.646576	0.801869
*/


//double compare(cv::Mat &image0, cv::Mat &image1, int compare_method);
+ (double) compareWithOpenCVImage1:(UIImage*) inputImage1 image2:(UIImage*)inputImage2 method:(int)compareMethod
{
    cv::Mat image0 = [inputImage1 CVMat3];
    cv::Mat image1 = [inputImage2 CVMat3];
    
    // compare_method 0 to 3
    return compare(image0, image1, compareMethod);
}


@end
