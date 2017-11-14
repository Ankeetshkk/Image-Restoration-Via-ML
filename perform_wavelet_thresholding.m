function CT = perform_wavelet_thresholding(C,L,options)

%%% Parse options structure
options.null = 0;

if isfield(options, 'type')
type = options.type;
else
type = 'visu_hard';
end

if isfield(options, 'incd')
incd = options.incd;
else
incd = 0;
end

if isfield(options, 'sigma')
sigma = options.sigma;
else
sigma = 1;
end


switch lower(type)

case 'visu_hard'
CT = visu_threshold(C,L,incd,'Hard',sigma);
case 'visu_soft'
CT = visu_threshold(C,L,incd,'Soft',sigma);
case 'sure'
CT = sure_threshold(C,L,incd,sigma);
case 'bayes'
CT = bayes_threshold(C,L,incd,sigma);
otherwise
error(['Unknown option type = ',type]);
end
