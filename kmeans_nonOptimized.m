% first

%TRAIN

%select the data we want to use for training
for i=1:1:7
    for j=1:1:36
        trainset(i,j) = featured_data_up(i,j);
        trainset(i+7,j) = featured_data_down(i,j);
        trainset(i+14,j) = featured_data_left(i,j);
        trainset(i+21,j) = featured_data_right(i,j);
    end
end

clearvars i j

% run and evaluate kmeans
 [tr_idx,C_train_set] = kmeans(trainset,4, 'Replicates',45, 'Distance','cityblock');
 eval_train = evalclusters(trainset,tr_idx,'silhouette','Distance','cityblock');
 

%label the results we get from kmeans 
%1 = up
%2 = down
%3 = left
% 4 = right
% and create a matrix (train_labels) with the labels and the centroids of each

train_labels = ['up' {C_train_set(1,:)}; 'down' {C_train_set(2,:)}; 'left' {C_train_set(3,:)}; 'right' {C_train_set(4,:)}];

if(tr_idx(1,1) == 1)
   train_labels{1,1}='up';
   train_labels(1,2) = {C_train_set(1,:)};  
elseif (tr_idx(1,1) == 2)
    train_labels{1,1}='up';
    train_labels(1,2) = {C_train_set(2,:)};
elseif(tr_idx(1,1) == 3)
   train_labels{1,1}='up';
    train_labels(1,2) = {C_train_set(3,:)}; 
else
    train_labels{1,1}='up';
    train_labels(1,2) = {C_train_set(4,:)};
end


if(tr_idx(8,1) == 1)
   train_labels{2,1}='down';
   train_labels(2,2) = {C_train_set(1,:)};  
elseif (tr_idx(8,1) == 2)
    train_labels{2,1}='down';
    train_labels(2,2) = {C_train_set(2,:)};
elseif(tr_idx(8,1) == 3)
    train_labels{2,1}='down';
    train_labels(2,2) = {C_train_set(3,:)}; 
else
    train_labels{2,1}='down';
    train_labels(2,2) = {C_train_set(4,:)};
end

if(tr_idx(15,1) == 1)
   train_labels{3,1}='left';
   train_labels(3,2) = {C_train_set(1,:)};  
elseif (tr_idx(15,1) == 2)
    train_labels{3,1}='left';
    train_labels(3,2) = {C_train_set(2,:)};
elseif(tr_idx(15,1) == 3)
    train_labels{3,1}='left';
    train_labels(3,2) = {C_train_set(3,:)}; 
else
    train_labels{3,1}='left';
    train_labels(3,2) = {C_train_set(4,:)};
end

if(tr_idx(22,1) == 1)
   train_labels{4,1}='right';
   train_labels(4,2) = {C_train_set(1,:)};  
elseif (tr_idx(22,1) == 2)
    train_labels{4,1}='right';
    train_labels(4,2) = {C_train_set(2,:)};
elseif(tr_idx(22,1) == 3)
    train_labels{4,1}='right';
    train_labels(4,2) = {C_train_set(3,:)}; 
else
    train_labels{4,1}='right';
    train_labels(4,2) = {C_train_set(4,:)};
end

 

 %TEST
 
 %select the data that are left for testing the above classification 
 for i=1:1:3
    for j=1:1:36
        testset(i,j) = featured_data_up(i+7,j);
        testset(i+3,j) = featured_data_down(i+7,j);
        testset(i+6,j) = featured_data_left(i+7,j);
        testset(i+9,j) = featured_data_right(i+7,j);
    end
end

clearvars i j

%in matrix "distances" we keep the distances of each observation from all
%four centroids we have in "train_labels" matrix
for i=1:1:12
    for j=1:1:4
        temp = [testset(i,:); train_labels{j,2}];
        distances(i,j)=  pdist(temp,'cityblock');
    end
end
clearvars i j


%we find where we get to min distance and keep results in "miins_posiition"
%matrix
for i= 1:1:12
    mymin = distances(i,1);
    thesi = 1;
  for j=2:1:4
    if(distances(i,j)< mymin )
        mymin = distances(i,j);
        thesi = j;
    end
  end
  miins_position(i,1) = thesi;
end

%evaluate the results
right_clust=0;
wrong_clust=0;
for i= 1:1:12
   if(miins_position(i,1) == 1 && i<4)
        right_clust = right_clust+1;
   elseif(miins_position(i,1) == 2 && i>3 && i<7)
        right_clust = right_clust+1;
   elseif(miins_position(i,1) == 3 && i>6 && i<10)
        right_clust = right_clust+1;
   elseif(miins_position(i,1) == 4 && i>9 && i<=12)
        right_clust = right_clust+1;
   else
       wrong_clust = wrong_clust+1;
   end
end

first_result = (right_clust/(right_clust+wrong_clust))*100
 
clearvars right_clust wrong_clust miins_position i j distances mymin thesi temp