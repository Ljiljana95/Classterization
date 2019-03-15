%Domaci 3
% Ljiljana Popovic: EE72/2014

%1. Nad datim skupom podataka uraditi normalizaciju i prikaz svake dobijene matrice podataka X kao slike 
%(u Matlabu: imagesc(X); colormap(jet); colorbar):
load yeoh_data.mat 
load yeoh_lab.mat %labele
X1 = yeoh_data;
Xlab = yeoh_lab;

%a. Skup koji sadrži originalne nenormalizovane podatke.
 imagesc(X1);
 colormap(jet);
 title('Genske ekspresije pacijenata obolelih od raka koštane srži')
 xlabel('Nenormalizovani podaci')
 colorbar,figure

%b. Skup koji sadrži z-normalizovane podatke
X2 = zscore(X1);
imagesc(X2);
colormap(jet);
title('Genske ekspresije pacijenata obolelih od raka koštane srži')
xlabel('Z-normalizovani podaci')
colorbar,figure

%c. Skup koji sadrži podatke normalizovane na opseg [0,1]
X3 = (X1 - min(X1))./(max(X1)-min(X1));
imagesc(X3);
colormap(jet);
title('Genske ekspresije pacijenata obolelih od raka koštane srži')
xlabel('Normalizovani podaci na opseg [0,1]')
colorbar,figure

%2. Nad svim napravljenim skupovima podataka (korak 1.) izvršiti k-means algoritam (kmeans) bar 15 puta
%uzimaju?i za inicijalne centroide slu?ajno odabrane uzorake (proverite parametre funkcije, može da se podesi).
%Neophodno je ?uvati svih 15 dobijenih particija, najbolje u mat formatu (particija je data kao jedan vektor koji
%za svaki uzorak ?uva oznaku labele klastera).

%a. Koristiti sqeuclidean rastojanje.
for i = 1 : 15
    idx1S = kmeans(X1, 6, 'Distance','sqeuclidean','Replicates',1);
    save (['idx1S_' num2str(i) '.mat'], 'idx1S')
end

for i = 1 : 15
    idx2S = kmeans(X2, 6, 'Distance','sqeuclidean','Replicates',1);
    save (['idx2S_' num2str(i) '.mat'], 'idx2S')
end

for i = 1 : 15
    idx3S = kmeans(X3, 6, 'Distance','sqeuclidean','Replicates',1);
    save (['idx3S_' num2str(i) '.mat'], 'idx3S')
end

%b. Koristiti cosine rastojanje.
for i = 1 : 15
    idx1C = kmeans(X1, 6, 'Distance','cosine','Replicates',1);
    save (['idx1C_' num2str(i) '.mat'], 'idx1C')
end

for i = 1 : 15
    idx2C = kmeans(X2, 6, 'Distance','cosine','Replicates',1);
    save (['idx2C_' num2str(i) '.mat'], 'idx2C')
end

for i = 1 : 15
    idx3C = kmeans(X3, 6, 'Distance','cosine','Replicates',1);
    save (['idx3C_' num2str(i) '.mat'], 'idx3C')
end

%3. Nad svim napravljenim skupovima podataka (korak 1.) izvršiti algoritam hijerarhijske klasterizacije (linkage i cluster)
%koriste?i obe mere rastojanja (euclidean i cosine) i iscrtati dendograme. Sa?uvati dobijene particije.

%a. Koristiti average linkage. 
%average + euclidean X1
AE1 = linkage(X1,'average','euclidean');
cae1 = cluster(AE1,'maxclust',6);
figure,dendrogram(AE1,248,'ColorThreshold','default')
title('Hijerarhijska klasterizacija-originalni podaci')
xlabel('Mera rastojanja: euclidean, mera slicnosti: average')
save ('cae1.mat', 'cae1')

