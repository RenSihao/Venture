//
//  SeaImageView.m

//
//

#import "SeaImageView.h"
#import "SeaImageCacheTool.h"

@interface SeaImageView ()

/**加载指示器
 */
@property(nonatomic,strong) UIActivityIndicatorView *actView;

@end

@implementation SeaImageView

#pragma mark- init

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self initialization];
        [self setImage:nil];
    }
    return self;
}

- (id)initWithImage:(UIImage *)image
{
    self = [super initWithImage:image];
    if(self)
    {
        [self initialization];
    }
    return self;
}

/**初始化
 */
- (void)initialization
{
    self.opaque = NO;
    self.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    self.placeHolderColor = _SeaImageBackgroundColorBeforeDownload_;
    self.thumbnailSize = self.frame.size;
}

#pragma mark- dealloc

- (void)dealloc
{
    self.delegate = nil;
    
    [_actView stopAnimating];
    
    [[SeaImageCacheTool sharedInstance] cancelDownloadWithURL:_imageURL target:self];
}

#pragma mark- property

- (void)setImage:(UIImage *)image
{
    if(image == nil)
        image = self.placeHolderImage;
    
    [super setImage:image];
//    
//    if(!self.image)
//    {
//        self.backgroundColor = self.placeHolderColor;
//    }
//    else
//    {
//        self.backgroundColor = [UIColor clearColor];
//    }
}

//设置加载器样式
- (void)setActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)activityIndicatorViewStyle
{
    if(_activityIndicatorViewStyle != activityIndicatorViewStyle)
    {
        _activityIndicatorViewStyle = activityIndicatorViewStyle;
        self.actView.activityIndicatorViewStyle = _activityIndicatorViewStyle;
    }
}

#pragma mark- getImage

/**加载图片
 *@param imageURL 图片服务器路径
 *@param flag 是否使用本地缓存
 */
- (void)getImageWithURL:(NSString*) imageURL useCache:(BOOL) flag
{
    if([NSString isEmpty:imageURL])
    {
        [self setupLoading:NO];
        self.image = self.placeHolderImage;
        return;
    }
    
    SeaImageCacheTool *cache = [SeaImageCacheTool sharedInstance];
    
    //取消以前的下载
    [cache cancelDownloadWithURL:self.imageURL target:self];
    
    self.imageURL = imageURL;
    if([cache isRequestingWithURL:imageURL])
    {
        [self setupLoading:YES];
        [cache addCompletion:[self completionHandler] thumbnailSize:self.sea_thumbnailSize target:self forURL:imageURL];
        return;
    }
    
    //判断内存中是否有图片
    UIImage *thumbnail = [cache imageFromMemoryWithURL:imageURL thumbnailSize:self.thumbnailSize];
    
    if(thumbnail && [self.delegate respondsToSelector:@selector(imageView:didFinishLoadImage:)])
    {
        [self setupLoading:NO];
        self.image = thumbnail;
        [self.delegate imageView:self didFinishLoadImage:thumbnail];
    }
    
    if(!thumbnail)
    {
        [self setupLoading:YES];
        //重新加载图片
        [cache getImageWithURL:imageURL thumbnailSize:self.thumbnailSize completion:[self completionHandler] target:self];
    }
}

//图片加载完成回调
- (SeaImageCacheToolCompletionHandler)completionHandler
{
    SeaImageCacheToolCompletionHandler completion = ^(UIImage *image ,BOOL fromNetwork){
        
        [self setupLoading:NO];
        
        //渐变效果
        if(fromNetwork)
        {
            CATransition *animation = [CATransition animation];
            animation.duration = kAnimatedDuration;
            animation.type = kCATransitionFade;
            [self.layer addAnimation:animation forKey:nil];
        }
        
        self.image = image;
        
        if([self.delegate respondsToSelector:@selector(imageView:didFinishLoadImage:)])
        {
            [self.delegate imageView:self didFinishLoadImage:image];
        }
    };
    
    return completion;
}

/**加载图片 return [getImageWithURL:imageURL useCache:YES]
 */
- (void)getImageWithURL:(NSString*) imageURL
{
    return [self getImageWithURL:imageURL useCache:YES];
}

//设置加载状态
- (void)setupLoading:(BOOL) loading
{
    if(_loading == loading)
        return;
    _loading = loading;
    
    if(_loading)
    {
        //优先使用预载图
        if(self.sea_placeHolderImage)
        {
            self.image = self.sea_placeHolderImage;
        }
        else
        {
            self.image = nil;
            self.backgroundColor = self.sea_placeHolderColor;
        }
    }
    
    if(self.showLoadingActivity)
    {
        if(_loading)
        {
            if(!_actView)
            {
                UIActivityIndicatorView *view = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:self.activityIndicatorViewStyle];
                view.center = CGPointMake(self.width / 2.0, self.height / 2.0);
                [self addSubview:view];
                self.actView = view;
            }
            
            [_actView startAnimating];
        }
        else
        {
            [_actView stopAnimating];
        }
    }
}

@end
