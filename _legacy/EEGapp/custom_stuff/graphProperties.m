function [ L, EGlob, CClosed, ELocClosed, COpen, ELocOpen ] = graphProperties( varargin )
% graphProperties: compute properties of a graph from its adjacency matrix
% usage: [L,EGlob,CClosed,ELocClosed,COpen,ELocOpen] = graphProperties(A);
%
% arguments: 
%   A (nxn) - adjacency matrix of a graph G
%
%   L (scalar) - characteristic path length
%   EGlob (scalar) - global efficiency
%   CClosed (scalar) - clustering coefficient (closed neighborhood)
%   ELocClosed (scalar) - local efficiency (closed neighborhood)
%   COpen (scalar) - clustering coefficient (open neighborhood)
%   ELocOpen (scalar) - local efficiency (open neighborhood)
%

% author: Nathan D. Cahill
% email: nathan.cahill@rit.edu
% date: 10 April 2014

% get adjacency matrix from list of inputs
A = parseInputs(varargin{:});

% get number of vertices
n = size(A,1);

% shortest path distances between each node
D = graphallshortestpaths(A);

% characteristic path length
L = sum(D(:))/(n*(n-1));

% global efficiency
EGlob = (sum(sum(1./(D+eye(n)))) - n)/(n*(n-1));

% subgraphs of G induced by the neighbors of each vertex
[MClosed,kClosed,MOpen,kOpen] = subgraphs(A);

% local clustering coefficient in each subgraph
[CLocClosed,CLocOpen] = deal(zeros(n,1));
for i = 1:n
    CLocClosed(i) = sum(MClosed{i}(:))/...
        (numel(kClosed{i})*(numel(kClosed{i})-1));
    CLocOpen(i) = sum(MOpen{i}(:))/...
        (numel(kOpen{i})*(numel(kOpen{i})-1));
end

% clustering coefficients
CClosed = mean(CLocClosed);
COpen = mean(CLocOpen);

% local efficiency of each subgraph
[ELocSGClosed,ELocSGOpen] = deal(zeros(n,1));
for i = 1:n
    % distance matrix and number of vertices for current subgraph
    DSGClosed = graphallshortestpaths(MClosed{i});
    DSGOpen = graphallshortestpaths(MOpen{i});
    nSGClosed = numel(kClosed{i});
    nSGOpen = numel(kOpen{i});
    % efficiency of current subgraph
    ELocSGClosed(i) = (sum(sum(1./(DSGClosed+eye(nSGClosed)))) - nSGClosed)/...
        (nSGClosed*(nSGClosed-1));
    ELocSGOpen(i) = (sum(sum(1./(DSGOpen+eye(nSGOpen)))) - nSGOpen)/...
        (nSGOpen*(nSGOpen-1));
end

% local efficiency of graph
ELocClosed = mean(ELocSGClosed);
ELocOpen = mean(ELocSGOpen);

end

function A = parseInputs(varargin)
% parseInputs: test that input is an adjacency matrix

% check number of inputs
narginchk(1,1);

% get first input
A = varargin{1};

% test to make sure A is a square matrix
if ~isnumeric(A) || ~ismatrix(A) || size(A,1)~=size(A,2)
    error([mfilename,':ANotSquare'],'Input must be a square matrix.');
end

% test to make sure A only contains zeros and ones
if any((A~=0)&(A~=1))
    error([mfilename,':ANotValid'],...
        'Input matrix must contain only zeros and ones.');
end

% change A to sparse if necessary
if ~issparse(A)
    A = sparse(A);
end

end

function [MClosed,kClosed,MOpen,kOpen] = subgraphs(A)
% subgraphs: compute adjacency matrices for each vertex in a graph
% usage: [MClosed,kClosed,MOpen,kOpen] = subgraphs(A);
%
% arguments: 
%   A - (nxn) adjacency matrix of a graph G
%
%   MClosed, MOpen - (nx1) cell arrays containing adjacency matrices of the 
%       subgraphs corresponding to neighbors of each vertex. For example, 
%       MClosed{j} is the adjacency matrix of the subgraph of G 
%       corresponding to the closed neighborhood of the jth vertex of G, 
%       and kClosed{j} is the list of vertices of G that are in the 
%       subgraph (and represent the corresponding rows/columns of 
%       MClosed{j})
%       

% author: Nathan D. Cahill
% email: nathan.cahill@rit.edu
% date: 10 Apr 2014

% number of vertices
n = size(A,1);

% initialize indices of neighboring vertices, and adjacency matrices
[kClosed,kOpen] = deal(cell(n,1));
[MClosed,MOpen] = deal(cell(n,1));

% loop through each vertex, determining its neighbors
for i=1:n
    
    % find indices of neighbors of vertex v_i
    k1 = find(A(i,:)); % vertices with edge beginning at v_i
    k2 = find(A(:,i)); % vertices with edge ending at v_i
    kOpen{i} = union(k1,k2); % vertices in neighborhood of v_i
    kClosed{i} = union(kOpen{i},i);
    
    % extract submatrix describing adjacency of neighbors of v_i
    MOpen{i} = A(kOpen{i},kOpen{i});
    MClosed{i} = A(kClosed{i},kClosed{i});
    
end

end