function filtrer_lissage(ax)
  img = getappdata(ax, 'Image');
  if isempty(img)
    errordlg('Image manquante');
    return;
  end

  h = fspecial('average', [5 5]); %Filtre moyen 5x5
  img_filtree = imfilter(img, h);

  stack = getappdata(ax, 'History');
    if isempty(stack)
    stack = {}; end
    stack{end+1} = img;
    setappdata(ax, 'History', stack);

  axes(ax);
  imshow(img_filtree);
  setappdata(ax, 'Image', img_filtree);
end
