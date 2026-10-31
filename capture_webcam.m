function capture_webcam(ax)
  try
    cam = webcam();
    img = snapshot(cam);
    clear cam;
    axes(ax);
    imshow(img);
    setappdata(ax, 'Image', img);
  catch
    errordlg('Webcam non disponible');
    end
  end

