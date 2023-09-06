%% ejercicio 1
% produccion de energia 
%datos obtenidos de coordinador electrico nacional 
%https://www.coordinador.cl/

[datos, texto, alldata] = xlsread('CEN-hist_cap_inst_por_tecnologia.xlsx',2);

fechas=datos(:,1);
hidrico=datos(:,2);
carbon=datos(:,3);
diesel=datos(:,4);
gas_natural=datos(:,5);
eolico=datos(:,6);
solar=datos(:,7);
termosolar=datos(:,8);
geotermico=datos(:,9);


%% puntos
figure()
scatter(fechas,hidrico,'filled')
hold on 
scatter(fechas,carbon,'filled')
hold on 
scatter(fechas,diesel,'filled')
hold on 
scatter(fechas,gas_natural,'filled')
hold on 
scatter(fechas,eolico,'filled')
hold on 
scatter(fechas,solar,'filled')
hold on 
scatter(fechas,termosolar,'filled')
hold on 
scatter(fechas,geotermico,'filled')
xlabel('Años')
ylabel('Capacidad Instalada [MW]')
title('Capacidad Instalada')
legend('Hidríco','Carbón','Diesel','Gas Natural','Eólico','Solar','Termosolar','Geotérmico')
grid on
axis tight

%% barra
figure()
bar(fechas,datos(:,2:9),'stacked')
xlabel('Años')
ylabel('[MW]')
title('Capacidad Instalada')
legend('Hidríco','Carbón','Diesel','Gas Natural','Eólico','Solar','Termosolar','Geotérmico')
grid on
axis tight

%% torta
%cambie el orden de las columnas en datos, originalmente sale como 
%solar termosolar geotermico y fue cambiado a termosolar solar geot
%pq son muy poco entonces en torta se sobrepone uno con otro y no se ve
%bien

%ordeno los datos para el graf de torta
data=[fechas hidrico carbon diesel gas_natural eolico termosolar solar geotermico];

%intento hacer una torta de todos los años 
%productos = {'hidríco','carbón','diesel','gas natural','eólico','termosolar','solar','geotérmico'};
%sumo la totalidad de MW de cada año para cada tipo de energia 
%totales = [sum(hidrico);sum(carbon);sum(diesel);sum(gas_natural);sum(eolico);sum(termosolar);sum(solar);sum(geotermico)]
%figure()
%pie(totales,productos)

% sacar año 2022 y 2000 restarlos y sacar el porcentaje de aumento desde el
% 2000 al 2022

%saco el grafico de torta para el año 2000
%productos = {'hidríco','carbón','diesel','gas natural','eólico','termosolar','solar','geotérmico'};
%ano2000=data(1,2:9);
%ano2022=data(23,2:9);
%anoresta=ano2022-ano2000
%figure()
%subplot(2,2,1)
%pie(ano2000,productos)
%subplot(2,2,2)
%pie(ano2022,productos)
%subplot(2,2,3)
%pie(anoresta,productos)

%% otro intento torta 3D comparando años 2000 y 2022 

ano2000=data(1,2:9);
ano2022=data(23,2:9);
y2000 = ano2000;
y2022 = ano2022;
labels = {'hidríco','carbón','diesel','gas_natural','eólico','termosolar','solar','geotérmico'};

figure()
t = tiledlayout(1,2,"TileSpacing","None");
ax1 = nexttile;
pie3(ax1,y2000)
title("2000")

ax2 = nexttile;
pie3(ax2,y2022)
title("2022")

l = legend(labels);
l.Layout.Tile = "south";

%% ahora haremos los 3 graf para el consumo de energia 
%para esto utilizaremos los datos sacados de bne_2021
%sacado de la pag energía abierta 
%http://energiaabierta.cl/categorias-estadistica/balance-energetico/
%cabe recalcar que estos son los datos de energia para el año 2021

%los datos que se utilizaron estan en Teracalorías

