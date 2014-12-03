
%%problem9
train = load('train.txt');
X = train(:, 2:3);
[m, ~] = size(X);
X_transform = transform(X);

X = [ones(m, 1) X];
X_transform = [ones(m, 1) X_transform];

test = load('test.txt');
Xtest = test(:, 2:3);
[k, ~] = size(Xtest);
Xtest_transform = transform(Xtest);

Xtest = [ones(k, 1) Xtest];
Xtest_transform = [ones(k, 1) Xtest_transform];

lambda = 1;
I = eye(size(X, 2)); 							I(1, 1) = 0;
I_transform = eye(size(X_transform, 2)); 		I_transform(1, 1) = 0;

output = [0 1 2 3 4 5 6 7 8 9];
Eout = zeros(length(output), 1);
Eout_transform = zeros(length(output), 1);

fprintf('(num)VersusAll\tEout\t\tEout_transform\tDiff\n');

for i = 1 : length(output)
	y = train(:, 1);
	y(y~=output(i)) = -1;
	y(y==output(i)) = 1;

	w_reg = pinv(X' * X + lambda * I) * X' * y;
	w_reg_transform = ...
		pinv(X_transform' * X_transform + lambda * I_transform) * ...
			X_transform' * y;

	yTest = test(:, 1);
	yTest(yTest~=output(i)) = -1;
	yTest(yTest==output(i)) = 1;

	yTestEst = sign(Xtest * w_reg);
	yTestEst_transform = sign(Xtest_transform * w_reg_transform);

	Eout(i) = length(yTestEst(yTestEst~=yTest))/ length(yTestEst);
	Eout_transform(i) = length(yTestEst_transform(yTestEst_transform~=yTest))/ ...
		length(yTestEst_transform);

	fprintf('%f\t%f\t%f\t%f\n', output(i), Eout(i), Eout_transform(i), ...
		abs(Eout_transform(i) - Eout(i)));
end