%average  + cosine X1
AC1 = linkage(X1,'average','cosine');
cac1 = cluster(AC1,'maxclust',6);
figure,dendrogram(AC1,248,'ColorThreshold','default')
title('Hijerarhijska klasterizacija-originalni podaci')
xlabel('Mera rastojanja: cosine, mera slicnosti: average')
save ('cac1.mat', 'cac1')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%average + euclidean X2
AE2 = linkage(X2,'average','euclidean');
cae2 = cluster(AE2,'maxclust',6);
figure,dendrogram(AE2,248,'ColorThreshold','default')
title('Hijerarhijska klasterizacija-Z-normalizovani podaci')
xlabel('Mera rastojanja: euclidean, mera slicnosti: average')
save ('cae2.mat', 'cae2')


%average  + cosine X2
AC2 = linkage(X2,'average','cosine');
cac2 = cluster(AC2,'maxclust',6);
figure,dendrogram(AC2,248,'ColorThreshold','default')
title('Hijerarhijska klasterizacija-Z-normalizovani podaci')
xlabel('Mera rastojanja: cosine, mera slicnosti: average')
save ('cac2.mat', 'cac2')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%average + euclidean X3
AE3 = linkage(X3,'average','euclidean');
cae3 = cluster(AE3,'maxclust',6);
figure,dendrogram(AE3,248,'ColorThreshold','default')
title('Hijerarhijska klasterizacija-normalizovani podaci [0,1]')
xlabel('Mera rastojanja: euclidean, mera slicnosti: average')
save ('cae3.mat', 'cae3')


%average  + cosine X3
AC3 = linkage(X3,'average','cosine');
cac3 = cluster(AC3,'maxclust',6);
figure,dendrogram(AC3,248,'ColorThreshold','default')
title('Hijerarhijska klasterizacija-normalizovani podaci [0,1]')
xlabel('Mera rastojanja: cosine, mera slicnosti: average')
save ('cac3.mat', 'cac3')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%b. Koristiti single linkage
%single + euclidean X1
SE1 = linkage(X1,'single','euclidean');
cse1 = cluster(SE1,'maxclust',6);
figure,dendrogram(SE1,248,'ColorThreshold','default')
title('Hijerarhijska klasterizacija-originalni podaci')
xlabel('Mera rastojanja: euclidean, mera slicnosti: single')
save ('cse1.mat', 'cse1')


%single + cosine X1
SC1 = linkage(X1,'single','cosine');
csc1 = cluster(SC1,'maxclust',6);
figure,dendrogram(SC1,248,'ColorThreshold','default')
title('Hijerarhijska klasterizacija-originalni podaci')
xlabel('Mera rastojanja: cosine, mera slicnosti: single')
save ('csc1.mat', 'csc1')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%single + euclidean X2
SE2 = linkage(X2,'single','euclidean');
cse2 = cluster(SE2,'maxclust',6);
figure,dendrogram(SE2,248,'ColorThreshold','default')
title('Hijerarhijska klasterizacija-Z-normalizovani podaci')
xlabel('Mera rastojanja: euclidean, mera slicnosti: single')
save ('cse2.mat', 'cse2')


%single + cosine X2
SC2 = linkage(X2,'single','cosine');
csc2 = cluster(SC2,'maxclust',6);
figure,dendrogram(SC2,248,'ColorThreshold','default')
title('Hijerarhijska klasterizacija-Z-normalizovani podaci')
xlabel('Mera rastojanja: cosine, mera slicnosti: single')
save ('csc2.mat', 'csc2')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%single + euclidean X3
SE3 = linkage(X3,'single','euclidean');
cse3 = cluster(SE3,'maxclust',6);
figure,dendrogram(SE3,248,'ColorThreshold','default')
title('Hijerarhijska klasterizacija-normalizovani podaci [0,1]')
xlabel('Mera rastojanja: euclidean, mera slicnosti: single')
save ('cse3.mat', 'cse3')

%single + cosine X3
SC3 = linkage(X3,'single','cosine');
csc3 = cluster(SC3,'maxclust',6);
figure,dendrogram(SC3,248,'ColorThreshold','default')
title('Hijerarhijska klasterizacija-normalizovani podaci [0,1]')
xlabel('Mera rastojanja: cosine, mera slicnosti: single')
save ('csc3.mat', 'csc3')

