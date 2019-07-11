//
//  QMemoryCache.m
//  DataStructure
//
//  Created by Qiang on 2019/1/29.
//  Copyright © 2019 Qiang. All rights reserved.
//

#import "QMemoryCache.h"
#import "pthread.h"
#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

#if __has_include("YYDispatchQueuePool.h")
#import "YYDispatchQueuePool.h"
#endif

#ifdef YYDispatchQueuePool_h
static inline dispatch_queue_t QmemoryCacheGetReleaseQueue() {
    return YYDispatchQueueGetForQOS(NSQualityOfServiceUtility);
}
#else
static inline dispatch_queue_t QmemoryCacheGetReleaseQueue {
    return dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0);
}
#endif

#define Lock (pthread_mutex_lock(&_lock))
#define Unlock (pthread_mutex_unlock(&_lock))

const void * id_to_void(id obj) {
    return (__bridge const void *)obj;
}

@interface QLinkedMapNode : NSObject {
    @package
    __unsafe_unretained QLinkedMapNode *_prev;
    __unsafe_unretained QLinkedMapNode *_next;
    id _key;
    id _value;
    NSUInteger _cost;
    NSTimeInterval _time;
}
@end

@implementation QLinkedMapNode
@end

@interface QLinkedMap : NSObject {
    @package
    CFMutableDictionaryRef _dic;
    NSUInteger _totalCost;
    NSUInteger _totalCount;
    QLinkedMapNode *_head;
    QLinkedMapNode *_tail;
    BOOL _releaseOnMainThread;
    BOOL _releaseAsynchronously;
}

/// Insert a node at head and update the total cost.
/// Node and node.key should not be nil.
- (void)insertNodeAtHead:(QLinkedMapNode *)node;

/// Bring a inner node to header.
/// Node should already inside the dic.
- (void)bringNodeToHead:(QLinkedMapNode *)node;

/// Remove a inner node and update the total cost.
/// Node should already inside the dic.
- (void)removeNode:(QLinkedMapNode *)node;

/// Remove tail node if exist.
- (QLinkedMapNode *)removeTailNode;

/// Remove all node in background queue.
- (void)removeAll;

@end

@implementation QLinkedMap

- (instancetype)init {
    self = [super init];
    if (self) {
        _dic = CFDictionaryCreateMutable(CFAllocatorGetDefault(), 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
        _releaseOnMainThread = NO;
        _releaseAsynchronously = YES;
    }
    return self;
}

- (void)dealloc {
    CFRelease(_dic);
}

- (void)insertNodeAtHead:(QLinkedMapNode *)node {
    CFDictionarySetValue(_dic, (__bridge const void *)node->_key, (__bridge const void *)node);
    _totalCost += node->_cost;
    _totalCount++;
    if (_head) {
        node->_next = _head;
        _head->_prev = node;
        _head = node;
    } else {
        _head = _tail = node;
    }
}

- (void)bringNodeToHead:(QLinkedMapNode *)node {
    if (_head == node) {
        return;
    }
    if (_tail == node) {
        _tail = node->_prev;
        _tail->_next = nil;
    } else {
        node->_prev->_next = node->_next;
        node->_next->_prev = node->_prev;
    }
    node->_next = _head;
    node->_prev = nil;
    _head->_prev = node;
    _head = node;
}

- (void)removeNode:(QLinkedMapNode *)node {
    CFDictionaryRemoveValue(_dic, id_to_void(node->_key));
    _totalCost -= node->_cost;
    _totalCount--;
    if (node->_next) {
        node->_next->_prev = node->_prev;
    }
    if (node->_prev) {
        node->_prev->_next = node->_next;
    }
    if (_head == node) {
        _head = node->_next;
    }
    if (_tail == node) {
        _tail = node->_prev;
    }
}

- (QLinkedMapNode *)removeTailNode {
    if (!_tail) {
        return nil;
    }
    QLinkedMapNode *tail = _tail;
    CFDictionaryRemoveValue(_dic, id_to_void(_tail->_key));
    _totalCost -= tail->_cost;
    _totalCount--;
    if (_head == _tail) {
        _head = _tail = nil;
    } else {
        _tail = _tail->_prev;
        _tail->_next = nil;
    }
    return tail;
}

- (void)removeAll {
    _totalCost = 0;
    _totalCount = 0;
    _head = _tail = nil;
    if (CFDictionaryGetCount(_dic) > 0) {
        CFMutableDictionaryRef holder = _dic;
        _dic = CFDictionaryCreateMutable(CFAllocatorGetDefault(), 0, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
        if (_releaseAsynchronously) {
            dispatch_queue_t queue = _releaseOnMainThread ? dispatch_get_main_queue() : QmemoryCacheGetReleaseQueue();
            dispatch_async(queue, ^{
                CFRelease(holder);
            });
        } else if (_releaseOnMainThread && !pthread_main_np()) {
            dispatch_async(dispatch_get_main_queue(), ^{
                CFRelease(holder);
            });
        } else {
            CFRelease(holder);
        }
    }
}

@end

@implementation QMemoryCache {
    pthread_mutex_t _lock;
    QLinkedMap *_lruMap;
    dispatch_queue_t _queue;
}

- (void)_trimRecursively {
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_autoTrimInterval * NSEC_PER_SEC)), dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        //todo
    });
}

