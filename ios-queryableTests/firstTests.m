//
//  firstTests.m
//  ios-queryable
//
//  Created by Marty on 2012-11-09.
//  Copyright (c) 2012 Marty. All rights reserved.
//

#import "firstTests.h"
#import "Product.h"

@implementation firstTests

- (void)test_first_returns_object_if_object_exists
{
    NSManagedObjectContext* context = [self getContext];
    IQueryable* queryable = [[context ofType:@"Product"] orderBy:@"name"];
    
    Product* product = [queryable first];
    STAssertEqualObjects(product.name, @"Apple", @"Expected name of Apple");
}

- (void)test_first_with_predicate_returns_object_if_object_exists
{
    NSManagedObjectContext* context = [self getContext];
    IQueryable* queryable = [[context ofType:@"Product"] orderBy:@"name"];
    
    Product* product = [queryable first:@"name like 'A*'"];
    STAssertEqualObjects(product.name, @"Apple", @"Expected name of Apple");
}

- (void)test_first_does_not_change_query
{
    NSManagedObjectContext* context = [self getContext];
    IQueryable* queryable = [[context ofType:@"Product"] orderBy:@"name"];
    
    Product* product = [queryable first];
    NSArray* allProducts = [queryable toArray];
    STAssertEquals(allProducts.count, self.testProductData.count, @"Expected an equal number of products");
}

- (void)test_first_throws_exception_if_object_does_not_exist
{
    NSManagedObjectContext* context = [self getContext];
    IQueryable* queryable = [[context ofType:@"User"] orderBy:@"name"];
    
    STAssertThrows([queryable first], @"Expected an exception to be thrown");
}

- (void)test_firstOrDefault_returns_object_if_object_exists
{
    NSManagedObjectContext* context = [self getContext];
    IQueryable* queryable = [[context ofType:@"Product"] orderBy:@"name"];
    
    Product* product = [queryable firstOrDefault];
    STAssertEqualObjects(product.name, @"Apple", @"Expected name of Apple");
}

- (void)test_firstOrDefault_with_predicate_returns_object_if_object_exists
{
    NSManagedObjectContext* context = [self getContext];
    IQueryable* queryable = [[context ofType:@"Product"] orderBy:@"name"];
    
    Product* product = [queryable firstOrDefault:@"name like 'A*'"];
    STAssertEqualObjects(product.name, @"Apple", @"Expected name of Apple");
}

- (void)test_firstOrDefault_returns_nil_if_object_does_not_exist
{
    NSManagedObjectContext* context = [self getContext];
    IQueryable* queryable = [[context ofType:@"User"] orderBy:@"name"];
    
    STAssertNil([queryable firstOrDefault], @"Expected result to be nil");
}

@end
