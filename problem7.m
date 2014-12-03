
%% problem 7
train = load('train.txt');

[m, ~] = size(train);
X = [ones(m, 1) train(:, 2:3)];
[~, n] = size(X);

lambda = 1;
I = eye(n);		I(1, 1) = 0;

choices = [5 6 7 8 9];

for i = 1 : length(choices)
	y = train(:, 1);
	y(y~=choices(i)) = -1;
	y(y==choices(i)) = 1;
	w_reg = pinv(X' * X + lambda * I) * X' * y;

	est = sign(X * w_reg);

	Ein = length(est(est~=y))/ length(est);
	fprintf('Ein of %f: %f\n', choices(i), Ein);
end