%4. Za svaku dobijenu particiju izra?unati interne mere validacije (evalclusters): CalinskiHarabasz, 
%DaviesBouldin i Silhouette (prose?nu širinu). Dati i sliku silhouette koeficijenata.

CH1S = []; CH1C = []; CH2S = []; CH2C = []; CH3S = []; CH3C = [];
DB1S = []; DB1C = []; DB2S = []; DB2C = []; DB3S = []; DB3C = [];
s1S = []; s1C = []; s2S = []; s2C = []; s3S = []; s3C = [];

for i = 1 : 15
    %K-MEANS
    %X1/sqeuclidean rastojanje
    load(['idx1S_' num2str(i) '.mat'])
    eCH1S = evalclusters(X1,idx1S,'CalinskiHarabasz');
    CH1S=[CH1S eCH1S.CriterionValues];
    eDB1S = evalclusters(X1,idx1S,'DaviesBouldin');
    DB1S=[DB1S eDB1S.CriterionValues];
    es1S = evalclusters(X1,idx1S,'silhouette');
    s1S=[s1S es1S.CriterionValues];
    figure,silhouette(X1,idx1S) %za svaki uzorak iscrta i nadje prosecnu vrednost
    title('Originalni podaci-k-means, sqeuclidean rastojanje')
    %Eksterna validacija
    ariCH1S(i)=rand_index(idx1S,Xlab,'adjusted');

    %X1/cosine rastojanje
    load(['idx1C_' num2str(i) '.mat'])
    eCH1C = evalclusters(X1,idx1C,'CalinskiHarabasz');
    CH1C=[CH1C eCH1C.CriterionValues];
    eDB1C = evalclusters(X1,idx1C,'DaviesBouldin');
    DB1C=[DB1C eDB1C.CriterionValues];
    es1C = evalclusters(X1,idx1C,'silhouette');
    s1C=[s1C es1C.CriterionValues];
    figure,silhouette(X1,idx1C)
    title('Originalni podaci-k-means, cosine rastojanje')
    %Eksterna validacija
    ariCH1C(i)=rand_index(idx1C,Xlab,'adjusted');
    
    %X2/sqeuclidean rastojanje
    load(['idx2S_' num2str(i) '.mat'])
    eCH2S = evalclusters(X2,idx2S,'CalinskiHarabasz');
    CH2S=[CH2S eCH2S.CriterionValues];
    eDB2S = evalclusters(X2,idx2S,'DaviesBouldin');
    DB2S=[DB2S eDB2S.CriterionValues];
    es2S = evalclusters(X2,idx2S,'silhouette');
    s2S=[s2S es2S.CriterionValues];
    figure,silhouette(X2,idx2S)
    title('Z-normalizovani podaci-k-means, sqeuclidean rastojanje')
    %Eksterna validacija
    ariCH2S(i)=rand_index(idx2S,Xlab,'adjusted');

    %X2/cosine rastojanje
    load(['idx2C_' num2str(i) '.mat'])
    eCH2C = evalclusters(X2,idx2C,'CalinskiHarabasz');
    CH2C=[CH2C eCH2C.CriterionValues];
    eDB2C = evalclusters(X2,idx2C,'DaviesBouldin');
    DB2C=[DB2C eDB2C.CriterionValues];
    es2C = evalclusters(X2,idx2C,'silhouette');
    s2C=[s2C es2C.CriterionValues];
    figure,silhouette(X2,idx2C)
    title('Z-normalizovani podaci-k-means, cosine rastojanje')
    %Eksterna validacija
    ariCH2C(i)=rand_index(idx2C,Xlab,'adjusted');
    
    %X3/sqeuclidean rastojanje
    load(['idx3S_' num2str(i) '.mat'])
    eCH3S = evalclusters(X3,idx3S,'CalinskiHarabasz');
    CH3S=[CH3S eCH3S.CriterionValues];
    eDB3S = evalclusters(X3,idx3S,'DaviesBouldin');
    DB3S=[DB3S eDB3S.CriterionValues];
    es3S = evalclusters(X3,idx3S,'silhouette');
    s3S=[s3S es3S.CriterionValues];
    figure,silhouette(X3,idx3S)
    title('Normalizovani podaci [0,1]-k-means, sqeuclidean rastojanje')
    %Eksterna validacija
    ariCH3S(i)=rand_index(idx3S,Xlab,'adjusted');

    %X3/cosine rastojanje
    load(['idx3C_' num2str(i) '.mat'])
    eCH3C = evalclusters(X3,idx3C,'CalinskiHarabasz');
    CH3C=[CH3C eCH3C.CriterionValues];
    eDB3C = evalclusters(X3,idx3C,'DaviesBouldin');
    DB3C=[DB3C eDB3C.CriterionValues];
    es3C = evalclusters(X3,idx3C,'silhouette');
    s3C=[s3C es3C.CriterionValues];
    figure,silhouette(X3,idx3C)
    title('Normalizovani podaci [0,1]-k-means, cosine rastojanje')
    %Eksterna validacija
    ariCH3C(i)=rand_index(idx3C,Xlab,'adjusted');
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

