function main_principale()
    pkg load image;

%============== Fenetre principale =========
fig = figure ('Name', 'Traitement Image', 'NumberTitle','off',...
               'Position',[30 30 1300 600], 'Color',[0.95 0.95 0.95],'MenuBar','none');

     % -----Stockage état du thème
    setappdata(fig, 'theme_dark', true);

%============== Paneaux ====================
%--------------- Panel Originale -------------------
panel_originale = uipanel('Parent',fig,'Title','Image Originale',...
                          'Position',[0.72 0.01 0.26 0.6], 'BackgroundColor',[0.6 0.6 0.6],'FontWeight','bold');
axes_originale = axes('Parent',panel_originale,'Position',[0.08 0.08 0.84 0.84]);
%-------------- Panel Traitee ----------------------
panel_traite = uipanel('Parent',fig,'Title', 'Image Traitee',...
                       'Position',[0.205 0.12 0.51 0.875],'BackgroundColor',[0.9 0.95 0.95],'FontWeight','bold');
axes_traite = axes ('Parent',panel_traite,'Position',[0.06 0.06 0.88 0.88]);
%-------------  Panel  Outils/Sliders --------------
panel_outils_Slider = uipanel('Parent',fig,'Title','Outils & Sliders','Position', [0 0 0.205 0.995],...
                              'BackgroundColor', [0.2 0.4 0.4], 'ForegroundColor', 'white');
%------------- Panel Bouttons ----------------------
panel_bouttons = uipanel('Parent',fig,'Title','les Boutons','Position',[0.208 0.01 0.5091 0.1],...
                         'BackgroundColor', [0.2 0.4 0.4]);
%------------- Panel Infos -------------------------
panel_infos = uipanel('Parent',fig,'Title','Infos','Position',[0.72 0.74 0.26 0.256],...
                      'BackgroundColor', [0.2 0.4 0.4], 'ForegroundColor','white');

% ==================== AppData init =======================================
setappdata(axes_originale,'Image',[]);
setappdata(axes_originale,'History',{}); setappdata(axes_originale,'Future',{});
setappdata(axes_traite,'Image',[]);
setappdata(axes_traite,'History',{}); setappdata(axes_traite,'Future',{});

%================ Menu Bar ======================
%----------------Menu Fichier -----------------
menu_fichier = uimenu(fig,'Label','📁Fichier');
uimenu(menu_fichier,'Label','📁Charger Image','Callback',@(~,~) charger_image());
uimenu(menu_fichier,'Label','💾Exporter Image','Callback',@(~,~) exporter_image());
uimenu(menu_fichier,'Label','🚪Quitter','Separator','on','Callback',@(~,~) close(fig));
%------------- Menu Traitement ----------------
menu_Traitement = uimenu (fig,'Label','🛠Traitement');
uimenu(menu_Traitement,'Label','🎨Niveaux de gris', 'Callback', @(~,~) convertir_gris(axes_originale,axes_traite));
uimenu(menu_Traitement,'Label','🔄Rotation(90°)', 'Callback', @(~,~) rotation_image());
uimenu(menu_Traitement,'Label','✂Decouper', 'Callback', @(~,~) decouper_image());
uimenu(menu_Traitement,'Label','📏Redimensionner', 'Callback', @(~,~) redimensionner_image());
uimenu(menu_Traitement,'Label','Miroir Horizontal', 'Callback', @(~,~) miroir_image('h'));
uimenu(menu_Traitement,'Label','Miroir Vertical', 'Callback', @(~,~) miroir_image('v'));
%----------------- Menu Filtres --------------
menu_Filtres = uimenu(fig,'Label','🔍Filtres/Analyse');
uimenu(menu_Filtres,'Label','📊Histogramme','Callback',@(~,~) afficher_histogramme());
uimenu(menu_Filtres,'Label','🌟Lissage (Moyenne)','Callback',@(~,~) filtrer_lissage(axes_traite));
uimenu(menu_Filtres,'Label','🔲Lissage (Sobel)','Callback',@(~,~) detecter_contours(axes_traite));
uimenu(menu_Filtres,'Label','⚙️Filtre personnalise ...','Callback',@(~,~) filtre_personnalise(axes_traite));
uimenu(menu_Filtres,'Label','🌈Spetre FFT','Callback',@(~,~) analyse_fft(axes_traite));
    %---------------- Menu Affichage -------------