- (void)_trimInBackground {
    dispatch_async(_queue, ^{
       //todo
    });
}

- (void)_trimToCost:(NSUInteger)costLimit {
    BOOL finish = NO;
    pthread_mutex_lock(&_lock);
    if (costLimit == 0) {
        [_lruMap removeAll];
        finish = YES;
    } else if (_lruMap->_totalCost <= costLimit) {
        finish = YES;
    }
    pthread_mutex_unlock(&_lock);
    if (finish) {
        return;
    }
    NSMutableArray *holder = [NSMutableArray array];
    while (!finish) {
        if (pthread_mutex_trylock(&_lock) == 0) {
            if (_lruMap->_totalCost > costLimit) {
                QLinkedMapNode *node = [_lruMap removeTailNode];
                if (node) {
                    [holder addObject:node];
                }
            } else {
                finish = YES;
            }
        } else {
            usleep(10 * 1000);
        }
    }
    if (holder.count) {
        dispatch_queue_t queue = _lruMap->_releaseOnMainThread ? dispatch_get_main_queue() : QmemoryCacheGetReleaseQueue();
        dispatch_async(queue, ^{
            //release in queue
            [holder count];
        });
    }
}

- (void)_trimToCount:(NSUInteger)countLimit {
    BOOL finish = NO;
    pthread_mutex_lock(&_lock);
    if (countLimit == 0) {
        [_lruMap removeAll];
        finish = YES;
    } else if (_lruMap->_totalCount <= countLimit) {
        finish = YES;
    }
    pthread_mutex_unlock(&_lock);
    if (finish) {
        return;
    }
    
    NSMutableArray *holder = [NSMutableArray array];
    while (!finish) {
        if (pthread_mutex_trylock(&_lock) == 0) {
            if (_lruMap->_totalCount > countLimit) {
                QLinkedMapNode *node = [_lruMap removeTailNode];
                if (node) {
                    [holder addObject:node];
                }
            } else {
                finish = YES;
            }
        } else {
            usleep(10 * 1000);
        }
    }
    if (holder.count) {
        dispatch_queue_t queue = _lruMap->_releaseOnMainThread ? dispatch_get_main_queue() : QmemoryCacheGetReleaseQueue();
        dispatch_async(queue, ^{
            [holder count];
        });
    }
}

