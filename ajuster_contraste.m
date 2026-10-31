function ajuster_contraste(ax, factor)
        img = getappdata(ax,'Image');
        if isempty(img), errordlg('Aucune image.'); return; end
        push_history(img);
        img_mod = imadjust(img, stretchlim(img), [], factor);
        setappdata(ax,'Image',img_mod);
        axes(ax); imshow(img_mod);
    end