menu_Affichage = uimenu(fig,'Label','👁️ Affichage');
uimenu(menu_Affichage,'Label','🎨 Changer Thème','Callback',@(~,~) toggle_theme(fig, panel_originale, panel_traite, panel_outils_Slider, panel_bouttons,panel_infos));
uimenu(menu_Affichage,'Label','📐 Grille','Callback',@(~,~) toggle_grid());

%===================Les Bouttons ====================

incons_charger = imread ('charger.png');
incons_charger = imresize (incons_charger,[40,40]);
uicontrol('Parent',panel_bouttons,'Style','pushbutton','CData',incons_charger,'Position',[120 5 40 40],...
          'Callback',@(~,~) charger_image());

incons_exporter = imread ('exporte.png');
incons_exporter = imresize (incons_exporter,[40,40]);
uicontrol('Parent',panel_bouttons,'Style','pushbutton','CData',incons_exporter,'Position',[180 5 40 40],...
          'Callback',@(~,~) exporter_image());

incons_texte = imread ('text.png');
incons_texte = imresize (incons_texte,[40,40]);
uicontrol('Parent',panel_bouttons,'Style','pushbutton','CData',incons_texte,'Position',[240 5 40 40],...
          'Callback',@(~,~) outil_texte());

incons_negative= imread ('negative.png');
incons_negative = imresize (incons_negative,[40,40]);
uicontrol('Parent',panel_bouttons,'Style','pushbutton','CData',incons_negative,'Position',[300 5 40 40],...
          'Callback',@(~,~) image_negatif());

incons_histogramme = imread ('histogramme.png');
incons_histogramme = imresize (incons_histogramme,[40,40]);
uicontrol('Parent',panel_bouttons,'Style','pushbutton','CData',incons_histogramme,'Position',[360 5 40 40],...
          'Callback',@(~,~) afficher_histogramme());

incons_annuler = imread ('annuler.png');
incons_annuler = imresize (incons_annuler,[40,40]);
uicontrol('Parent',panel_bouttons,'Style','pushbutton','CData',incons_annuler,'Position',[420 5 40 40],...
          'Callback',@(~,~) annuler_traitement());

incons_refaire = imread ('refaire.png');
incons_refaire = imresize (incons_refaire,[40,40]);
uicontrol('Parent',panel_bouttons,'Style','pushbutton','CData',incons_refaire,'Position',[480 5 40 40],...
          'Callback',@(~,~) refaire_traitement());

          incons_reinitialise = imread ('reinitialise.png');
incons_reinitialise= imresize (incons_reinitialise,[40,40]);
uicontrol('Parent',panel_bouttons,'Style','pushbutton','CData',incons_reinitialise,'Position',[540 5 40 40],...
          'Callback',@(~,~) reinitialise_traitement());

% ========================= Sliders ET labels ========================
y = 0.88; htext = 0.05; hslider = 0.04; pad = 0.03;
% Luminosité label + slider
uicontrol('Parent', panel_outils_Slider,'Style','text','String','Luminosité',...
    'Units','normalized','Position',[0.03 y 0.42 htext], ...
    'BackgroundColor',[0.2 0.4 0.4],'ForegroundColor','white','FontWeight','bold');
s_lum = uicontrol('Parent', panel_outils_Slider, 'Style','slider',...
    'Units','normalized','Position',[0.03 y-hslider 0.94 hslider], ...
    'Min',-150,'Max',150,'Value',0, 'SliderStep',[0.01 0.1], ...
    'Callback',@(src,~) on_lum_change(get(src,'Value')));
% reset lum button
 reset = imread('reset.png');
 reset = imresize(reset,[40,40]);
