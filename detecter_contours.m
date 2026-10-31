
function detecter_contours(ax)
    img = getappdata(ax, 'Image');
    if isempty(img)
      errordlg('Image manquante');
    end
    img_original = img;
    if size(img,3) == 3
      img = rgb2gray(img);
    end
    contours = edge(img, 'sobel');

    %Historique
    stack = getappdata(ax, 'History');
    if isempty(stack), stack = {}; end
    stack{end+1} = img_original;
    setappdata(ax, 'History', stack);
    %--Reinitialiser pile Future--
    setappdata(ax,'Future', {});


    axes(ax);
    imshow(contours);
    setappdata(ax, 'Image', contours);
    end

