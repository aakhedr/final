
%% problem10
train = load('train.txt');
X = train(:, 2:3);
[m, ~] = size(X);
X = transform(X);
X = [ones(m, 1) X];

test = load('test.txt');
Xtest = test(:, 2:3);
[n, ~] = size(Xtest);
Xtest = transform(Xtest);
Xtest = [ones(n, 1) Xtest];

lambda_vec = [.01 1];
I = eye(size(X, 2)); 		I(1, 1) = 0;

output = [1 5];

for i = 1 : length(output)
	fprintf('Classifying %f versus all\n', output(i))
	y = train(:, 1);
	y(y~=output(i)) = -1;
	y(y==output(i)) = 1;

	yTest = test(:, 1);
	yTest(yTest~=output(i)) = -1;
	yTest(yTest==output(i)) = 1;

	Ein = zeros(length(lambda_vec), 1);
	Eout = zeros(length(lambda_vec), 1);
	fprintf('lambda\t\tEin\t\tEout\n');

	for j = 1 : length(lambda_vec)
		w_reg = pinv(X' * X + lambda_vec(j) * I) * X' * y;
		
		yEst = sign(X * w_reg);
		Ein(j) = length(yEst(yEst~=y))/ length(yEst);

		yTestEst = sign(Xtest * w_reg);
		Eout(j) = length(yTestEst(yTestEst~=yTest))/ length(yTest);

		fprintf('%f\t%f\t%f\n', lambda_vec(j), Ein(j), Eout(j));
	end
	fprintf('\n');
end