clear all 
clc 
[datos, texto, alldata] = xlsread('bne_2021.xlsx',7);
%donde en datos la primera columna corresponde a la produccion bruta 
%y la columna 5 corresponde a la oferta primaria y la oferta es sinonimo de
%consumo 
%cada fila corresponde a un tipo de energia y sigue este orden:
%petroleo crudo 
%gas natural 
%carbon 
%biomasa
%energia hidrica 
%energia eolica
%energia solar
%biogas
%geotermia
%total 

%ordenamos los datos de la forma que nos resulte mas comoda
%lo dejo de 9 filas ya que la ultima fila corresponde al total 
datos = [datos(1:9,1) datos(1:9,5)]; %aca la primera columna es produccion y la segunda consumo

%% barras
X = categorical({'Petroleo crudo','Gas natural','Carbón','Biomasa','E Hídrica','E eolica','E solar','Biogas','Geotermia'});
X = reordercats(X,{'Petroleo crudo','Gas natural','Carbón','Biomasa','E Hídrica','E eolica','E solar','Biogas','Geotermia'});

figure()
bar(X,datos)
ylabel('Teracalorías')
xlabel('Año 2021')
legend('Producción','Consumo')
title('Consumo y Producción de Energías en Chile 2021')
grid on 
axis tight

%% puntos
figure()
scatter(X,datos(:,1),200,'filled') %200 es el tamaño de los puntos
hold on 
scatter(X,datos(:,2),100,'filled') %100 es el tamaño de los puntos 
ylabel('Teracalorías')
xlabel('Año 2021')
legend('Producción','Consumo')
title('Consumo y Producción de Energías en Chile 2021')
grid on 
axis tight

%% torta
%pasa el mismo problema que anteriormente 
%cambiamos el orden de los datos para evitar el problema de la
%superposicion

%petroleo crudo 1
%gas natural 2 
%carbon 3
%biomasa 4
%energia hidrica 5 
%energia eolica 6
%energia solar 7 
%biogas 8
%geotermia 9

%haremos este orden 
% 9 2 8  4  3 7 6 1 5

datos = datos' %la primera fila es produccion
datoss = [datos(:,9) datos(:,2) datos(:,8) datos(:,4) datos(:,3) datos(:,7) datos(:,6) datos(:,1) datos(:,5)]

%figure
%pie(datoss(1,:),labels)

figure()
labels = {'Geotermia','Gas Natural','Biogas','Biomasa','Carbon','Solar','Eolico','Petroleo Crudo','Hídrico'};

t = tiledlayout(1,2,"TileSpacing","None");
ax1 = nexttile;
pie3(ax1,datoss(1,:))
title("Producción")

ax2 = nexttile;
pie3(ax2,datoss(2,:))
title("Consumo")

l = legend(labels);
l.Layout.Tile = "south";

%% ejercicio a eleccion 
%actualizar la produccion por tipo a nivel mundial 
%los datos son sacados de 
% ENERDATA
%https://datos.enerdata.net/energia-total/produccion-energetica-mundial.html

clear all
clc

%Saco los datos a nivel global del año 2021 para los siguientes tipos de
%energia

%carbon
%crude oil
%oil products 
%natural gas
%renovables

%como num5 corresponde a renovables y está en porcentaje lo multiplico *100

[num1, ~, ~] = xlsread('Enerdata_Energy_Statistical_Yearbook_2022.xlsx',6, 'AH7');
[num2, ~, ~] = xlsread('Enerdata_Energy_Statistical_Yearbook_2022.xlsx',9, 'AH7');
[num3, ~, ~] = xlsread('Enerdata_Energy_Statistical_Yearbook_2022.xlsx',11, 'AH7');
[num4, ~, ~] = xlsread('Enerdata_Energy_Statistical_Yearbook_2022.xlsx',14, 'AH7');
[num5, ~, ~] = xlsread('Enerdata_Energy_Statistical_Yearbook_2022.xlsx',21, 'AH7');
num = [num1; num2; num3; num4; num5*100];


%creamos un grafico de torta 
figure()
labels={'Coal','Crude Oil','Oil Products','Natural Gas','Renewables'};
explode=[0 0 0 0 1];
pie(num,explode)
title('Energía global por fuente de generación 2021')
legend(labels)



