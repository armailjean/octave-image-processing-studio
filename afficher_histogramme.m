function afficher_histogramme(ax)
      img = getappdata(ax, 'Image');
      if isempty(img)
        errordlg('Aucune image traitee');
        return
      end

      if size(img,3) == 3
        img = rgb2gray(img);
      end
      figure('Name', 'Histogramme');
      imhist(img);
end

