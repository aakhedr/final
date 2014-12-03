
%% problem8
train = load('train.txt');
X = train(:, 2:3);
X = transform(X);
[m, ~] = size(X);
X = [ones(m, 1) X];

test = load('test.txt');
Xtest = test(:, 2:3);
Xtest = transform(Xtest);
[n, ~] = size(Xtest);
Xtest = [ones(n, 1) Xtest];

lambda = 1;
I = eye(size(X, 2)); 	I(1, 1) = 0;

choices = [0 1 2 3 4];

for i = 1 : length(choices)
	y = train(:, 1);
	y(y~=choices(i)) = -1;
	y(y==choices(i)) = 1;

	w_reg = pinv(X' * X + lambda * I) * X' * y;

	yTest = test(:, 1);
	yTest(yTest~=choices(i)) = -1;
	yTest(yTest==choices(i)) = 1;

	yTestEst = sign(Xtest * w_reg);
	Eout = length(yTestEst(yTestEst~=yTest))/ length(yTestEst);

	fprintf('Eout of %f: %f\n', choices(i), Eout);
end
