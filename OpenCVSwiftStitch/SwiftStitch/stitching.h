//
//  stitching.h
//  CVOpenTemplate
//
//  Created by Foundry on 05/01/2013.
//  Copyright (c) 2013 Foundry. All rights reserved.
//

#ifndef CVOpenTemplate_Header_h
#define CVOpenTemplate_Header_h
#include <opencv2/opencv.hpp>

cv::Mat stitch (cv::vector <cv::Mat> & images);
double compare(cv::Mat &image0, cv::Mat &image1, int compare_method);


#endif
