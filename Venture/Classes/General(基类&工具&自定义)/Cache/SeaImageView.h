//
//  SeaImageView.h

//
//

#import <UIKit/UIKit.h>

//图片没加载前默认背景颜色
#define _SeaImageBackgroundColorBeforeDownload_ [UIColor colorWithRed:240.00f / 255.0f green:240.00f / 255.0f blue:240.00f / 255.0f alpha:0.5]

@class SeaImageView;

/**用于自动异步加载图片代理
 */
@protocol SeaImageViewDelegate <NSObject>

@optional

/**图片加载完成
 *@param image 新加载完成的图片
 */
- (void)imageView:(SeaImageView*) imageView didFinishLoadImage:(UIImage*) image;

@end

/**用于自动异步加载图片，并缓存，显示的图片会自动根据frame 生成缩略图
 */
@interface SeaImageView : UIImageView

@property(nonatomic,assign) id<SeaImageViewDelegate> delegate;

/**是否正在加载图片
 */
@property(nonatomic,readonly) BOOL loading;

/**图片服务器路径
 */
@property(nonatomic,strong) NSString *imageURL;

/**缩略图大小 default is 'frame.size',如果值 为CGSizeZero表示不使用缩略图
 */
@property(nonatomic,assign) CGSize thumbnailSize;

/**显示加载指示器，当加载图片时 default is 'NO'
 */
@property(nonatomic,assign) BOOL showLoadingActivity;

/**加载指示器样式 default is 'UIActivityIndicatorViewStyleGray'
 */
@property(nonatomic,assign) UIActivityIndicatorViewStyle activityIndicatorViewStyle;

/**未加载图片显示的内容
 */
@property(nonatomic,strong) UIColor *placeHolderColor;

/**未加载时显示的图片 default is 'nil'
 */
@property(nonatomic,strong) UIImage *placeHolderImage;

/**加载图片
 *@param imageURL 图片服务器路径
 *@param flag 是否使用本地缓存
 */
- (void)getImageWithURL:(NSString*) imageURL useCache:(BOOL) flag;

/**加载图片 return [self getImageWithURL:imageURL useCache:YES]
 */
- (void)getImageWithURL:(NSString*) imageURL;

@end
