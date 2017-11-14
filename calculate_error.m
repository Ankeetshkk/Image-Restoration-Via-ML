function calculate_error = calculate_error(x,y,s)


if (strcmp(s,'a'))
calculate_error = abserr(x,y);
elseif (strcmp(s,'m'))
calculate_error = mse(x,y);
elseif (strcmp(s,'p'))
calculate_error = psnr(x,y); %% Function from PyreToolbox
elseif (strcmp(s,'s'))
calculate_error = SNR(x,y); %% Function from Wavelab
else
error(['option s = ',s, 'is not supported. Possible', ...
'options are p, m, s, or a']);
end
