function getSortedTree(obj)
%getSortedTree Runs after 
%   Detailed explanation goes here

%note: replaces cutset_loop_num

NL = obj.NL;
SortedRows = sortrows(NL,1); % sorts rows in prefered tree order

%% Find incidence matricies
incidence = zeros(max(max(NL(:,2:3))),size(NL,1)); % initialize incidence matrix

idp = sub2ind(size(incidence), SortedRows(:,2), (1:length(SortedRows(:,2)))');
idm = sub2ind(size(incidence), SortedRows(:,3), (1:length(SortedRows(:,3)))');

incidence(idp)=1;
incidence(idm)=-1;


% Find the Reduced Incidence Matrix
incidence_1 = incidence(2:end,:);

% Reduce Incidence Matrix to Echelon Form
REF = rref(incidence_1);

[numRowsI,numColsI]=size(incidence_1);
% Tree = 0;

%% Find the Normal Tree and CoTree
% Find the first one (1) in each row
% The columns where these ones (1) occur are the braches within the normal
% tree
try
    colIndex = (REF==1).*repmat(1:numColsI,[numRowsI,1]);
    colIndex(colIndex <= 0) = inf;
    TreeRows = min(colIndex,[],2)';
catch
    error('Possible Singular Incidence Matrix. Check ground nodes in netlist (No isolation across transformer)')
end


% Find the remaining elements that are not in the normal tree
% The branches are in the Cotree
CoTreeRows = setdiff(1:numColsI,TreeRows);

%% Orders Tree and CoTree indices correctly: E R G J

% Adjust Branch Identification numbers from:
% V BV MV  C  R  L MI BI  I
% 1  2  3  4  5  6  7  8  9

% to

% Branch Identification numbers:
% __________Tree__________  _________CoTree__________
% E  E-B  E-M  E-C  E-L  R  G   J-C  J-L J-M  J-B  J
% 1   2    3    4    5   6  7    8    9   10   11  12

treeIDnumberMap = dictionary(1:9, [1:4 6 5 7:9]);
coTreeIDnumberMap = dictionary(1:9, [1:3 8 7 9 10 11 12]);

tree = [SortedRows(TreeRows(:),:), TreeRows(:)];
tree(:,1) = treeIDnumberMap(tree(:,1));
tree = sortrows(tree,1);

coTree = [SortedRows(CoTreeRows(:),:), CoTreeRows(:)];
coTree(:,1) = coTreeIDnumberMap(coTree(:,1));
coTree = sortrows(coTree,1);

assert(coTree(1) >= 7, 'CoTree contains voltage sources, indicating the presence of voltage loop in the circuit.')

%% Store resutls
obj.Cutset = [REF(:,coTree(:,5))];
obj.SortedTree_cutloop = tree;
obj.SortedCoTree_cutloop = coTree;


end