uicontrol('Parent', panel_outils_Slider,'Style','pushbutton','CData',reset,'Units','normalized', ...
    'Position',[0.78 y+0.005 0.18 0.06], 'Callback',@(~,~) set(s_lum,'Value',0));

% Contraste label + slider
y = y - 0.16;
uicontrol('Parent', panel_outils_Slider, 'Style','text','String','Contraste', ...
    'Units','normalized','Position',[0.03 y 0.42 htext], ...
    'BackgroundColor',[0.2 0.4 0.4],'ForegroundColor','white','FontWeight','bold');
s_con = uicontrol('Parent', panel_outils_Slider, 'Style','slider', ...
    'Units','normalized','Position',[0.03 y-hslider 0.94 hslider], ...
    'Min',0.2,'Max',2.0,'Value',1.0, 'SliderStep',[0.01 0.1], ...
    'Callback',@(src,~) on_con_change(get(src,'Value')));
% reset cont button
uicontrol('Parent', panel_outils_Slider,'Style','pushbutton','CData',reset,'Units','normalized', ...
    'Position',[0.78 y+0.005 0.18 0.06], 'Callback',@(~,~) set(s_con,'Value',1.0));

% Isolation canaux R G B (3 sliders)
y = y - 0.18;
uicontrol('Parent', panel_outils_Slider,'Style','text','String','Canal Rouge', ...
    'Units','normalized','Position',[0.03 y 0.42 htext], ...
    'BackgroundColor',[0.2 0.4 0.4],'ForegroundColor','white','FontWeight','bold');
s_r = uicontrol('Parent', panel_outils_Slider,'Style','slider','Units','normalized','Position',[0.03 y-hslider 0.94 hslider], ...
    'Min',0,'Max',2,'Value',1,'SliderStep',[0.01 0.1], 'Callback',@(src,~) on_canal_change());

y = y - 0.18;
uicontrol('Parent', panel_outils_Slider,'Style','text','String','Canal Vert', ...
    'Units','normalized','Position',[0.03 y 0.42 htext], ...
    'BackgroundColor',[0.2 0.4 0.4],'ForegroundColor','white','FontWeight','bold');
s_g = uicontrol('Parent', panel_outils_Slider,'Style','slider','Units','normalized','Position',[0.03 y-hslider 0.94 hslider], ...
    'Min',0,'Max',2,'Value',1,'SliderStep',[0.01 0.1], 'Callback',@(src,~) on_canal_change());

y = y - 0.18;
uicontrol('Parent', panel_outils_Slider,'Style','text','String','Canal Bleu', ...
    'Units','normalized','Position',[0.03 y 0.42 htext], ...
    'BackgroundColor',[0.2 0.4 0.4],'ForegroundColor','white','FontWeight','bold');
s_b = uicontrol('Parent', panel_outils_Slider,'Style','slider','Units','normalized','Position',[0.03 y-hslider 0.94 hslider], ...
    'Min',0,'Max',2,'Value',1,'SliderStep',[0.01 0.1], 'Callback',@(src,~) on_canal_change());


%================= BOUTON THEME ======================

% ======================= Informations ===========================================
uicontrol('Parent', panel_infos,'Style','text','String','  🔍Info : Chargement d''image nécessaire', ...
    'Units','normalized','Position',[0.02 0.02 0.96 0.96], 'BackgroundColor',[0.2 0.4 0.4], ...
    'ForegroundColor','white', 'HorizontalAlignment','left', 'Tag','info_text');

% ======================= BOUTON THÈME =============================================================
    uicontrol('Parent',panel_infos,'Style','pushbutton','String','🌙 Changer Thème', ...
              'Units','normalized','Position',[0.2 0.73 0.6 0.25], ...
              'Callback',@(~,~) toggle_theme(fig, panel_originale, panel_traite, panel_outils_Slider, panel_bouttons,panel_infos));
% ======================== Appliquer thème par défaut ===============================================
    apply_theme(fig, panel_originale, panel_traite, panel_outils_Slider, panel_bouttons,panel_infos);

