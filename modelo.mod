param n;
param r;
param s;
	
set DIV1 := 1..n/2;
set DIV2 := (n/2)+1..n;
set TEAMS := 1..n;
set MATCHDAY := 1..r*((n/2)-1)+s*(n/2);
var match{k in MATCHDAY,i in TEAMS, j in TEAMS : i < j} binary;

maximize SCORE:
sum{i in DIV1,j in DIV2, k in MATCHDAY : (k > 1)} (match[k,i,j]*2^(k-2));

subject to INTRADIVISIONAL_MATCHES {i in TEAMS, j in TEAMS : (i < j) and ((i in DIV1 and j in DIV1) or (i in DIV2 and j in DIV2))}:
sum{k in MATCHDAY} match[k,i,j] = r;
subject to INTERDIVISONAL_MATCHES {i in TEAMS, j in TEAMS : (i < j) and ((i in DIV1 and j in DIV2) or (i in DIV2 and j in DIV1))}:
sum{k in MATCHDAY} match[k,i,j] = s;
subject to ONE_MATCH_PER_MATCHDAY_AND_TEAM {k in MATCHDAY , i in TEAMS}:
sum{j in TEAMS : (i < j)} match[k,i,j] + sum{j in TEAMS : (j < i)} match[k,j,i] = 1;