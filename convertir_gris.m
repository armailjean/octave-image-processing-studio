
  %---Action convertir_gris---
function convertir_gris(axes_originale, axes_traite);
    img = getappdata(axes_originale,'Image');
    if isempty(img)
      errordlg('Veuillez d''abord changer une image.');
      return;
    end
    if size (img, 3) == 3
        img_gray = rgb2gray(img);
    else
        img_gray = img;
    end
    axes(axes_traite);
    imshow(img_gray);
    setappdata(axes_traite, 'Image', img_gray);


    stack = getappdata(axes_traite, 'History');
  if isempty(stack)
    stack = {};
  end
  stack{end+1} = img;
  setappdata(axes_traite, 'History',stack);

  axes(axes_traite);
  imshow(img_gray);
  setappdata(axes_traite, 'Image', img_gray); %pour exporter_image
end
