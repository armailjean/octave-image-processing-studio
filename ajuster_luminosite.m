 function ajuster_luminosite(ax, value)
        % compatible si tu veux appeler depuis les menus (conserve pour compat)
        img = getappdata(ax,'Image');
        if isempty(img), errordlg('Aucune image.'); return; end
        push_history(img);
        img_mod = double(img) + value;
        img_mod = uint8(min(max(img_mod,0),255));
        setappdata(ax,'Image',img_mod);
        axes(ax); imshow(img_mod);
    end
