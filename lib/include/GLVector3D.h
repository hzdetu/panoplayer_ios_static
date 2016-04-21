//
//  GLVector3D.h
//  PanoPlayer
//
//  Created by qiruisun on 15/10/27.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GLVector3D : NSObject

/// x component of the Vector3D.
@property (nonatomic, assign) float x;
/// y component of the Vector3D.
@property (nonatomic, assign) float y;
/// z component of the Vector3D.
@property (nonatomic, assign) float z;
/// w component (Homogenous coordinate)
@property (nonatomic, assign) float w;

/*!
 Initialize a vector with each component.
 @param x x component.
 @param y y component.
 @param z z component.
 
 @returns a Vector3D.
 */
- (id)initX:(float)x Y:(float)y Z:(float)z;

/*!
 Dot product bewtween vectors.
 
 @param otherVector the other vector used in multiplication.
 
 @returns a float as result of the dot product.
 */
- (float)dot:(GLVector3D *)otherVector;

/*!
 Product Vector * Scalar
 
 @param scalar the scalar used in the product.
 
 @returns a Vector multiplied with the scalar received as parameter.
 */
- (GLVector3D *)productWithScalar:(float)scalar;

/*!
 Product component * component Vector.
 
 @param otherVector the other vector used in the product.
 
 @returns a Vector with each component is the product of the components of the two vector.
 */
- (GLVector3D *)pprod:(GLVector3D *)otherVector;

/*!
 Normalize the Vector.
 */
- (void)normalize;

/*!
 Magnitude of the vector.
 */
- (float)magnitude;

/*!
 Difference between vector.
 
 @param otherVector the other vector used in the difference.
 
 @returns a difference Vector.
 */
- (GLVector3D *)diff:(GLVector3D *)otherVector;

/*!
 Sum between vector.
 
 @param otherVector the other vector used in the sum.
 
 @returns a sum Vector.
 */
- (GLVector3D *)sum:(GLVector3D *)otherVector;

/*!
 Cross product between vectors.
 
 @param otherVector the other vector used in the cross product.
 
 @returns a Vector3D
 */
- (GLVector3D *)cross:(GLVector3D *)otherVector;

@end
