

% predicate that examine whether two lists have the same item: 
sameList(ListX, ListY) :-
    length(ListX, X), length(ListY, Y),
    X == Y,
    sort(ListX, SortedX),
    sort(ListY, SortedY),
    SortedX == SortedY.

% find all cities in the road network: 
allCities(Cities, RoadNetwork):-
    findall(
        City, 
        member((City,_Edges),RoadNetwork),
        Cities).

% find the cities that link to the current city: 
successor(X, Y, RoadNetwork):- 
    member((X, Edges), RoadNetwork),
    member((Y, _Any), Edges).

% calculate the cost of the solution:
cost([_H|[]], _RoadNetwork, 0).

cost([CurrentState, NextState| Rest], RoadNetwork, TotalCost):-
    member((CurrentState, Edges), RoadNetwork), member((NextState, Cost), Edges),
    cost([NextState | Rest], RoadNetwork, NextCost),
    TotalCost is (Cost + NextCost).

% return the last item of the list: 
lastItem([X], X).
lastItem([_H|T], X):-
    lastItem(T, X).

% match the state into startcity: 
goal_test(Path, State, RoadNetwork):-
    [StartCity | Rest] = Path,
    allCities(Cities, RoadNetwork),
    sameList(Rest, Cities),
    lastItem(Rest, State),
    StartCity = State.

% goal test for the solution
solution(Path, RoadNetwork, SolutionCost, SolutionPath):-
    [State | _Rest] = Path,
    goal_test(Path, State, RoadNetwork),
    cost(Path, RoadNetwork, TotalCost),
    SolutionCost is TotalCost,
    reverse(Path, SolutionPath).

% solution(+Path, +RoadNetwork, -SolutionCost, -SolutionPath): 
solution(Path, RoadNetwork, SolutionCost, SolutionPath):-
    length(Path, L1),
    allCities(Cities, RoadNetwork),
    length(Cities, L2),
    L1 < L2 + 1,
    [State | _Rest] = Path,
    successor(State, NextState, RoadNetwork),  % find the successor of current state using road network
    member((State, Edges), RoadNetwork), member((NextState, _Cost), Edges),  % extracting cost from road network
    solution([NextState | Path], RoadNetwork, SolutionCost, SolutionPath).