function toggle_theme(fig, panel_originale, panel_traite, panel_outils_Slider, panel_bouttons, panel_infos)
    current = getappdata(fig, 'theme_dark');
    setappdata(fig, 'theme_dark', ~current);
    apply_theme(fig, panel_originale, panel_traite, panel_outils_Slider, panel_bouttons, panel_infos);
end

function apply_theme(fig, panel_originale, panel_traite, panel_outils_Slider, panel_bouttons, panel_infos)
    if getappdata(fig, 'theme_dark')
        bg_main = [0.15 0.15 0.15]; bg_panel = [0.25 0.25 0.25]; txt_color = 'white';
    else
        bg_main = [0.95 0.95 0.95]; bg_panel = [0.85 0.85 0.85]; txt_color = 'black';
    end
    set(fig,'Color',bg_main);
    panels = {panel_originale, panel_traite, panel_outils_Slider, panel_bouttons, panel_infos};
    for k = 1:numel(panels)
        set(panels{k}, 'BackgroundColor', bg_panel, 'ForegroundColor', txt_color);
    end
    % recolore le texte d'info si présent
    txt = findobj(panel_infos, 'Tag', 'info_text');
    if ~isempty(txt)
        set(txt, 'ForegroundColor', txt_color, 'BackgroundColor', bg_panel);
    end
end