CHAE1 = []; CHAE2 = []; CHAE3 = []; CHAC1 = []; CHAC2 = []; CHAC3 = [];
CHSE1 = []; CHSE2 = []; CHSE3 = []; CHSC1 = []; CHSC2 = []; CHSC3 = []; 

DBAE1 = []; DBAE2 = []; DBAE3 = []; DBAC1 = []; DBAC2 = []; DBAC3 = [];
DBSE1 = []; DBSE2 = []; DBSE3 = []; DBSC1 = []; DBSC2 = []; DBSC3 = []; 

sAE1 = []; sAE2 = []; sAE3 = []; sAC1 = []; sAC2 = []; sAC3 = [];
sSE1 = []; sSE2 = []; sSE3 = []; sSC1 = []; sSC2 = []; sSC3 = []; 

  %HIJERARHIJSKO KLASTEROVANJE
  % X1/average/euclidean
  load('cae1.mat')
  eCHAE1 = evalclusters(X1,cae1,'CalinskiHarabasz');
  CHAE1= eCHAE1.CriterionValues;
  eDBAE1 = evalclusters(X1,cae1,'DaviesBouldin');
  DBAE1=eDBAE1.CriterionValues;
  esAE1 = evalclusters(X1,cae1,'silhouette');
  sAE1=esAE1.CriterionValues;
  figure,silhouette(X1,cae1)
  title('Originalni podaci-hijerarhijsko klasterovanje-average, euclidean rastojanje')
  %Eksterna validacija
  ariCHAE1=rand_index(cae1,Xlab,'adjusted');
  
  % X2/average/euclidean
  load('cae2.mat')
  eCHAE2 = evalclusters(X2,cae2,'CalinskiHarabasz');
  CHAE2=eCHAE2.CriterionValues;
  eDBAE2 = evalclusters(X2,cae2,'DaviesBouldin');
  DBAE2=eDBAE2.CriterionValues;
  esAE2 = evalclusters(X2,cae2,'silhouette');
  sAE2= esAE2.CriterionValues;
  figure,silhouette(X2,cae2)
  title('z-normalizovani podaci-hijerarhijsko klasterovanje-average, euclidean rastojanje')
  %Eksterna validacija
  ariCHAE2=rand_index(cae2,Xlab,'adjusted');
  
  % X3/average/euclidean
  load('cae3.mat')
  eCHAE3 = evalclusters(X3,cae3,'CalinskiHarabasz');
  CHAE3=eCHAE3.CriterionValues;
  eDBAE3 = evalclusters(X3,cae3,'DaviesBouldin');
  DBAE3=eDBAE3.CriterionValues;
  esAE3 = evalclusters(X3,cae3,'silhouette');
  sAE3=esAE3.CriterionValues;
  figure,silhouette(X3,cae3)
  title('normalizovani podaci [0,1]-hijerarhijsko klasterovanje-average, euclidean rastojanje')
  %Eksterna validacija
  ariCHAE3=rand_index(cae3,Xlab,'adjusted');
  
  % X1/average/cosine
  load('cac1.mat')
  eCHAC1 = evalclusters(X1,cac1,'CalinskiHarabasz');
  CHAC1=eCHAC1.CriterionValues;
  eDBAC1 = evalclusters(X1,cac1,'DaviesBouldin');
  DBAC1=eDBAC1.CriterionValues;
  esAC1 = evalclusters(X1,cac1,'silhouette');
  sAC1=esAC1.CriterionValues;
  figure,silhouette(X1,cac1)
  title('Originalni podaci-hijerarhijsko klasterovanje-average, cosine rastojanje')
  %Eksterna validacija
  ariCHAC1=rand_index(cac1,Xlab,'adjusted');
  
  % X2/average/cosine
  load('cac2.mat')
  eCHAC2 = evalclusters(X2,cac2,'CalinskiHarabasz');
  CHAC2=eCHAC2.CriterionValues;
  eDBAC2 = evalclusters(X2,cac2,'DaviesBouldin');
  DBAC2=eDBAC2.CriterionValues;
  esAC2 = evalclusters(X2,cac2,'silhouette');
  sAC2=esAC2.CriterionValues;
  figure,silhouette(X2,cac2)
  title('z-normalizovani podaci-hijerarhijsko klasterovanje-average, cosine rastojanje')
  %Eksterna validacija
  ariCHAC2=rand_index(cac2,Xlab,'adjusted');
  
  % X3/average/cosine
  load('cac3.mat')
  eCHAC3 = evalclusters(X3,cac3,'CalinskiHarabasz');
  CHAC3=eCHAC3.CriterionValues;
  eDBAC3 = evalclusters(X3,cac3,'DaviesBouldin');
  DBAC3=eDBAE3.CriterionValues;
  esAC3 = evalclusters(X3,cac3,'silhouette');
  sAC3=esAC3.CriterionValues;
  figure,silhouette(X3,cac3)
  title('normalizovani podaci [0,1]-hijerarhijsko klasterovanje-average, cosine rastojanje')
  %Eksterna validacija
  ariCHAC3=rand_index(cac3,Xlab,'adjusted');
  
  % X1/single/euclidean
  load('cse1.mat')
  eCHSE1 = evalclusters(X1,cse1,'CalinskiHarabasz');
  CHSE1=eCHSE1.CriterionValues;
  eDBSE1 = evalclusters(X1,cse1,'DaviesBouldin');
  DBSE1= eDBSE1.CriterionValues;
  esSE1 = evalclusters(X1,cse1,'silhouette');
  sSE1= esSE1.CriterionValues;
  figure,silhouette(X1,cse1)
  title('Originalni podaci-hijerarhijsko klasterovanje-single, euclidean rastojanje')
  %Eksterna validacija
  ariCHSE1=rand_index(cse1,Xlab,'adjusted');
  
  % X2/single/euclidean
  load('cse2.mat')
  eCHSE2 = evalclusters(X2,cse2,'CalinskiHarabasz');
  CHSE2=eCHSE2.CriterionValues;
  eDBSE2 = evalclusters(X2,cse2,'DaviesBouldin');
  DBSE2= eDBSE2.CriterionValues;
  esSE2 = evalclusters(X2,cse2,'silhouette');
  sSE2=esSE2.CriterionValues;
  figure,silhouette(X2,cse2)
  title('z-normalizovani podaci-hijerarhijsko klasterovanje-single, euclidean rastojanje')
  %Eksterna validacija
  ariCHSE2=rand_index(cse2,Xlab,'adjusted');
  
  % X3/single/euclidean
  load('cse3.mat')
  eCHSE3 = evalclusters(X3,cse3,'CalinskiHarabasz');
  CHSE3=eCHSE3.CriterionValues;
  eDBSE3 = evalclusters(X3,cse3,'DaviesBouldin');
  DBSE3= eDBSE3.CriterionValues;
  esSE3 = evalclusters(X3,cse3,'silhouette');
  sSE3=esSE3.CriterionValues;
  figure,silhouette(X3,cse3)
  title('normalizovani podaci [0,1]-hijerarhijsko klasterovanje-single, euclidean rastojanje')
  %Eksterna validacija
  ariCHSE3=rand_index(cse3,Xlab,'adjusted');
  
  % X1/single/cosine
  load('csc1.mat')
  eCHSC1 = evalclusters(X1,csc1,'CalinskiHarabasz');
  CHSC1=eCHSC1.CriterionValues;
  eDBSC1 = evalclusters(X1,csc1,'DaviesBouldin');
  DBSC1= eDBSC1.CriterionValues;
  esSC1 = evalclusters(X1,csc1,'silhouette');
  sSC1= esSC1.CriterionValues;
  figure,silhouette(X1,csc1)
  title('Originalni podaci-hijerarhijsko klasterovanje-single, cosine rastojanje')
  %Eksterna validacija
  ariCHSC1=rand_index(csc1,Xlab,'adjusted');
  
  % X2/single/cosine
  load('csc2.mat')
  eCHSC2 = evalclusters(X2,csc2,'CalinskiHarabasz');
  CHSC2=eCHSC2.CriterionValues;
  eDBSC2 = evalclusters(X2,csc2,'DaviesBouldin');
  DBSC2= eDBSC2.CriterionValues;
  esSC2 = evalclusters(X2,csc2,'silhouette');
  sSC2= esSC2.CriterionValues;
  figure,silhouette(X2,csc2)
  title('z-normalizovani podaci-hijerarhijsko klasterovanje-single, cosine rastojanje')
  %Eksterna validacija
  ariCHSC2=rand_index(csc2,Xlab,'adjusted');
  
  % X3/single/cosine
  load('csc3.mat')
  eCHSC3 = evalclusters(X3,csc3,'CalinskiHarabasz');
  CHSC3= eCHSC3.CriterionValues;
  eDBSC3 = evalclusters(X3,csc3,'DaviesBouldin');
  DBSC3= eDBSC3.CriterionValues;
  esSC3 = evalclusters(X3,csc3,'silhouette');
  sSC3= esSC3.CriterionValues;
  figure,silhouette(X3,csc3)
  title('normalizovani podaci [0,1]-hijerarhijsko klasterovanje-single, cosine rastojanje')
  %Eksterna validacija
  ariCHSC3=rand_index(csc3,Xlab,'adjusted');
  
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% BOX PLOT
  
  % X1/average/single/euclidean
  bCHAE1 = ones(15,1)*CHAE1;
  bCHSE1 = ones(15,1)*CHSE1;
  box = [CH1S' bCHAE1 bCHSE1];
  figure,subplot(2, 1, 1)
  boxplot(box,'Labels',{'k-means','average','single'})
  title('Originalni podaci')
  xlabel ('euclidean, CalinskiHarabasz')
  ylabel('Vrednost indeksa')
  
  bCHAC1 = ones(15,1)*CHAC1;
  bCHSC1 = ones(15,1)*CHSC1;
  box = [CH1C' bCHAC1 bCHSC1];
  subplot(2, 1, 2)
  boxplot(box,'Labels',{'k-means','average','single'})
  xlabel( 'cosine, CalinskiHarabasz')
  ylabel('Vrednost indeksa')
  
  bCHAE2 = ones(15,1)*CHAE2;
  bCHSE2 = ones(15,1)*CHSE2;
  box = [CH2S' bCHAE2 bCHSE2];
  figure,subplot(2, 1, 1)
  boxplot(box,'Labels',{'k-means','average','single'})
  title('Z-normalizovani podaci')
  xlabel('euclidean, CalinskiHarabasz')
  ylabel('Vrednost indeksa')
  
  bCHAC2 = ones(15,1)*CHAC2;
  bCHSC2 = ones(15,1)*CHSC2;
  box = [CH2C' bCHAC2 bCHSC2];
  subplot(2, 1, 2)
  boxplot(box,'Labels',{'k-means','average','single'})
  xlabel('cosine, CalinskiHarabasz')
  ylabel('Vrednost indeksa')
  
  bCHAE3 = ones(15,1)*CHAE3;
  bCHSE3 = ones(15,1)*CHSE3;
  box = [CH3S' bCHAE3 bCHSE3];
  figure,subplot(2, 1, 1)
  boxplot(box,'Labels',{'k-means','average','single'})
  title('Normalizovani podaci [0,1]')
  xlabel('euclidean, CalinskiHarabasz')
  ylabel('Vrednost indeksa')
  
  bCHAC3 = ones(15,1)*CHAC3;
  bCHSC3 = ones(15,1)*CHSC3;
  box = [CH3C' bCHAC3 bCHSC3];
  subplot(2, 1, 2)
  boxplot(box,'Labels',{'k-means','average','single'})
  xlabel('cosine, CalinskiHarabasz')
  ylabel('Vrednost indeksa')
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  bDBAE1 = ones(15,1)*DBAE1;
  bDBSE1 = ones(15,1)*DBSE1;
  box = [DB1S' bDBAE1 bDBSE1];
  figure,subplot(2, 1, 1)
  boxplot(box,'Labels',{'k-means','average','single'})
  title('Originalni podaci')
  xlabel('euclidean, DaviesBouldin')
  ylabel('Vrednost indeksa')
  
  bDBAC1 = ones(15,1)*DBAC1;
  bDBSC1 = ones(15,1)*DBSC1;
  box = [DB1C' bDBAC1 bDBSC1];
  subplot(2, 1, 2)
  boxplot(box,'Labels',{'k-means','average','single'})
  xlabel( 'cosine, DaviesBouldin')
  ylabel('Vrednost indeksa')
  
  bDBAE2 = ones(15,1)*DBAE2;
  bDBSE2 = ones(15,1)*DBSE2;
  box = [DB2S' bDBAE2 bDBSE2];
  figure,subplot(2, 1, 1)
  boxplot(box,'Labels',{'k-means','average','single'})
  title('Z-normalizovani podaci')
  xlabel('euclidean, DaviesBouldin')
  ylabel('Vrednost indeksa')
  
  bDBAC2 = ones(15,1)*DBAC2;
  bDBSC2 = ones(15,1)*DBSC2;
  box = [DB2C' bDBAC2 bDBSC2];
  subplot(2, 1, 2)
  boxplot(box,'Labels',{'k-means','average','single'})
  xlabel('cosine, DaviesBouldin')
  ylabel('Vrednost indeksa')
  
  bDBAE3 = ones(15,1)*DBAE3;
  bDBSE3 = ones(15,1)*DBSE3;
  box = [DB3S' bDBAE3 bDBSE3];
  figure,subplot(2, 1, 1)
  boxplot(box,'Labels',{'k-means','average','single'})
  title('Normalizovani podaci [0,1]')
  xlabel('euclidean, DaviesBouldin')
  ylabel('Vrednost indeksa')
  
  bDBAC3 = ones(15,1)*DBAC3;
  bDBSC3 = ones(15,1)*DBSC3;
  box = [DB3C' bDBAC3 bDBSC3];
  subplot(2, 1, 2)
  boxplot(box,'Labels',{'k-means','average','single'})
  xlabel('cosine, DaviesBouldin')
  ylabel('Vrednost indeksa')
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  bsAE1 = ones(15,1)*sAE1;
  bsSE1 = ones(15,1)*sSE1;
  box = [s1S' bsAE1 bsSE1];
  figure,subplot(2, 1, 1)
  boxplot(box,'Labels',{'k-means','average','single'})
  title('Originalni podaci')
  xlabel('euclidean, Silhouette')
  ylabel('Vrednost indeksa')
  
  bsAC1 = ones(15,1)*sAC1;
  bsSC1 = ones(15,1)*sSC1;
  box = [s1C' bsAC1 bsSC1];
  subplot(2, 1, 2)
  boxplot(box,'Labels',{'k-means','average','single'})
  xlabel( 'cosine, Silhouette')
  ylabel('Vrednost indeksa')
  
  bsAE2 = ones(15,1)*sAE2;
  bsSE2 = ones(15,1)*sSE2;
  box = [s2S' bsAE2 bsSE2];
  figure,subplot(2, 1, 1)
  boxplot(box,'Labels',{'k-means','average','single'})
  title('Z-normalizovani podaci')
  xlabel('euclidean, Silhouette')
  ylabel('Vrednost indeksa')
  
  bsAC2 = ones(15,1)*sAC2;
  bsSC2 = ones(15,1)*sSC2;
  box = [s2C' bsAC2 bsSC2];
  subplot(2, 1, 2)
  boxplot(box,'Labels',{'k-means','average','single'})
  xlabel('cosine, Silhouette')
  ylabel('Vrednost indeksa')
  
  bsAE3 = ones(15,1)*sAE3;
  bsSE3 = ones(15,1)*sSE3;
  box = [s3S' bsAE3 bsSE3];
  figure,subplot(2, 1, 1)
  boxplot(box,'Labels',{'k-means','average','single'})
  title('Normalizovani podaci [0,1]')
  xlabel('euclidean, Silhouette')
  ylabel('Vrednost indeksa')
  
  bsAC3 = ones(15,1)*sAC3;
  bsSC3 = ones(15,1)*sSC3;
  box = [s3C' bsAC3 bsSC3];
  subplot(2, 1, 2)
  boxplot(box,'Labels',{'k-means','average','single'})
  xlabel('cosine, Silhouette')
  ylabel('Vrednost indeksa')
  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  bariCHAE1 = ones(15,1)*ariCHAE1;
  bariCHSE1 = ones(15,1)*ariCHSE1;
  box = [ariCH1S' bariCHAE1 bariCHSE1];
  figure,subplot(2, 1, 1)
  boxplot(box,'Labels',{'k-means','average','single'})
  title('Originalni podaci')
  xlabel('euclidean, Adjusted rand index')
  ylabel('Vrednost indeksa')
  
  bariCHAC1 = ones(15,1)*ariCHAC1;
  bariCHSC1 = ones(15,1)*ariCHSC1;
  box = [ariCH1C' bariCHAC1 bariCHSC1];
  subplot(2, 1, 2)
  boxplot(box,'Labels',{'k-means','average','single'})
  xlabel( 'cosine, Adjusted rand index')
  ylabel('Vrednost indeksa')
  
  bariCHAE2 = ones(15,1)*ariCHAE2;
  bariCHSE2 = ones(15,1)*ariCHSE2;
  box = [ariCH2S' bariCHAE2 bariCHSE2];
  figure,subplot(2, 1, 1)
  boxplot(box,'Labels',{'k-means','average','single'})
  title('Z-normalizovani podaci')
  xlabel('euclidean, Adjusted rand index')
  ylabel('Vrednost indeksa')
  
  bariCHAC2 = ones(15,1)*ariCHAC2;
  bariCHSC2 = ones(15,1)*ariCHSC2;
  box = [ariCH2C' bariCHAC2 bariCHSC2];
  subplot(2, 1, 2)
  boxplot(box,'Labels',{'k-means','average','single'})
  xlabel('cosine, Adjusted rand index')
  ylabel('Vrednost indeksa')
  
  bariCHAE3 = ones(15,1)*ariCHAE3;
  bariCHSE3 = ones(15,1)*ariCHSE3;
  box = [ariCH3S' bariCHAE3 bariCHSE3];
  figure,subplot(2, 1, 1)
  boxplot(box,'Labels',{'k-means','average','single'})
  title('Normalizovani podaci [0,1]')
  xlabel('euclidean, Adjusted rand index')
  ylabel('Vrednost indeksa')
  
  bariCHAC3 = ones(15,1)*ariCHAC3;
  bariCHSC3 = ones(15,1)*ariCHSC3;
  box = [ariCH3C' bariCHAC3 bariCHSC3];
  subplot(2, 1, 2)
  boxplot(box,'Labels',{'k-means','average','single'})
  xlabel('cosine, Adjusted rand index')
  ylabel('Vrednost indeksa')
 