- (void)_trimToAge:(NSTimeInterval)ageLimit {
    BOOL finish = NO;
    NSTimeInterval now = CACurrentMediaTime();
    pthread_mutex_lock(&_lock);
    if (ageLimit <= 0) {
        [_lruMap removeAll];
        finish = YES;
    } else if (!_lruMap->_tail || (now - _lruMap->_tail->_time) <= ageLimit) {
        finish = YES;
    }
    pthread_mutex_unlock(&_lock);
    if (finish) {
        return;
    }
    
    NSMutableArray *holder = [NSMutableArray array];
    while (!finish) {
        if (pthread_mutex_trylock(&_lock) == 0) {
            if (_lruMap->_tail && (now - _lruMap->_tail->_time) > ageLimit) {
                QLinkedMapNode *node = [_lruMap removeTailNode];
                if (node) {
                    [holder addObject:node];
                }
            } else {
                finish = YES;
            }
        } else {
            usleep(10 * 1000);
        }
    }
    if (holder.count) {
        dispatch_queue_t queue = _lruMap->_releaseOnMainThread ? dispatch_get_main_queue() : QmemoryCacheGetReleaseQueue();
        dispatch_async(queue, ^{
            [holder count];
        });
    }
}

- (void)_appDidReceiveMemoryWarningNotification {
    if (self.didReceiveMemoryWarningBlock) {
        self.didReceiveMemoryWarningBlock(self);
    }
    if (self.shouldRemoveAllObjectsOnMemoryWarning) {
        [self removeAllObjects];
    }
}

- (void)_appDidEnterBackgroundNotification {
    if (self.didEnterBackgroundBlock) {
        self.didEnterBackgroundBlock(self);
    }
    if (self.shouldRemoveAllObjectsWhenEnteringBackground) {
        [self removeAllObjects];
    }
}

#pragma mark - public methods

- (instancetype)init {
    self = [super init];
    if (self) {
        pthread_mutex_init(&_lock, NULL);
        _lruMap = [[QLinkedMap alloc] init];
        _queue = dispatch_queue_create("com.q.cache.memory", DISPATCH_QUEUE_SERIAL);
        _countLimit = NSUIntegerMax;
        _costLimit = NSUIntegerMax;
        _ageLimit = DBL_MAX;
        _autoTrimInterval = 5.0;
        _shouldRemoveAllObjectsOnMemoryWarning = YES;
        _shouldRemoveAllObjectsWhenEnteringBackground = YES;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_appDidReceiveMemoryWarningNotification) name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(_appDidEnterBackgroundNotification) name:UIApplicationDidEnterBackgroundNotification object:nil];
        //why trim in init method?
        [self _trimRecursively];
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidReceiveMemoryWarningNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
    [_lruMap removeAll];
    pthread_mutex_destroy(&_lock);
}

- (NSUInteger)totalCount {
    pthread_mutex_lock(&_lock);
    NSUInteger count = _lruMap->_totalCount;
    pthread_mutex_unlock(&_lock);
    return count;
}

- (NSUInteger)totalCost {
    pthread_mutex_lock(&_lock);
    NSUInteger totalCost = _lruMap->_totalCost;
    pthread_mutex_unlock(&_lock);
    return totalCost;
}

- (BOOL)releaseOnMainThread {
    pthread_mutex_lock(&_lock);
    BOOL releaseOnMainThread = _lruMap->_releaseOnMainThread;
    pthread_mutex_unlock(&_lock);
    return releaseOnMainThread;
}

- (void)setReleaseOnMainThread:(BOOL)releaseOnMainThread {
    pthread_mutex_lock(&_lock);
    _lruMap->_releaseOnMainThread = releaseOnMainThread;
    pthread_mutex_unlock(&_lock);
}

- (BOOL)releaseAsynchronously {
    pthread_mutex_lock(&_lock);
    BOOL releaseAsynchronously = _lruMap->_releaseAsynchronously;
    pthread_mutex_unlock(&_lock);
    return releaseAsynchronously;
}

- (void)setReleaseAsynchronously:(BOOL)releaseAsynchronously {
    pthread_mutex_lock(&_lock);
    _lruMap->_releaseAsynchronously = releaseAsynchronously;
    pthread_mutex_unlock(&_lock);
}

