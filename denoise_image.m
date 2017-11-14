function denoise_image = denoise_image(imn, options, sigma, errtype, plot, im, dna)

type = 'null';

switch errtype
case 'm', errname = 'MSE';
case 'p', errname = 'PSNR';
case 'a', errname = 'ABS';
case 's', errname = 'SNR';
otherwise, display('Unknown method, see help');
end


% function returns list of errors for each method
denoise_image = [];

%% Find out how many methods
[t,NumMethods] = size(options);


% Iterate through all the methods
wnam_old = 'null';
decl_old = 0;
figcnt = 0;

for method = 1:NumMethods


params = options(method).params;
switch lower(options(method).name)

%% Universal Threshold method

case 'visu'
% Parse the parameters
if (~isfield(params,'incd')), incd = 0;
else incd = params.incd; end
if (~isfield(params,'type')), type = 'soft';
else type = params.type; end
if (~isfield(params,'wnam')), wnam = 'db8';
else wnam = params.wnam; end
if (~isfield(params,'decl')), decl = 4;
else decl = params.decl; end

% decompose the image if necessary
if (~strcmp(wnam_old,wnam) || decl_old ~= decl)
if (strcmp(wnam,'tetr'))
[C,L,B] = tetrom2(imn,decl);
else
[C,L] = wavedec2(imn,decl,wnam);
end
wnam_old = wnam;
decl_old = decl;
end

% Wavelet thresholding
if (strcmp(type,'hard'))
opt.type = 'visu_hard';
else
opt.type = 'visu_soft';
end
opt.incd = incd;
opt.sigma = sigma;
CT = perform_wavelet_thresholding(C,L,opt);
clear opt;

% Reconstruct the image

im_hat = waverec2(CT,L,wnam);


% calculate error if original image is given
if (~strcmp(im,'null'))
err = calculate_error(im,im_hat,errtype);
end
denoise_image = [denoise_image; collect_image_statistics(im,im_hat)];

% Plot the image
fname = strcat(lower(options(method).name),'-',type);
if (plot)

  
figure,
imshow(im_hat,[],'Border','loose'),
title([wnam,' Universal thresholding (', type,') with ', errname, ' = ' num2str(err,'%.2f') ' dB'],'fontsize',10,...
    'fontweight','bold');
end

if (dna)
t = strcat(fname,'  method noise');
%method_noise(im, im_hat, t);
end

%% sure Threshold method

case 'sure'
% Parse the parameters
if (~isfield(params,'incd')), incd = 0;
else incd = params.incd; end
if (~isfield(params,'wnam')), wnam = 'db8';
else wnam = params.wnam; end
if (~isfield(params,'decl')), decl = 4;
else decl = params.decl; end

% decompose the image if necessary
if (~strcmp(wnam_old,wnam) || decl_old ~= decl)
if (strcmp(wnam,'tetr'))
[C,L,B] = tetrom2(imn,decl);
else
[C,L] = wavedec2(imn,decl,wnam);
end
wnam_old = wnam;
decl_old = decl;
end



% Wavelet thresholding
opt.type = 'sure';
opt.incd = incd;
opt.sigma = sigma;
CT = perform_wavelet_thresholding(C,L,opt);
clear opt;

% Reconstruct the image
if (strcmp(wnam,'tetr'))
im_hat = invtetrom2(CT,L,B);
else
im_hat = waverec2(CT,L,wnam);
end

% calculate error if original image is given
if (~strcmp(im,'null'))
err = calculate_error(im,im_hat,errtype);
end
denoise_image = [denoise_image; collect_image_statistics(im,im_hat)];

% Plot the image
fname = strcat(lower(options(method).name),'-');
if (plot)

figure,
imshow(im_hat,[],'Border','loose'),
title([wnam,' Sure thresholding with ', errname, ' = ' num2str(err,'%.2f') ' dB'],'fontsize',10,...
    'fontweight','bold');
end



%% Bayes Threshold method

case 'bayes'
% Parse the parameters
if (~isfield(params,'incd')), incd = 0;
else incd = params.incd; end
if (~isfield(params,'wnam')), wnam = 'db8';
else wnam = params.wnam; end
if (~isfield(params,'decl')), decl = 4;
else decl = params.decl; end

% decompose the image if necessary
if (~strcmp(wnam_old,wnam) || decl_old ~= decl)
if (strcmp(wnam,'tetr'))
[C,L,B] = tetrom2(imn,decl);
else
[C,L] = wavedec2(imn,decl,wnam);
end
wnam_old = wnam;
decl_old = decl;
end

% Wavelet thresholding
opt.type = 'bayes';
opt.incd = incd;
opt.sigma = sigma;
CT = perform_wavelet_thresholding(C,L,opt);
clear opt;

% Reconstruct the image

im_hat = waverec2(CT,L,wnam);


% calculate error if original image is given
if (~strcmp(im,'null'))
err = calculate_error(im,im_hat,errtype);
end
denoise_image = [denoise_image; collect_image_statistics(im,im_hat)];

% Plot the image
fname = strcat(lower(options(method).name),'-');

if (plot)

figure,
imshow(im_hat,[],'Border','loose'),
title([wnam,' Bayes thresholding with ', errname, ' = ' num2str(err,'%.2f') ' dB'],'fontsize',10,...
    'fontweight','bold');
end





otherwise, display('Unknown method, see help');

end
end