% === Helper: update info text ===
    function set_info(str)
        h = findobj(panel_infos,'Tag','info_text');
        if ~isempty(h), set(h,'String',['Info : ' str]); end
    end
    % === Les functions ===

    function charger_image()
        [f,p] = uigetfile({'*.png;*.jpg;*.jpeg;*.bmp;*.tif','Images'}, 'Choisir une image');
        if isequal(f,0), set_info('Aucun fichier choisi'); return; end
        img = imread(fullfile(p,f));
        axes(axes_originale); imshow(img); title('Original');
        axes(axes_traite); imshow(img); title('Traitee');
        setappdata(axes_originale,'Image',img);
        setappdata(axes_traite,'Image',img);
        % reset histories
        setappdata(axes_traite,'History',{}); setappdata(axes_traite,'Future',{});
        set_info(['Image chargée: ' f]);
    end

    function exporter_image()
        img = getappdata(axes_traite,'Image');
        if isempty(img), errordlg('Aucune image à exporter'); return; end
        [f,p] = uiputfile({'*.png','PNG (*.png)';'*.jpg','JPEG (*.jpg)';'*.bmp','BMP (*.bmp)'}, 'Enregistrer image');
        if isequal(f,0), return; end
        imwrite(img, fullfile(p,f));
        set_info(['Image exportée : ' f]);
    end

    function push_history(img)
        stack = getappdata(axes_traite,'History');
        if isempty(stack), stack = {}; end
        stack{end+1} = img;
        setappdata(axes_traite,'History',stack);
        setappdata(axes_traite,'Future',{});
    end

    function annuler_traitement()
        stack = getappdata(axes_traite,'History');
        if isempty(stack), set_info('Rien à annuler'); return; end
        img = getappdata(axes_traite,'Image');
        future = getappdata(axes_traite,'Future');
        future{end+1} = img;
        setappdata(axes_traite,'Future',future);
        prev = stack{end};
        stack(end) = [];
        setappdata(axes_traite,'History',stack);
        setappdata(axes_traite,'Image',prev);
        axes(axes_traite); imshow(prev);
        set_info('Annulation effectuée');
    end

    function refaire_traitement()
        future = getappdata(axes_traite,'Future');
        if isempty(future), set_info('Rien à refaire'); return; end
        img = getappdata(axes_traite,'Image');
        stack = getappdata(axes_traite,'History');
        stack{end+1} = img;
        setappdata(axes_traite,'History',stack);
        next = future{end};
        future(end) = [];
        setappdata(axes_traite,'Future',future);
        setappdata(axes_traite,'Image',next);
        axes(axes_traite); imshow(next);
        set_info('Refaire effectué');
    end

    function toggle_grid()
        grid_state = get(axes_traite, 'XGrid');
        if strcmp(grid_state, 'off')
            grid(axes_traite, 'on');
            set(axes_traite, 'GridColor', [0.5 0.5 0.5], 'GridAlpha', 0.3);
            set_info('Grille activée');
        else
            grid(axes_traite, 'off');
            set_info('Grille désactivée');
        end
    end

    function on_lum_change(val)
        img = getappdata(axes_traite,'Image');
        if isempty(img), return; end
        % always keep original before interactive change if history empty or last saved value different
        % we'll push a snapshot to history only when user stops moving? simpler: push before change if last not same
        % push current state to history only if slider moved from 0 to nonzero and history top differs
        stack = getappdata(axes_traite,'History');
        if isempty(stack) || ~isequal(stack{end}, img)
            push_history(img);
        end
        img_mod = double(img) + val;
        img_mod = uint8(min(max(img_mod,0),255));
        setappdata(axes_traite,'Image',img_mod);
        axes(axes_traite); imshow(img_mod);
        set_info(['Luminosité: ' num2str(val)]);
    end

    function on_con_change(val)
        img = getappdata(axes_traite,'Image');
        if isempty(img), return; end

        hist = getappdata(axes_traite,'History');
        if isempty(hist)
            base = getappdata(axes_originale,'Image');
            if isempty(base), base = img; end
        else
            base = hist{end};
        end
        try
            img_mod = imadjust(base, stretchlim(base), [], val);
        catch
            img_mod = imadjust(img, stretchlim(img), [], val);
        end
        setappdata(axes_traite,'Image',img_mod);
        axes(axes_traite); imshow(img_mod);
        set_info(['Contraste: ' num2str(round(val,2))]);
    end

    function on_canal_change()
        img = getappdata(axes_traite,'Image');
        if isempty(img), return; end
        base = getappdata(axes_originale,'Image');
        if isempty(base), base = img; end
        % ensure rgb
        if size(base,3) == 1
            base = cat(3, base, base, base);
        end
        r = get(s_r,'Value'); g = get(s_g,'Value'); b = get(s_b,'Value');
        tmp = double(base);
        tmp(:,:,1) = tmp(:,:,1) * r;
        tmp(:,:,2) = tmp(:,:,2) * g;
        tmp(:,:,3) = tmp(:,:,3) * b;
        tmp = uint8(min(max(tmp,0),255));
        push_history(getappdata(axes_traite,'Image'));
        setappdata(axes_traite,'Image',tmp);
        axes(axes_traite); imshow(tmp);
        set_info(sprintf('Canaux R G B = %.2f %.2f %.2f', r,g,b));
    end

    function rotation_image()
        img = getappdata(axes_traite,'Image');
        if isempty(img), errordlg('Aucune image.'); return; end
        angle = inputdlg({'Angle en degrés (ex: 90 ou -90):'}, 'Rotation',1,{'90'});
        if isempty(angle), return; end
        ang = str2double(angle{1});
        if isnan(ang), errordlg('Angle invalide'); return; end
        push_history(img);
        img_mod = imrotate(img, ang, 'bilinear', 'crop');
        setappdata(axes_traite,'Image',img_mod);
        axes(axes_traite); imshow(img_mod);
        set_info(['Rotation ' num2str(ang) '°']);
    end

    function redimensionner_image()
        img = getappdata(axes_traite,'Image');
        if isempty(img), errordlg('Aucune image.'); return; end
        s = inputdlg({'Echelle (%) ex: 50 pour 50% ou 200 pour 200%'}, 'Redimensionner',1,{'100'});
        if isempty(s), return; end
        scale = str2double(s{1})/100;
        if isnan(scale) || scale <= 0, errordlg('Echelle invalide'); return; end
        push_history(img);
        img_mod = imresize(img, scale);
        setappdata(axes_traite,'Image',img_mod);
        axes(axes_traite); imshow(img_mod);
        set_info(['Redimensionné: ' num2str(scale*100) '%']);
    end

    function miroir_image(direction)
        img = getappdata(axes_traite,'Image');
        if isempty(img), errordlg('Aucune image.'); return; end
        push_history(img);
        if strcmp(direction,'h')
            img_mod = flip(img ,2);
            set_info('Miroir horizontal');
        else
            img_mod = flip(img ,1);
            set_info('Miroir vertical');
        end
        setappdata(axes_traite,'Image',img_mod);
        axes(axes_traite); imshow(img_mod);
    end

     function decouper_image()
        img = getappdata(axes_traite,'Image');
        if isempty(img), errordlg('Aucune image.'); return; end

        prompt = {'X min :','X max :','Y min :','Y max :'};
        def = {'1', num2str(size(img,2)), '1', num2str(size(img,1))};
        answ = inputdlg(prompt,'Découper',1,def);
        if isempty(answ), set_info('Découpage annulé'); return; end

        xmin = str2double(answ{1});
        xmax = str2double(answ{2});
        ymin = str2double(answ{3});
        ymax = str2double(answ{4});

        if any(isnan([xmin xmax ymin ymax])) || xmin>=xmax || ymin>=ymax
            errordlg('Valeurs invalides'); return;
        end

        xmin = max(1, xmin); xmax = min(size(img,2), xmax);
        ymin = max(1, ymin); ymax = min(size(img,1), ymax);

        push_history(img);
        img_mod = img(ymin:ymax, xmin:xmax, :);
        setappdata(axes_traite,'Image',img_mod);
        axes(axes_traite); imshow(img_mod);
        set_info(sprintf('Découpe appliquée : X=%d:%d , Y=%d:%d',xmin,xmax,ymin,ymax));
    end


    function outil_texte()
        img = getappdata(axes_traite,'Image');
        if isempty(img), errordlg('Aucune image.'); return; end

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
        set(fig,'Color','black');
        pause(0.05);
        frame = getframe(axes_traite);
        img_with_text = frame2im(frame);
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

    function image_negatif()
        img = getappdata(axes_traite,'Image');
        if isempty(img), errordlg('Aucune image.'); return; end
        push_history(img);
        img_mod = 255 - img;
        setappdata(axes_traite,'Image',img_mod);
        axes(axes_traite); imshow(img_mod);
        set_info('Négatif appliqué');
    end

    function afficher_histogramme()
        img = getappdata(axes_traite,'Image');
        if isempty(img), errordlg('Aucune image.'); return; end
        figure('Name','Histogramme');
        if size(img,3) == 3
            subplot(3,1,1), imhist(img(:,:,1)), title('R');
            subplot(3,1,2), imhist(img(:,:,2)), title('G');
            subplot(3,1,3), imhist(img(:,:,3)), title('B');
        else
            imhist(img), title('Niveaux de gris');
        end
        set_info('Histogramme affiché');
    end

