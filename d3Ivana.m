%DOMACI 3 IZ PREPOZNAVANJA OBLIKA
%Stojanovic Ivana EE 59/2014 
    % 
%Zadatak 1

% ucitavanje podataka

load yeoh_data.mat
load yeoh_lab.mat
lab=yeoh_lab;
X1=yeoh_data;
figure, imagesc(X1)
colormap(jet);
colorbar

X2=zscore(X1);
figure, imagesc(X2)
colormap(jet);
colorbar

minX= min(X1);
maxX=max(X1);
X3= (X1-minX)./(maxX-minX);

figure, imagesc(X3)
colormap(jet);
colorbar

%Zadatak 2.
for i= 1: 15

    idx1S = kmeans(X1,6,'Distance','sqeuclidean', 'Replicates',1,'Display','final');
    save (['idx1S_' num2str(i) '.mat'], 'idx1S')

end

for i= 1: 15

    idx1C = kmeans(X1,6,'Distance','cosine', 'Replicates',1,'Display','final');
    save (['idx1C_' num2str(i) '.mat'], 'idx1C')

end

for i= 1: 15

    idx2S = kmeans(X2,6,'Distance','sqeuclidean', 'Replicates',1,'Display','final');
    save (['idx2S_' num2str(i) '.mat'], 'idx2S')

end

for i= 1: 15

    idx2C = kmeans(X2,6,'Distance','cosine', 'Replicates',1,'Display','final');
    save (['idx2C_' num2str(i) '.mat'], 'idx2C')

end

for i= 1: 15

    idx3S = kmeans(X3,6,'Distance','sqeuclidean', 'Replicates',1,'Display','final');
    save (['idx3S_' num2str(i) '.mat'], 'idx3S')

end

for i= 1: 15

    idx3C = kmeans(X3,6,'Distance','cosine', 'Replicates',1,'Display','final');
    save (['idx3C_' num2str(i) '.mat'], 'idx3C')

end

% Zadatak 3.
% average i euclidean
AE1 = linkage(X1,'average','euclidean');
AE1c = cluster(AE1,'cutoff',6);
figure, dendrogram(AE1)
save ('AE1c.mat','AE1c')

AE2 = linkage(X2,'average','euclidean');
AE2c = cluster(AE2,'cutoff',6);
figure, dendrogram(AE2)
save ('AE2c.mat','AE2c')

AE3 = linkage(X3,'average','euclidean');
AE3c = cluster(AE3,'cutoff',6);
figure, dendrogram(AE3)
save ('AE3c.mat','AE3c')

%average i cosine

AC1 = linkage(X1,'average','cosine');
AC1c = cluster(AC1,'cutoff',6);
figure, dendrogram(AC1)
save ('AC1c.mat','AC1c')

AC2 = linkage(X2,'average','cosine');
AC2c = cluster(AC2,'cutoff',6);
figure, dendrogram(AC2)
save ('AC2c.mat','AC2c')

AC3 = linkage(X3,'average','cosine');
AC3c = cluster(AC3,'cutoff',6);
figure, dendrogram(AC3)
save ('AC3c.mat','AC3c')

% single i euclidean

SE1 = linkage(X1,'single','euclidean');
SE1c = cluster(SE1,'cutoff',6);
figure, dendrogram(SE1)
save ('SE1c.mat','SE1c')

SE2 = linkage(X2,'single','euclidean');
SE2c = cluster(SE2,'cutoff',6);
figure, dendrogram(SE2)
save ('SE2c.mat','SE2c')

SE3 = linkage(X3,'single','euclidean');
SE3c = cluster(SE3,'cutoff',6);
figure, dendrogram(SE3)
save ('SE3c.mat', 'SE3c')
%single i cosine
SC1 = linkage(X1,'single','cosine');
SC1c = cluster(SC1,'cutoff',6);
figure, dendrogram(SC1)
save ('SC1c.mat','SC1c')

SC2 = linkage(X2,'single','cosine');
SC2c = cluster(SC2,'cutoff',6);
figure, dendrogram(SC2)
save ('SC2c.mat', 'SC2c')

SC3 = linkage(X3,'single','cosine');
SC3c = cluster(SC3,'cutoff',6);
figure, dendrogram(SC3)
save  ('SC3c.mat', 'SC3c')



% Zadatak 4
% za prvi deo zadatka

for i = 1:15
    load(['idx1S_' num2str(i) '.mat'])
    eCH1S = evalclusters(X1,idx1S,'CalinskiHarabasz');
    CH1S=[CH1S eCH1S.CriterionValues];

    load(['idx1C_' num2str(i) '.mat'])
    eva1C = evalclusters(X1,idx1C,'CalinskiHarabasz');
    eva1C.CriterionValues(i);
    
   load (['idx2S_' num2str(i) '.mat'])
   eva2S = evalclusters(X2,idx2S,'CalinskiHarabasz');
   eva2S.CriterionValues(i);
   load (['idx2C_' num2str(i) '.mat'])
   eva2C = evalclusters(X2,idx2C,'CalinskiHarabasz');
   eva2C.CriterionValues(i);
   
   load(['idx3S_' num2str(i) '.mat'])
   eva3S = evalclusters(X3,idx3S,'CalinskiHarabasz');
   eva3S.CriterionValues(i);
   load(['idx3C_' num2str(i) '.mat'])
   eva3C = evalclusters(X3,idx3C,'CalinskiHarabasz');
   
end









