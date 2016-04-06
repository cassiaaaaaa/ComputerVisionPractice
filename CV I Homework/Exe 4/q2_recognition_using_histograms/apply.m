function apply_q5
close all;clc;

disp('Question 5: Recognition using Histograms');

% -------------------------------------------------------------------------
disp('----- Question 5a -----');

queries{1} = 'query/obj99__40.png';
queries{2} = 'query/obj5__40.png';
queries{3} = 'query/obj34__40.png';
queries{4} = 'query/obj52__40.png';

figure('Position', [200 200 1200 600],'Name','Question 5a'); 
for ind=1:size(queries,2)
	query = queries{ind};
	best = histogram_query('model.txt', query, 20);
	subplot(2,size(queries,2),ind);
	imshow(imread(query)); title('Query');
	subplot(2,size(queries,2),size(queries,2)+ind);
	imshow(imread(best)); title('Best Match');
	drawnow;
end

% -------------------------------------------------------------------------
disp('----- Question 5b -----');

disp('Retrieval evaluation');

rec_rate = eval_recognition_performance('model.txt', 'query.txt', 50, 'rg');

fprintf('Recognition rate: %.2f percent\n', rec_rate*100);

% -------------------------------------------------------------------------
disp('----- Question 5c -----');

t=0.0:0.01:0.4;
[rec_rate, error_rate] = eval_recognition_performance_thres('model.txt', 'query.txt', t, 50, 'rg');

figure('Position', [200 200 1200 400],'Name','Question 5c'); 
subplot(1,2,1);
plot(t', rec_rate);
xlabel('Threshold');
ylabel('Recall');

subplot(1,2,2);
plot(error_rate, rec_rate);
xlabel('ErrorRate');
ylabel('Recall');

disp('Explain what the two graphs show. What does a high or low threshold mean? ');
disp('### insert your answer here ###');


% -------------------------------------------------------------------------
disp('----- Question 5d -----');

disp('Use different methods for computing histograms and compare the resulting positive detections and false detections.');
disp('Repeat the exercise for different distance functions. ');
disp('Try to find a combination of histogram method and distance function which gives the best results. ');
disp('Write a short summary of your observations and your explanation for them.');
disp('### insert your visualizations here ###');
disp('### insert your answer here ###');