function reinitialise_traitement()
    % récupère l'image originale
    orig = getappdata(axes_originale,'Image');
    if isempty(orig)
        set_info('Aucune image d''origine à réinitialiser');
        return;
    end

    % récupère l'image courante (pour pouvoir annuler le reset)
    cur = getappdata(axes_traite,'Image');
    if ~isempty(cur) && ~isequal(cur, orig)
        % on sauvegarde l'état courant dans l'historique avant reset
        push_history(cur);
    end

    % remet l'image traitée à l'originale
    setappdata(axes_traite,'Image', orig);
    axes(axes_traite); imshow(orig); title('Traitee');

    % vide les piles history/future (on conserve toutefois la sauvegarde précédente faite ci-dessus)
    setappdata(axes_traite,'History', getappdata(axes_traite,'History')); % on a déjà pushé cur si nécessaire
    setappdata(axes_traite,'Future', {});

    % réinitialise les sliders aux valeurs par défaut si ils existent
    try set(s_lum,'Value',0); end
    try set(s_con,'Value',1.0); end
    try set(s_r,'Value',1); end
    try set(s_g,'Value',1); end
    try set(s_b,'Value',1); end

    % désactive la grille si active
    try
        if strcmp(get(axes_traite,'XGrid'),'on')
            grid(axes_traite,'off');
        end
    end

    set_info('Réinitialisation effectuée');
end


% === Fin des fonctions locales ===

end
