function collect_image_statistics=collect_image_statistics(im, im_hat)
%
% Collect image statistics
% At present, It only collects errors.
% Returned value is a list with following enteries
% [<abs.error> <mse> <psnr> <snr>]

collect_image_statistics = [];

collect_image_statistics = [collect_image_statistics,...
calculate_error(im,im_hat,'a')];
collect_image_statistics = [collect_image_statistics,...
calculate_error(im,im_hat,'m')];
collect_image_statistics = [collect_image_statistics,...
calculate_error(im,im_hat,'p')];
collect_image_statistics = [collect_image_statistics,...
calculate_error(im,im_hat,'s')];
