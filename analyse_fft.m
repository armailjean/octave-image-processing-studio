function analyse_fft(ax)
    img = getappdata(ax, 'Image');
    if isempty(img)
      errordlg('Image manquante');
      return;
    end
    if size(img,3) == 3
      img = rgb2gray(img);
    end
    F = fft2(double(img));
    Fshift = fftshift(F);
    magnitude = log(1 + abs(Fshift));

    figure('Name', 'Spectre de Fourier');
    imshow(magnitude, []);
    title('Spectre en magnitude (log(1+|F|))');
end

