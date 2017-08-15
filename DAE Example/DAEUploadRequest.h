/*
 Copyright 2010-2016 Amazon.com, Inc. or its affiliates. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License").
 You may not use this file except in compliance with the License.
 A copy of the License is located at

 http://aws.amazon.com/apache2.0

 or in the "license" file accompanying this file. This file is distributed
 on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
 express or implied. See the License for the specific language governing
 permissions and limitations under the License.
 */
 

#import <Foundation/Foundation.h>
#import <AWSCore/AWSCore.h>

 
@interface DAEUploadRequest : AWSModel
/**
 The unique identifier for a style [optional]
 */
@property (nonatomic, strong, nullable) NSString *styleId;

/**
 Base64 decoded image [optional]
 */
@property (nonatomic, strong, nullable) NSString *imageBase64Encoded;

/**
 Image size in px. Picture will be resized for processing. [optional]
 */
@property (nonatomic, strong, nullable) NSNumber *imageSize;

/**
 The unique identifier for a partner with dedicated api access. [optional]
 */
@property (nonatomic, strong, nullable) NSString *partnerId;

/**
 Use this flag to get an artwork optimized for print. [optional]
 */
@property (nonatomic, strong, nullable) NSNumber *optimizeForPrint;

/**
 Use this flag to use the original color from your photo for the artwork. [optional]
 */
@property (nonatomic, strong, nullable) NSNumber *useOriginalColors;


@end
