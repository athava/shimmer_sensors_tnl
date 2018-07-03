% features we use mean-rms-std-median

k = 1;
for i=1:1:10
   for j=1:1:9
        featured_data_up(i,j) = mean(raw_data{1,k}{1,j});
        featured_data_up(i,j+9) = rms(raw_data{1,k}{1,j});
        featured_data_up(i,j+18) = std(raw_data{1,k}{1,j});
        featured_data_up(i,j+27) = median(raw_data{1,k}{1,j});
        
        featured_data_down(i,j) = mean(raw_data{1,k+10}{1,j});
        featured_data_down(i,j+9) = rms(raw_data{1,k+10}{1,j});
        featured_data_down(i,j+18) = std(raw_data{1,k+10}{1,j});
        featured_data_down(i,j+27) = median(raw_data{1,k+10}{1,j});
        
        featured_data_left(i,j) = mean(raw_data{1,k+20}{1,j});
        featured_data_left(i,j+9) = rms(raw_data{1,k+20}{1,j});
        featured_data_left(i,j+18) = std(raw_data{1,k+20}{1,j});
        featured_data_left(i,j+27) = median(raw_data{1,k}{1,j});
        
        featured_data_right(i,j) = mean(raw_data{1,k+30}{1,j});
        featured_data_right(i,j+9) = rms(raw_data{1,k+30}{1,j});
        featured_data_right(i,j+18) = std(raw_data{1,k+30}{1,j});
        featured_data_right(i,j+27) = median(raw_data{1,k+30}{1,j});
   end
   k = k+1;
end

clearvars i j k ;

%% k folding


c = cvpartition(10,'kfold',5 )
Indices = crossvalind('Kfold', featured_data_down(:,1), 10 )

idx = training(c,2)

%aaa= crossvalind('Kfold', featured_data_down, 9);
%Indices = crossvalind('Kfold', N, K)
































%% kmeans






































%%
% 
% k=1;
% for i=11:1:20
%    for j=1:1:9
%         featured_data_down(i,j) = mean(raw_data{1,k}{1,j});
%         featured_data_down(i,j+9) = rms(raw_data{1,k}{1,j});
%         featured_data_down(i,j+18) = std(raw_data{1,k}{1,j});
%         featured_data_down(i,j+27) = median(raw_data{1,k}{1,j});
%     end
%    k = k+1;
% end
% 
% 
% k=1;
% for i=21:1:30
%    for j=1:1:9
%         featured_data_left(i,j) = mean(raw_data{1,k}{1,j});
%         featured_data_left(i,j+9) = rms(raw_data{1,k}{1,j});
%         featured_data_left(i,j+18) = std(raw_data{1,k}{1,j});
%         featured_data_left(i,j+27) = median(raw_data{1,k}{1,j});
%    end
%    k = k+1;
% end
% 
% k=1;
% for i=31:1:40
%    for j=1:1:9
%         featured_data_right(i,j) = mean(left_train{1,k}{1,j});
%         featured_data_right(i,j+9) = rms(left_train{1,k}{1,j});
%         featured_data_right(i,j+18) = std(left_train{1,k}{1,j});
%         featured_data_right(i,j+27) = median(left_train{1,k}{1,j});
%    end
%    k = k+1;
% end