- (BOOL)containsObjectForKey:(id)key {
    if (!key) {
        return NO;
    }
    pthread_mutex_lock(&_lock);
    BOOL contains = CFDictionaryContainsKey(_lruMap->_dic, id_to_void(key));
    pthread_mutex_unlock(&_lock);
    return contains;
}

- (id)objectForKey:(id)key {
    if (!key) {
        return nil;
    }
    pthread_mutex_lock(&_lock);
    QLinkedMapNode *node = CFDictionaryGetValue(_lruMap->_dic, id_to_void(key));
    if (node) {
        node->_time = CACurrentMediaTime();
        [_lruMap bringNodeToHead:node];
    }
    pthread_mutex_unlock(&_lock);
    return node ? node->_value : nil;
}

- (void)setObject:(id)object forKey:(id)key {
    [self setObject:object forKey:key withCost:0];
}

- (void)setObject:(id)object forKey:(id)key withCost:(NSUInteger)cost {
    if (!key) {
        return;
    }
    if (!object) {
        [self removeObjectForKey:key];
        return;
    }
    pthread_mutex_lock(&_lock);
    QLinkedMapNode *node = CFDictionaryGetValue(_lruMap->_dic, id_to_void(key));
    NSTimeInterval now = CACurrentMediaTime();
    if (node) {
        _lruMap->_totalCost -= node->_cost;
        _lruMap->_totalCount += cost;
        node->_cost = cost;
        node->_time = now;
        node->_value = object;
        [_lruMap bringNodeToHead:node];
    } else {
        node = [QLinkedMapNode new];
        node->_cost = cost;
        node->_time = now;
        node->_key = key;
        node->_value = object;
        [_lruMap insertNodeAtHead:node];
    }
    if (_lruMap->_totalCost > _costLimit) {
        dispatch_async(_queue, ^{
            [self trimToCost:self->_costLimit];
        });
    }
    if (_lruMap->_totalCount > _countLimit) {
        QLinkedMapNode *node = [_lruMap removeTailNode];
        if (_lruMap->_releaseAsynchronously) {
            dispatch_queue_t queue = _lruMap->_releaseOnMainThread ? dispatch_get_main_queue() : QmemoryCacheGetReleaseQueue();
            dispatch_async(queue, ^{
                [node class];
            });
        } else if (_lruMap->_releaseOnMainThread && !pthread_main_np()) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [node class];
            });
        }
    }
    pthread_mutex_unlock(&_lock);
}

- (void)removeObjectForKey:(id)key {
    if (!key) {
        return;
    }
    pthread_mutex_lock(&_lock);
    QLinkedMapNode *node = CFDictionaryGetValue(_lruMap->_dic, id_to_void(key));
    if (node) {
        [_lruMap removeNode:node];
        if (_lruMap->_releaseAsynchronously) {
            dispatch_queue_t queue = _lruMap->_releaseOnMainThread ? dispatch_get_main_queue() : QmemoryCacheGetReleaseQueue();
            dispatch_async(queue, ^{
                [node class];
            });
        } else if (_lruMap->_releaseOnMainThread && !pthread_main_np()) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [node class];
            });
        }
    }
    pthread_mutex_unlock(&_lock);
}

- (void)removeAllObjects {
    pthread_mutex_lock(&_lock);
    [_lruMap removeAll];
    pthread_mutex_unlock(&_lock);
}

- (void)trimToCost:(NSUInteger)cost {
    [self _trimToCost:cost];
}

- (void)trimToCount:(NSUInteger)count {
    if (count == 0) {
        [self removeAllObjects];
        return;
    }
    [self _trimToCount:count];
}

- (void)trimToAge:(NSTimeInterval)age {
    [self _trimToAge:age];
}

- (NSString *)description {
    if (_name) return [NSString stringWithFormat:@"<%@: %p> (%@)", self.class, self, _name];
    else return [NSString stringWithFormat:@"<%@: %p>", self.class, self];
}

@end



























