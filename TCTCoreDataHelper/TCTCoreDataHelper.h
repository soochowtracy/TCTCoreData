//
//  TCTCoreDataHelper.h
//  TCTravel_IPhone
//
//  Created by Tracyone on 15/4/27.
//
//

#import <Foundation/Foundation.h>

@interface TCTCoreDataSortOption : NSObject

@property (nonatomic, copy, readonly) NSString *sortOptionKey;
@property (nonatomic, readonly) BOOL sortOptionAcsend;

+ (instancetype)coreDataSortOptionWithKey:(NSString *)key isAcsend:(BOOL)acsend;

@end

@interface TCTCoreDataHelper : NSObject

/**
 *  单🍐大家都懂得
 *
 *  @return 返回了一个对象
 */
+ (instancetype)sharedHelper;

- (NSArray *)searchAllByEntity:(NSString *)entityName;
- (NSArray *)searchAllByEntity:(NSString *)entityName where:(NSString *)conditionName;
- (NSArray *)searchAllByEntity:(NSString *)entityName orderByOptions:(NSArray *)options;

/**
 *  这个是所有查询方法的祖宗，请详细阅读一下各个参数的姿势
 *
 *  @param entityName    你TM想查的某个对象的entityName，千万别拼错，后果很严重
 *  @param conditionName 这个就是条件，也就是NSPredicate的Format，举个🌰  predicate.predicateFormat
 *  @param options       这个是姿势最牛逼的，千万要注意。 key：对应了你想要按照对象的哪个属性排序， value：对应了是否升序（@YES）还是降序（@NO
 *
 *  @return 返回的是一个数组哦，有可能是空（就是查询出错了）
 */
- (NSArray *)searchAllByEntity:(NSString *)entityName where:(NSString *)conditionName orderByOptions:(NSArray *)options;

/**
 *  删除某个对象，最后需要手动save
 *
 *  @param managedObject 具体的某个对象
 */
- (void)deleteAllByManagedObject:(NSManagedObject *)managedObject;

/**
 *  批量删除某个对象，最后需要手动save
 *
 *  @param managedObjects 该对象的集合
 */
- (void)deleteAllByManagedObjects:(NSArray *)managedObjects;

/**
 *  添加，创建对象并返回该对象，修改完属性后 需要手动save。
 *
 *  @param entityName 某个对象的entityName
 *
 *  @return 返回某个对象
 */
- (id)insertByEntity:(NSString *)entityName;

/**
 *  保存到数据库中
 *
 *  @return 是否成功
 */
- (BOOL)save;

@end

/**
 *  这里的都是便捷用法，随便用，甭客气
 */
@interface TCTCoreDataHelper (TCTExtendedCoreDataHelper)

//+ (TCTCoreDataSortOption *)sortOptionWithDictionary:(NSDictionary *)dictionary;
+ (TCTCoreDataSortOption *)sortOptionWithkey:(NSString *)key isAcsend:(BOOL)acsend;

+ (NSArray *)searchAllByEntity:(NSString *)entityName;
+ (NSArray *)searchAllByEntity:(NSString *)entityName where:(NSString *)conditionName;
+ (NSArray *)searchAllByEntity:(NSString *)entityName orderByOptions:(NSArray *)options;
+ (NSArray *)searchAllByEntity:(NSString *)entityName where:(NSString *)conditionName orderByOptions:(NSArray *)options;

+ (void)deleteAllByManagedObject:(NSManagedObject *)managedObject;
+ (void)deleteAllByManagedObjects:(NSArray *)managedObjects;

+ (id)insertByEntity:(NSString *)entityName;

+ (BOOL)save;
@end
