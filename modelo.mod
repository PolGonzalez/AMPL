param n;
param r;
param s;
	
set DIV1 := 1..n/2;
set DIV2 := n/2+1..n;
set TEAMS := 1..n;
set MATCHDAY := 1..r*((n/2)-1)+s*(n/2);
set MATCHDAYS := 2..r*((n/2)-1)+s*(n/2);
var match{i in TEAMS, j in TEAMS,k in MATCHDAY : i < j} binary;

maximize SCORE:
sum{i in DIV1,j in DIV2, k in MATCHDAYS} (match[i,j,k]*2^(k-2));

subject to INTRADIVISIONAL_MATCHES {i in TEAMS, j in TEAMS : (i < j) and ((i in DIV1 and j in DIV1) or (i in DIV2 and j in DIV2))}:
sum{k in MATCHDAY} match[i,j,k] = r;
subject to INTERDIVISONAL_MATCHES {i in TEAMS, j in TEAMS : (i < j) and ((i in DIV1 and j in DIV2) or (i in DIV2 and j in DIV1))}:
sum{k in MATCHDAY} match[i,j,k] = s;
subject to ONE_MATCH_PER_MATCHDAY_AND_TEAM {k in MATCHDAY}
sum{i in TEAMS, j in TEAMS : (j != i)} match[i,j,k] = 1;