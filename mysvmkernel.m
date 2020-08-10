function [K]= mysvmkernel(x,xsup,kernel,kerneloption)
%%% each row is a sample and each column is a feaure.
[n1] = size(x,1);

n2 = size(xsup,1);
K  =  zeros(n1,n2);			% produit scalaire
ps = K;
for i =1:n1
    for j = 1:n2
        tmp = (x(i,:)-xsup(j,:));
        ps(i,j) = norm(tmp)^2;
    end
end
gamma = mean(mean(ps));
tt  = 2^kerneloption*gamma;

switch lower(kernel)
    
    case 'poly'
        for i =1:n1
            for j = 1:n2
                tmp = (x(i,:)*xsup(j,:)'+1);
                K(i,j) = tmp^kerneloption;
            end
        end
    
    case 'gaussian'
        for i =1:n1
            for j = 1:n2
                K(i,j) = exp(-ps(i,j)/tt);
            end
        end
        
    case 'laplacianker'
        for i =1:n1
            for j = 1:n2
                K(i,j) = exp(-sqrt(ps(i,j))/sqrt(tt) );
            end
        end
        
    case 'inversesquare'
        for i =1:n1
            for j = 1:n2
                K(i,j) = 1/( (ps(i,j)/tt) + 1);
            end
        end
        
    case 'inversedis'
        for i =1:n1
            for j = 1:n2
                K(i,j) = 1/( (sqrt(ps(i,j))/sqrt(tt)) + 1);
            end
        end
%     case 'chi2'       
%         KM_Train_r = chi2rbfkernel(x',xsup',1);
%         alpha = sqrt(2)^kerneloption*mean(KM_Train_r(:));
%         K = exp(-KM_Train_r/alpha);
end