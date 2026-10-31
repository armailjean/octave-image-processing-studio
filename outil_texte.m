 function outil_texte(ax)
        img = getappdata(axes_traite,'Image');
        if isempty(img), errordlg('Aucune image.'); return; end
        push_history(img);
        setappdata(axes_traite,'Future',{});

        prompt = {'Texte à ajouter :','Taille police (ex:20):','Couleur (r g b entre 0 et 1, ex: 1 1 1):'};
        def = {'Texte','24','1 1 1'};
        answ = inputdlg(prompt,'Ajouter Texte',1,def);
        if isempty(answ), return; end

        txt = answ{1};
        fontsize = str2double(answ{2});
        if isnan(fontsize) || fontsize <= 0, fontsize = 20; end
        col = str2num(answ{3}); %#ok<ST2NM>
        if isempty(col) || numel(col)~=3, col = [1 1 1]; end

        axes(axes_traite); imshow(img);
        title('Cliquez pour positionner le texte');
        [x,y] = ginput(1);
        hold(axes_traite,'on');
        % place text on axes (visible)
        th = text(axes_traite, x, y, txt, 'Color', col, 'FontSize', fontsize, ...
            'FontWeight','bold', 'Interpreter','none', 'HorizontalAlignment','left');
        drawnow;

        % capture axes contents into image and save
        % IMPORTANT: on certains systèmes getframe peut capturer fond blanc ; on restaure background pour capturer correctement
        set(fig,'Color','black'); % try to avoid white margin
        pause(0.05);
        frame = getframe(axes_traite);
        img_with_text = frame2im(frame);
        % restore fig color
        set(fig,'Color',[0.95 0.95 0.95]);

        % ensure same class
        if isinteger(img), img_with_text = im2uint8(im2gray(im2double(img_with_text))); end

        % push to history and set
        push_history(img);
        setappdata(axes_traite,'Image',img_with_text);
        axes(axes_traite); imshow(img_with_text);
        hold(axes_traite,'off');
        set_info('Texte ajouté');
    end
