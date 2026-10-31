function filtre_personnalise(ax)
    img = getappdata(ax, 'Image');
    if isempty(img)
      errordlg('Image manquante');
      return
    end

  %Historique
    stack = getappdata(ax, 'History');
    if isempty(stack), stack = {};end
    stack{end+1} = img;
    setappdata(ax, 'History', stack);


    prompt = {'Entrez les coefficients du filtre(ex: 0 -1 0; -1 5 -1; 0 -1 0)'};
    dlg_title = 'Filtre personnalise';
    answer = inputdlg(prompt,dlg_title);

    if isempty(answer)
      return;
    end
    try
     h = str2num(answer{1});



    img_filtree = imfilter(img,h, 'replicate');
    axes(ax);
    imshow(img_filtree);
    setappdata(ax, 'Image', img_filtree);
  catch
    errordlg('Filtre invalide');
  end
end
