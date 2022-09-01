unit unitGauss;

interface

Type matrice = array of array of Real;
	 vecteur = array of Real;

function recherchePivotLigne(a : matrice; i : Integer) : Integer;

procedure initialisationMatrice(a : matrice);
procedure affichageTableau(a : matrice);
procedure changementLigne(a : matrice; i,j : Integer);
procedure transvection (a : matrice ; i,j : Integer ; l : Real);
procedure matriceEchelonne(a : matrice);
procedure reponse(a : matrice; b : vecteur);
procedure mineursPrincipaux(a : matrice; b : vecteur);
procedure exempleWilson(a : matrice);
procedure exempleHilbert(a : matrice);

implementation

{première version n'utilisant pas les tableaux dynamiques 3 equations/inconnus}
// complication puisque indication commence non plus à 1 pour un tableau statique mais à 0
var
n,m,i,j,k : Integer;
x,y,l,somme : Real;

{initialisation tableau}
procedure initialisationMatrice(a : matrice);
begin
	for n := 0 to high(a) do
		begin
		for m := 0 to high(a[0]) do
			begin
				read(a[n,m]);		
			end;
		end;
	writeln('Voici votre matrice initialisee :');
	affichageTableau(a);
end;

procedure exempleWilson(a : matrice);
begin
	a[0][0] := 10;
	a[0][1] := 7;
	a[0][2] := 8;
	a[0][3] := 7;
	a[0][4] := 32;
	
	a[1][0] := 7;
	a[1][1] := 5;
	a[1][2] := 6;
	a[1][3] := 5;
	a[1][4] := 23;
	
	a[2][0] := 8;
	a[2][1] := 6;
	a[2][2] := 10;
	a[2][3] := 9;
	a[2][4] := 33;
	
	a[3][0] := 7;
	a[3][1] := 5;
	a[3][2] := 9;
	a[3][3] := 10;
	a[3][4] := 31;
	
	writeln('Voici votre matrice initialisee :');
	affichageTableau(a);
end;

procedure exempleHilbert(a : matrice);
begin
	for n := 0 to high(a) do
	begin
		for m := 0 to high(a[0]) do
		begin
			if m <> high(a[0]) then
			begin
			a[n,m] := 1/(n+m+1);
			somme := somme + a[n,m];
			end
			else a[n,m] := somme;
		end;
		somme := 0;
	end;
	writeln('Voici votre matrice initialisee :');
	affichageTableau(a);
end;

{dans la matrice a : Li↔Lj}
procedure changementLigne(a : matrice ; i,j : Integer);
begin
	for n := 0 to high(a[0]) do
	begin
		x := a[j,n];
		y := a[i,n];
		a[i,n] := x;
		a[j,n] := y;
	end;
end;

{dans la matrice a : Li←Li+l*Lj}
procedure transvection (a : matrice ; i,j : Integer ; l : Real);
begin
	for n := 0 to high(a[0]) do
	begin
		a[i,n] := a[i,n] + l*a[j,n];
	end;
end;

// Pour des raisons de stabilité numérique, on recherche le pivot de valeur absolue maximale.
function recherchePivotLigne(a : matrice; i : Integer) : Integer;
begin
	x := abs(a[i,i]);
	recherchePivotLigne := 0;
	for n := i to high(a) do
		begin
			y := abs(a[n,i]);
			if ((x < abs(a[n,i])) and (y <> 0)) or (x = 0) then 
			begin
				recherchePivotLigne := n;
				x := y;
			end;
		end;
end;

procedure affichageTableau(a : matrice);
begin
	for n := -1 to high(a) do
		begin
		for m := -1 to high(a[0]) do
			begin
				if ((n = -1) and (m = -1)) then 
					write('   ')
				else if ((n = -1) and (m <> -1)) and (m <> high(a[0])) then 
					write('x',m+1,'   	       	  ')
				else if (n = -1) and (m = high(a[0])) then 
					write('λ')
				else if (n <> -1) and (m = -1) then
					write(n+1)
				else
					write(' ',a[n,m]:17:16);		
			end;
			writeln();
		end;
end;

procedure matriceEchelonne(a : matrice);
begin
	//itérations pour obtenir le système echelonné
	j := 1;
	for i := 0 to high(a)-1 do
	begin
		//passer en 1er ligne le pivot pour faciliter les calculs
		n := recherchePivotLigne(a,i);
		if n <> 0 then changementLigne(a,i,n);
		//ligne à itérer
		for k := i+1 to high(a) do
		begin
			if a[i,i] <> 0 then
			begin
				l := -a[k,i]/a[i,i];
				transvection(a,k,i,l);
				writeln('');
				writeln(j,'e etape :');
				affichageTableau(a);
				j := j+1;
			end;
		end;
	end;
	writeln('');
end;

procedure reponse(a : matrice; b : vecteur);
begin
	for n := high(a) downto 0 do
	begin
		somme := 0;
		for m := n+1 to high(a[0])-1 do
			begin
				somme := a[n,m]*b[m] + somme;		
			end;
		if a[n,n] <> 0 then	b[n] := (a[n,high(a[0])]-somme)/a[n,n]
		else SetLength(b,n);
	end;
	writeln('Les reponses sont:');
	for k := 0 to high(b) do 
	begin
		write('x',k+1,' = ',b[k]:17:16,'	');
	end;
	writeln('');
	writeln('');
end;

procedure mineursPrincipaux(a : matrice; b : vecteur);
begin
	for i := 0 to high(a) do 
	begin
		if (a[i][i] <> 0) then b[i] := a[i][i]
		else SetLength(b,i);
	end;
	writeln('Les mineurs principaux sont:');
	for k := 0 to high(b) do 
	begin
		write('m',k+1,' = ',b[k]:17:16,'	');
	end;
end;

end.
